//
//  GoalSettingController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/29/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import "GoalSettingController.h"
#import "Goal.h"

@implementation GoalSettingController

@synthesize objectiveType, objectiveId, heading, text;

-(IBAction)submit {
	Goal *goal = [[Goal alloc] init];
	goal.repetitions = repetitions.text;
	goal.days = days.text;
	goal.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
	goal.objectiveId = objectiveId;
	goal.objectiveType = objectiveType;
	
	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.talktoher.submission", NULL);
	dispatch_async(queue, ^{
		if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
			[goal createRemote];
		}
	});
	dispatch_release(queue);
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithObjective:(NSObject *)objective {
    if ((self = [super initWithNibName:nil bundle:nil])) {
		self.objectiveId = [objective getRemoteId];
		self.objectiveType = [[objective className] substringToIndex:[[objective className] length] - 6];
		self.text = [objective full_text];
		
		self.heading = [[UILabel alloc] initWithFrame:CGRectMake(6,5,308,21)];
		heading.textAlignment = UITextAlignmentCenter;
		heading.textColor = [UIColor whiteColor];
		heading.font = [UIFont fontWithName:@"TrebuchetMS" size:18];
		heading.shadowColor = [UIColor blackColor];
		heading.opaque = NO;
		heading.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		
		if ([objectiveType isEqualToString:@"Exercise"]) {
			heading.text = @"Setting a goal: to do an exercise";
		} else if ([objectiveType isEqualToString:@"Line"]) {
			heading.text = @"Setting a goal: to try a line";
		} else if ([objectiveType isEqualToString:@"Tip"]) {
			heading.text = @"Setting a goal: to use a tip";
		}	
	}
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
	description.text = text;
	description.font = [UIFont fontWithName:@"TrebuchetMS" size:16];
	description.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	[self.view addSubview:heading];
	[repetitions becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.objectiveId = nil;
	self.objectiveType = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
