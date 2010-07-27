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

@implementation DataDelegate

@synthesize userId, server_location, class_names, lines, tips, exercises, goals;

-(void)initialize_constants {
	self.class_names = [NSDictionary dictionaryWithObjectsAndKeys:@"Line", @"lines", @"Tip", @"tips", @"Exercise", @"exercises", @"GoalOwnership", @"goals", nil];//] @"Line", @"Line", @"Tip", @"Tip", @"Exercise", @"Exercise", @"GoalOwnership", @"GoalOwnership", nil];
	self.server_location = @"http://localhost:3000/";//@"http://lineoftheday.com/";//
	[ObjectiveResourceConfig setSite:server_location];
	connectionIsFresh = NO;
}

-(void)initialize_content {
	self.lines = [[ContentDelegate alloc] initWithContentType:@"Line"];
	self.tips = [[ContentDelegate alloc] initWithContentType:@"Tip"];
	self.exercises = [[ContentDelegate alloc] initWithContentType:@"Exercise"];
	self.goals = [[ContentDelegate alloc] initWithContentType:@"GoalOwnership"];
}

-(NSString *)classNameFor:(NSString *)identifier {
	return [class_names objectForKey:identifier];
}

-(void)loadRemoteDataOfTypes:(NSArray *)types forCellDelegate:(UITableViewController *)cell_controller {
	if ([self lotd_is_reachable]) {
		[self loadDataSegmentOfType:@"lines" andAlertCell:[cell_controller lines_cell]];
		[self loadDataSegmentOfType:@"tips" andAlertCell:[cell_controller tips_cell]];
		[self loadDataSegmentOfType:@"exercises" andAlertCell:[cell_controller exercises_cell]];
	}	
}

-(NSArray *)fetch_collection:(NSString *)type {
	NSLog(@"entering DataDelegate fetch_collection");
	NSEntityDescription *e = [NSEntityDescription entityForName:type inManagedObjectContext:[self moc]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];

	[f setEntity:e];
	[f setFetchBatchSize:30];
	if ([type isEqualToString:@"GoalOwnership"]) {
		[f setPredicate:[NSPredicate predicateWithFormat:@"userId == %d", userId]];
	}
	[f setPropertiesToFetch:[self propertiesToFetchForType:type]];
    
	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];
	NSLog(@"class_names: %@, type: %@, keys %@", class_names, type, [class_names allKeys]);
	[[self performSelector:NSSelectorFromString([[class_names allKeysForObject:type] objectAtIndex:0])] addObjectsFromArray:results];
	NSLog(@"exiting  DataDelegate fetch_collection");
	return results;
}

-(NSArray *)unidentified_set_of_type:(NSString *)type {
	NSLog(@"entering DataDelegate unidentified_set_of_type: %@", type);
	if (class_names == nil ) { 
		NSLog(@"no class_names");
	} else {
		NSLog(@"class_names: %@", class_names);
		NSLog(@"class_names type is %@", [class_names className]); 
	}
	NSEntityDescription *e = [NSEntityDescription entityForName:[class_names objectForKey:type] inManagedObjectContext:[self moc]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];

	[f setEntity:e];
	[f setPropertiesToFetch:[self propertiesToFetchForType:[class_names objectForKey:type]]];
	[f setPredicate:[NSPredicate predicateWithFormat:[[NSClassFromString([class_names objectForKey:type]) getRemoteClassIdName] stringByAppendingFormat:@" == %d", nil]]];

	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];

	NSLog(@"exiting  DataDelegate unidentified_set_of_type");
	return results;
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
		properties = [NSArray arrayWithObjects:@"goalOwnershipId", @"derivedDescription", @"complete", @"progress", @"completionStatus", @"remainingDaysText", nil];
	}
   return properties;
}

-(void)persistData:(NSArray *)data ofType:(NSString *)type {
	NSLog(@"entering DataDelegate persistData:ofType");
	NSArray *unidentified_set = [self unidentified_set_of_type:type];

	for (NSObject *c in data) {
		NSManagedObject *e = [self itemExistsInStore:c];
		if (e) {  
			// this object is already in the CoreData db and should be updated
		} else {
			NSManagedObject *identifiable = [self item:c existsInSet:unidentified_set];
			if (identifiable) {
                // this object is in the db without an id
				[identifiable setValue:[c getRemoteId] forKey:[c getRemoteClassIdName]];
			} else {
				[c persistantSelfInMoc:[self moc]];
			}
		}
	}
    
    NSError *error = nil;
    if (![[self moc] save:&error]) { NSLog(@"Unresolved error %@, %@", error, [error userInfo]); }
	NSLog(@"exiting  DataDelegate persistData:ofType");
}

