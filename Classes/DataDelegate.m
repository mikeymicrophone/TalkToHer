//
//  DataDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "DataDelegate.h"
#import "ObjectiveResourceConfig.h"

@implementation DataDelegate

@synthesize lines, tips, goals, exercises, userId, server_location, moc, class_names;

-(void)initialize_data {
	self.server_location = @"http://lineoftheday.com/";//@"http://localhost:3000/";//
	[ObjectiveResourceConfig setSite:server_location];
	self.lines = [[NSMutableArray alloc] init];
	self.tips = [[NSMutableArray alloc] init];
	self.goals = [[NSMutableArray alloc] init];
	self.exercises = [[NSMutableArray alloc] init];
	
	self.class_names = [NSDictionary dictionaryWithObjectsAndKeys:@"Line", @"lines", @"Tip", @"tips", @"Exercise", @"exercises", @"Goal", @"goals", nil];
}

-(NSArray *)fetch_collection:(NSString *)type {
	NSEntityDescription *e = [NSEntityDescription entityForName:[class_names objectForKey:type] inManagedObjectContext:moc];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	[f setEntity:e];
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:f error:&error];
	return results;
}

-(void)addAndPersistData:(NSArray *)data ofType:(NSString *)type {
	[[self performSelector:NSSelectorFromString(type)] addObjectsFromArray:data];
	
	// Create a new instance of the entity managed by the fetched results controller.
    NSEntityDescription *entity = [NSEntityDescription entityForName:[class_names objectForKey:type] inManagedObjectContext:moc];
	
	for (NSManagedObject *c in data) {
		NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:moc];
    
		// If appropriate, configure the new managed object.
		if ([c respondsToSelector:@selector(phrasing)]) {
			[newManagedObject setValue:[c phrasing] forKey:@"phrasing"];
			[newManagedObject setValue:[c lineId] forKey:@"lineId"];
		} else if ([c respondsToSelector:@selector(advice)]) {
			[newManagedObject setValue:[c advice] forKey:@"advice"];
			[newManagedObject setValue:[c tipId] forKey:@"tipId"];
			NSLog(@"tip status: %@", [newManagedObject advice]);
		} else if ([c respondsToSelector:@selector(instruction)]) {
			[newManagedObject setValue:[c instruction] forKey:@"instruction"];
			[newManagedObject setValue:[c name] forKey:@"name"];
			[newManagedObject setValue:[c exerciseId] forKey:@"exerciseId"];
		}
		[newManagedObject setValue:[c userId] forKey:@"userId"];
	}
    
    // Save the context.
    NSError *error = nil;
    if (![moc save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
