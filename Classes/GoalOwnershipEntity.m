//
//  GoalOwnershipEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import "GoalOwnershipEntity.h"


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

@end
