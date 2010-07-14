//
//  Goal.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Goal.h"


@implementation Goal

@synthesize goalId, derivedDescription, progress, complete;

-(NSString *)main_text {
	return derivedDescription;
}

-(NSString *)additional_text {
	return @"";
}

@end
