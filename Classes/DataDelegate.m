//
//  DataDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "DataDelegate.h"
#import "ObjectiveResourceConfig.h"
#import <dispatch/dispatch.h>
#import "ContentDelegate.h"
#import "Reachability.h"
#import "GoalOwnership.h"

@implementation DataDelegate

@synthesize userId, server_location, class_names, lines, tips, exercises, goals;

#pragma mark -
#pragma mark initialization

-(void)initialize_constants {
	self.class_names = [NSDictionary dictionaryWithObjectsAndKeys:@"Line", @"lines", @"Tip", @"tips", @"Exercise", @"exercises", @"GoalOwnership", @"goals", @"Rating", @"ratings", @"Tag", @"tags", @"Comment", @"comments", nil];
	self.server_location = @"http://lineoftheday.com/";//@"http://localhost:3000/";//
	[ObjectiveResourceConfig setSite:server_location];
	connectionIsFresh = NO;
}

-(void)initialize_content {
	self.lines = [[ContentDelegate alloc] initWithContentType:@"Line"];
	self.tips = [[ContentDelegate alloc] initWithContentType:@"Tip"];
	self.exercises = [[ContentDelegate alloc] initWithContentType:@"Exercise"];
	self.goals = [[ContentDelegate alloc] initWithContentType:@"GoalOwnership"];
}

#pragma mark -
#pragma mark fetching from core data

-(NSArray *)fetch_collection:(NSString *)type {
	NSEntityDescription *e = [NSEntityDescription entityForName:type inManagedObjectContext:[self moc]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	
	[f setEntity:e];
	[f setFetchBatchSize:30];
	[f setPredicate:[NSPredicate predicateWithFormat:@"hidden == %d", 0]];
	[f setPropertiesToFetch:[self propertiesToFetchForType:type]];
    
	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];
	
	return results;
}

#pragma mark -
#pragma mark downloading

-(void)loadRemoteDataOfTypes:(NSArray *)types forCellDelegate:(UITableViewController *)cell_controller {
	if ([self lotd_is_reachable]) {
		[self loadDataSegmentOfType:@"lines" andAlertCell:[cell_controller lines_cell]];
		[self loadDataSegmentOfType:@"tips" andAlertCell:[cell_controller tips_cell]];
		[self loadDataSegmentOfType:@"exercises" andAlertCell:[cell_controller exercises_cell]];
	}	
}

-(void)loadDataSegmentOfType:(NSString *)type andAlertCell:(LoaderCell *)cell {
	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.talktoher.fetch", NULL);
	dispatch_async(queue, ^{
		NSArray *content = nil;
		dispatch_async(dispatch_get_main_queue(), ^{
			[cell start_spinning];
		});
		for (int i = 0; i < 4; i++) {
			if (content == nil || [content count] == 0) {
				@try {
					if ([type isEqualToString:@"goals"]) {
						content = [GoalOwnership findAllForUserWithId:userId];
					} else {
						content = [NSClassFromString([class_names objectForKey:type]) findAllRemote];
					}
				}
				@catch (NSException *e) {
					NSLog(@"server did not serve data");
				}
			}
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[cell stop_spinning];
			if (!(content == nil || [content count] == 0)) {
				[self persistData:content ofType:type];
				[self increment:[class_names objectForKey:type] multiple:YES];
			}
		});
	});
	dispatch_release(queue);
}

#pragma mark -
#pragma mark persistence and uniqueness

-(void)persistData:(NSArray *)data ofType:(NSString *)type {
	NSArray *unidentified_set = [self unidentified_set_of_type:type];
	for (NSObject *c in data) {
		NSManagedObject *e = [self itemExistsInStore:c];
		if (e) {  
			// this object is already in the CoreData db and should be updated
			[e updateWith:c];
		} else {
			NSManagedObject *identifiable = [self item:c existsInSet:unidentified_set];
			if (identifiable) {
                // this object is in the db without an id
				[identifiable setValue:[NSNumber numberWithInt:[[c getRemoteId] integerValue]] forKey:[c getRemoteClassIdName]];
			} else {
				[c persistInMoc:[self moc]];
			}
		}
	}
    
    NSError *error = nil;
    if (![[self moc] save:&error]) { NSLog(@"Unresolved error %@, %@", error, [error userInfo]); }
}

-(NSManagedObject *)itemExistsInStore:(NSObject *)item {
    NSEntityDescription *e;
    if ([[[[item class] superclass] className] isEqualToString:@"NSManagedObject"]) {
        e = [item entity];
    } else {
       e = [NSEntityDescription entityForName:[item className] inManagedObjectContext:[self moc]];
    }
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	[f setEntity:e];
	[f setPredicate:[NSPredicate predicateWithFormat:[[item getRemoteClassIdName] stringByAppendingFormat:@" == %@", 
                                                      [NSNumber numberWithInt:[[item getRemoteId] integerValue]]]]];

	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];

	NSManagedObject *exists = nil;
	if ([results count] > 0)
		exists = [results objectAtIndex:0];
	return exists;
}

-(NSManagedObject *)item:(NSObject *)i existsInSet:(NSArray *)us {
	NSManagedObject *matched = nil;
	for (NSManagedObject *c in us) {
		if ([i matches:c]) {
			matched = c;
			break;
		}
	}
	return matched;
}

-(NSArray *)unidentified_set_of_type:(NSString *)type {
	NSEntityDescription *e = [NSEntityDescription entityForName:[class_names objectForKey:type] inManagedObjectContext:[self moc]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	[f setEntity:e];
	[f setPropertiesToFetch:[self propertiesToFetchForType:[class_names objectForKey:type]]];
	[f setPredicate:[NSPredicate predicateWithFormat:[[NSClassFromString([class_names objectForKey:type]) getRemoteClassIdName] stringByAppendingFormat:@" == %d", nil]]];
	
	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];
	return results;
}

