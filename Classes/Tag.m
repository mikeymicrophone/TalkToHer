//
//  Tag.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Tag.h"
#import "TagEntity.h"
#import <CoreData/CoreData.h>

@implementation Tag

@synthesize concept, targetType, targetId, tagId, userId;

-(Tag *)initWithManagedObject:(TagEntity *)ps {
	[self init];
    
    self.concept = [ps concept];
	self.targetId = [ps targetId];
	self.targetType = [ps targetType];
    self.userId = [ps userId];
	self.tagId = [ps tagId];
    
    return self;	
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    TagEntity *ps = [[TagEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:targetType	forKey:@"targetType"];
	[ps setValue:concept forKey:@"concept"];
	[ps setValue:[NSNumber numberWithInt:[targetId integerValue]] forKey:@"targetId"];
    [ps setValue:[NSNumber numberWithInt:[tagId integerValue]] forKey:@"tagId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
	if ([tagId integerValue] == 0) {
		[ps markForDelayedSubmission];
	}
	
	NSError *mocSaveError = nil;
    if (![moc save:&mocSaveError]) { NSLog(@"Unresolved error %@, %@", mocSaveError, [mocSaveError userInfo]); }
    [ps release];
}

@end