-(void)loadDataSegmentOfType:(NSString *)type andAlertCell:(LoaderCell *)cell {
	NSLog(@"entering DataDelegate loadDataSegmentOfType:andAlertCell");
	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.talktoher.fetch", NULL);
	dispatch_async(queue, ^{
		NSArray *content = nil;
		dispatch_async(dispatch_get_main_queue(), ^{
			[cell start_spinning];
		});
		for (int i = 0; i < 4; i++) {
			if (content == nil || [content count] == 0) {
				if ([type isEqualToString:@"goals"]) {
					[ObjectiveResourceConfig setSite:[server_location stringByAppendingFormat:@"users/%d/", [[self userId] integerValue]]];
				}
				content = [NSClassFromString([class_names objectForKey:type]) findAllRemote];
				if ([type isEqualToString:@"goals"]) {
					[ObjectiveResourceConfig setSite:server_location];
				}
			}
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[cell stop_spinning];
			if (!(content == nil || [content count] == 0)) {
				[self persistData:content ofType:type];
			}
		});
	});
	dispatch_release(queue);
	NSLog(@"exiting  DataDelegate loadDataSegmentOfType:andAlertCell");
}

-(NSManagedObject *)itemExistsInStore:(NSObject *)item {
//	NSLog(@"entering DataDelegate itemExistsInStore");
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
//	NSLog(@"exiting  DataDelegate itemExistsInStore");	
	return exists;
}

-(NSManagedObject *)item:(NSObject *)i existsInSet:(NSArray *)us {
	NSLog(@"entering DataDelegate item:existsInSet");
	NSManagedObject *matched = nil;
	for (NSManagedObject *c in us) {
		if ([i matches:c]) {
			matched = c;
			break;
		}
	}
	NSLog(@"exiting  DataDelegate item:existsInSet");
	return matched;
}

-(void)setMyUserId:(NSString *)user_id forUsername:(NSString *)user_name {
	self.userId = user_id;
	NSEntityDescription *e = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self moc]];
	NSManagedObject *userObject = [NSEntityDescription insertNewObjectForEntityForName:[e name] inManagedObjectContext:[self moc]];
	[userObject setValue:user_id forKey:@"userId"];
	[userObject setValue:user_name forKey:@"username"];
	
	NSError *error = nil;
    if (![[self moc] save:&error]) { NSLog(@"Unresolved error %@, %@", error, [error userInfo]); }
}

-(void)attemptIdentification {
	NSLog(@"entering DataDelegate attemptIdentification");
	NSEntityDescription *e = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self moc]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	[f setEntity:e];
	[f setPropertiesToFetch:[NSArray arrayWithObjects:@"userId", @"username", nil]];

	NSError *error = nil;
	NSArray *results = [[self moc] executeFetchRequest:f error:&error];
	[f release];
	
	if ([results count] > 0)
		self.userId = [[results objectAtIndex:0] valueForKey:@"userId"];
	NSLog(@"exiting  DataDelegate attemptIdentification");
}

-(void)attemptDelayedSubmissions {
	NSLog(@"entering DataDelegate attemptDelayedSubmissions");
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
			[o saveRemoteWithResponse:&saveError];
			if (!saveError) {
				[o hasBeenSubmitted];
			}
		}
	}
	
	NSError *mocSaveError = nil;
    if (![[self moc] save:&mocSaveError]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", mocSaveError, [mocSaveError userInfo]);
    }
	NSLog(@"exiting  DataDelegate attemptDelayedSubmissions");
}

-(BOOL)lotd_is_reachable {
	BOOL currentlyReachable;
	Reachability *r = [Reachability reachabilityWithHostName:server_location];
	
	currentlyReachable = [r isReachable] || [server_location isEqualToString:@"http://localhost:3000/"];
	
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

-(NSManagedObjectContext *)moc {
	[[[UIApplication sharedApplication] delegate] managedObjectContext];
}

@end
