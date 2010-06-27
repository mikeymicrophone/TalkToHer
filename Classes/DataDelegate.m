//
//  DataDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "DataDelegate.h"
#import "Line.h"
#import	"Tip.h"
#import "Goal.h"
#import "Exercise.h"

@implementation DataDelegate

@synthesize lines, tips, goals, exercises;

-(void)initialize_data {
	lines = [[NSMutableArray alloc] init];
	Line *l = [[Line alloc] init];
	l.phrasing = @"Will you forgive me when I forget to walk the dog?";
	[lines addObject:l];
}

@end
