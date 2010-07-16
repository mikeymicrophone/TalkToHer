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

@implementation DataDelegate

@synthesize userId, server_location, moc, class_names;

-(void)initialize_data {
	self.server_location = @"http://localhost:3000/";//@"http://lineoftheday.com/";//
	[ObjectiveResourceConfig setSite:server_location];
	
	self.class_names = [NSDictionary dictionaryWithObjectsAndKeys:@"Line", @"lines", @"Tip", @"tips", @"Exercise", @"exercises", @"GoalOwnership", @"goals", nil];
}

-(NSArray *)fetch_collection:(NSString *)type {
	NSEntityDescription *e = [NSEntityDescription entityForName:[class_names objectForKey:type] inManagedObjectContext:moc];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];

	[f setEntity:e];
	[f setFetchBatchSize:30];
	[f setPropertiesToFetch:[self propertiesToFetchForType:type]];

	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:f error:&error];
	[f release];
	return results;
}

-(NSArray *)propertiesToFetchForType:(NSString *)type {
	NSArray *properties;
	if (type == @"lines") {
		properties = [NSArray arrayWithObjects:@"phrasing", @"lineId", nil];
	} else if (type == @"tips") {
		properties = [NSArray arrayWithObjects:@"advice", @"tipId", nil];
	} else if (type == @"exercises") {
		properties = [NSArray arrayWithObjects:@"instruction", @"moniker", @"exerciseId", nil];
	} else if (type == @"goals") {
		properties = [NSArray arrayWithObjects:@"goalOwnershipId", @"derivedDescription", @"complete", @"progress", nil];
	}
   return properties;
}

-(void)addAndPersistData:(NSArray *)data ofType:(NSString *)type {
	// Create a new instance of the entity managed by the fetched results controller.
    NSEntityDescription *entity = [NSEntityDescription entityForName:[class_names objectForKey:type] inManagedObjectContext:moc];
	for (NSManagedObject *c in data) {
		if ([self itemExistsInStore:c]) {
			// this object is already in the CoreData db
		} else {
			NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:moc];

			// If appropriate, configure the new managed object.
			if ([c respondsToSelector:@selector(phrasing)]) {
				[newManagedObject setValue:[c phrasing] forKey:@"phrasing"];
				[newManagedObject setValue:[c lineId] forKey:@"lineId"];
			} else if ([c respondsToSelector:@selector(advice)]) {
				[newManagedObject setValue:[c advice] forKey:@"advice"];
				[newManagedObject setValue:[c tipId] forKey:@"tipId"];
			} else if ([c respondsToSelector:@selector(instruction)]) {
				[newManagedObject setValue:[c instruction] forKey:@"instruction"];
				[newManagedObject setValue:[c moniker] forKey:@"moniker"];
				[newManagedObject setValue:[c exerciseId] forKey:@"exerciseId"];
			} else if ([c respondsToSelector:@selector(derivedDescription)]) {
				[newManagedObject setValue:[c derivedDescription] forKey:@"derivedDescription"];
				[newManagedObject setValue:[c complete] forKey:@"complete"];
				[newManagedObject setValue:[c progress] forKey:@"progress"];
				NSLog(@"set progress");
				[newManagedObject setValue:[NSNumber numberWithInt:[[c goalOwnershipId] integerValue]] forKey:@"goalOwnershipId"];
				NSLog(@"attributes set");
			}
			[newManagedObject setValue:[NSNumber numberWithInt:[[c userId] integerValue]] forKey:@"userId"];
		}
	}
    
    // Save the context.
    NSError *error = nil;
    if (![moc save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
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
		while (content == nil || [content count] == 0) {
			if ([type isEqualToString:@"goals"]) {
				[ObjectiveResourceConfig setSite:[server_location stringByAppendingFormat:@"users/%d/", [[self userId] integerValue]]];
			}
			content = [objc_getClass([[self.class_names objectForKey:type] cStringUsingEncoding:NSASCIIStringEncoding]) findAllRemote];
			if ([type isEqualToString:@"goals"]) {
				[ObjectiveResourceConfig setSite:server_location];
			}
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[cell stop_spinning];
			[self addAndPersistData:content ofType:type];
		});
	});
	dispatch_release(queue);
}

-(BOOL)itemExistsInStore:(NSManagedObject *)item {
	NSEntityDescription *e = [NSEntityDescription entityForName:[item className] inManagedObjectContext:moc];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	[f setEntity:e];
	[f setPredicate:[NSPredicate predicateWithFormat:[[item getRemoteClassIdName] stringByAppendingFormat:@" == %d", 
					 [[item performSelector:NSSelectorFromString([item getRemoteClassIdName])] integerValue]]]];

	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:f error:&error];
	[f release];
	
	BOOL exists = NO;
	if ([results count] > 0)
		exists = YES;

	return exists;
}

@end
