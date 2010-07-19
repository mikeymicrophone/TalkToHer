//
//  GoalOwnership.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "GoalOwnership.h"

@implementation GoalOwnership

@synthesize goalOwnershipId, derivedDescription, progress, complete, completionStatus, remainingDaysText, userId;

-(NSString *)main_text {
	return derivedDescription;
}

-(NSString *)additional_text {
	return [[completionStatus stringByAppendingString:@"\n"] stringByAppendingString:remainingDaysText];
}

-(NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"derivedDescription", @"completionStatus", @"remainingDaysText", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}

- (void)awakeFromFetch {
	[super awakeFromFetch];
	NSLog(@"awake from fetch has been called");
	derivedDescription = [self valueForKey:@"derivedDescription"];
	progress = [self valueForKey:@"progress"];
	complete = [self valueForKey:@"complete"];
	completionStatus = [self valueForKey:@"completionStatus"];
	remainingDaysText = [self valueForKey:@"remainingDaysText"];
	userId = [self valueForKey:@"userId"];
}

//-(void)setProgress:(NSString *)p {
//	if (p != nil) {
//		NSLog(@"progress setter called with: %@", p);
//	}
//	progress = p;
//}

@end
