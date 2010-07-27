//
//  Exercise.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Exercise.h"
#import "ObjectiveResourceConfig.h"
#import "ExerciseEntity.h"

@implementation Exercise

@synthesize exerciseId, moniker, instruction, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating, userId;
-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    instruction = [ps instruction];
	moniker = [ps moniker];
    userId = [ps userId];
    
    return self;
}

-(BOOL)matches:(NSManagedObject *)po {
    return [instruction isEqualToString:[po valueForKey:@"instruction"]] && 
			[moniker isEqualToString:[po valueForKey:@"moniker"]];
}

-(ExerciseEntity *)persistantSelfInMoc:(NSManagedObjectContext *)moc {
    ExerciseEntity *ps = [[ExerciseEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:instruction forKey:@"instruction"];
	[ps setValue:moniker forKey:@"moniker"];
    [ps setValue:[NSNumber numberWithInt:[exerciseId integerValue]] forKey:@"exerciseId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    return ps;
}

-(id)get_commentary {
	[ObjectiveResourceConfig setProtocolExtension:@"/inspect_content"];
	Exercise *exercise = [Exercise findRemote:[self exerciseId]];
	[ObjectiveResourceConfig setProtocolExtension:@".xml"];
	return exercise;
}

-(NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"commentCount", @"tagCount", @"ratingCount", @"recentComment", @"recentTags", @"averageRating", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}

@end
