//
//  RatingEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "RatingEntity.h"
#import "Rating.h"

@implementation RatingEntity

-(Rating *)objectiveResource {
	return [[Rating alloc] initWithManagedObject:self];
}

-(NSString *)getRemoteClassIdName {
    return @"ratingId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

-(BOOL)matches:(NSManagedObject *)po {
	return ([[self targetId] integerValue] == [[po targetId] integerValue]) &&
	[[self targetType] isEqualToString:[po targetType]] &&
	([[self userId] integerValue] == [[po userId] integerValue]) &&
	([[self opinion] integerValue] == [[po opinion] integerValue]);
}

-(void)updateWith:(Rating *)c {
	[self setValue:[NSNumber numberWithInt:[[c opinion] integerValue]] forKey:@"opinion"];
}

@end
