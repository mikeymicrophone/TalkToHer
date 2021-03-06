//
//  GoalOwnershipEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Charismatic Comfort. All rights reserved.
//

#import "GoalOwnershipEntity.h"
#import "GoalOwnership.h"

@implementation GoalOwnershipEntity

-(NSString *)main_text {
	return [self derivedDescription];
}

-(NSString *)additional_text {
	return [[[self completionStatus] stringByAppendingString:@"\n"] stringByAppendingString:[self remainingDaysText]];
}

-(NSString *)getRemoteClassIdName {
    return @"goalOwnershipId";
}

-(GoalOwnership *)objectiveResource {
	return [[GoalOwnership alloc] initWithManagedObject:self];
}

-(void)updateWith:(GoalOwnership *)g {
	[self setDerivedDescription:[g derivedDescription]];
	[self setProgress:[g progress]];
	[self setComplete:[NSNumber numberWithInt:[[g complete] integerValue]]];
	[self setCompletionStatus:[g completionStatus]];
	[self setRemainingDaysText:[g remainingDaysText]];
	[self setRepetitions:[NSNumber numberWithInt:[[g repetitions] integerValue]]];
}

@end