-(NSManagedObjectContext *)moc {
	[[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark -
#pragma mark identity control

-(void)setMyUserId:(NSString *)user_id forUsername:(NSString *)user_name withPassword:(NSString *)password {
	NSEntityDescription *e = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self moc]];
	NSManagedObject *userObject = [NSEntityDescription insertNewObjectForEntityForName:[e name] inManagedObjectContext:[self moc]];
	[userObject setValue:[NSNumber numberWithInt:[user_id integerValue]] forKey:@"userId"];
	[userObject setValue:user_name forKey:@"username"];
	[userObject setValue:password forKey:@"password"];
	
	NSError *error = nil;
    if (![[self moc] save:&error]) { NSLog(@"Unresolved error %@, %@", error, [error userInfo]); }
	[self attemptIdentification];
}

-(void)attemptIdentification {
	NSEntityDescription *e = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self moc]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	[f setEntity:e];
	[f setPropertiesToFetch:[NSArray arrayWithObjects:@"userId", @"username", nil]];

	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];
	
	if ([results count] > 0) {
		self.userId = [[results objectAtIndex:0] valueForKey:@"userId"];
		[self loadDataSegmentOfType:@"goals" andAlertCell:[[[[[UIApplication sharedApplication] delegate] navigationController] bottomViewController] goals_cell]];
	}
}

#pragma mark -
#pragma mark connectivity control

-(void)attemptDelayedSubmissions {
	NSArray *classes = [class_names allValues];
	for (NSString *klass in classes) {
		NSEntityDescription *e = [NSEntityDescription entityForName:klass inManagedObjectContext:[self moc]];
		NSFetchRequest *f = [[NSFetchRequest alloc] init];
		[f setEntity:e];
		[f setPredicate:[NSPredicate predicateWithFormat:@"delayed = YES"]];
		
		NSError *error = nil;
		NSArray *results = [[self moc] executeFetchRequest:f error:&error];
		[f release];
		for (NSManagedObject *o in results) {
			NSError *saveError = nil;
			if ([[o objectiveResource] createRemoteWithResponse:&saveError]) {
				[o hasBeenSubmitted];
			}
		}
	}
	
	NSError *mocSaveError = nil;
    if (![[self moc] save:&mocSaveError]) { NSLog(@"Unresolved error %@, %@", mocSaveError, [mocSaveError userInfo]); }
}

-(BOOL)lotd_is_reachable {
	BOOL currentlyReachable;
	Reachability *r = [Reachability reachabilityWithHostName:server_location];
	
	currentlyReachable = [r isReachable];
	
	if (currentlyReachable && connectionIsFresh) {
		connectionIsFresh = NO;
	} else {
		connectionIsFresh = YES;
	}

	if (connectionIsFresh && currentlyReachable) {
		[self attemptDelayedSubmissions];
	}
	
	return currentlyReachable;
}

#pragma mark -
#pragma mark content adjustment

-(void)increment:(NSString *)type multiple:(BOOL)multiple{
	if ([type isEqualToString:@"Line"]) {
		[lines update_content:multiple];
	} else if ([type isEqualToString:@"Tip"]) {
		[tips update_content:multiple];
	} else if ([type isEqualToString:@"Exercise"]) {
		[exercises update_content:multiple];
	} else if ([type isEqualToString:@"GoalOwnership"]) {
		[goals update_content:multiple];
	}
}

-(void)insertNewElement:(NSManagedObject *)e multiple:(BOOL)multiple {
	if ([[e className] isEqualToString:@"LineEntity"]) {
		[lines insertNewContent:multiple];
	} else if ([[e className] isEqualToString:@"TipEntity"]) {
		[tips insertNewContent:multiple];
	} else if ([[e className] isEqualToString:@"ExerciseEntity"]) {
		[exercises insertNewContent:multiple];
	} else if ([[e className] isEqualToString:@"GoalOwnershipEntity"]) {
		[goals insertNewContent:multiple];
	}
}

#pragma mark -
#pragma mark schema information

-(NSString *)classNameFor:(NSString *)identifier {
	return [class_names objectForKey:identifier];
}

-(NSArray *)propertiesToFetchForType:(NSString *)type {
	NSArray *properties;
	if (type == @"Line") {
		properties = [NSArray arrayWithObjects:@"phrasing", @"lineId", nil];
	} else if (type == @"Tip") {
		properties = [NSArray arrayWithObjects:@"advice", @"tipId", nil];
	} else if (type == @"Exercise") {
		properties = [NSArray arrayWithObjects:@"instruction", @"moniker", @"exerciseId", nil];
	} else if (type == @"GoalOwnership") {
		properties = [NSArray arrayWithObjects:@"goalOwnershipId", @"derivedDescription", @"complete", @"progress", @"completionStatus", @"remainingDaysText", @"repetitions", nil];
	} else if (type == @"Comment") {
		properties = [NSArray arrayWithObjects:@"commentId", @"text", @"targetType", @"targetId", nil];
	} else if (type == @"Rating") {
		properties = [NSArray arrayWithObjects:@"ratingId", @"opinion", @"targetType", @"targetId", nil];
	} else if (type == @"Tag") {
		properties = [NSArray arrayWithObjects:@"tagId", @"subjectId", @"subjectType", @"targetType", @"targetId", nil];
	}
	return properties;
}

@end
