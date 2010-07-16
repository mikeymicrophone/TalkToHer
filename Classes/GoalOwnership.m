//
//  GoalOwnership.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "GoalOwnership.h"

@implementation GoalOwnership

@synthesize goalOwnershipId, derivedDescription, progress, complete, userId;

-(NSString *)main_text {
	return derivedDescription;
}

-(NSString *)additional_text {
	return @"";
}

@end
