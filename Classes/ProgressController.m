//
//  ProgressController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/16/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ProgressController.h"
#import "GoalOwnership.h"

@implementation ProgressController

@synthesize description, new_progress, previous_progress, goalOwnership;

- (id)initWithGoal:(GoalOwnership *)goal {
    if (!(self = [super initWithNibName:nil bundle:nil]))
		return nil;
	
	self.goalOwnership = goal;

    return self;
}

-(IBAction)update {
	[goalOwnership setProgress:[[NSNumber numberWithInt:[self.new_progress.text integerValue] + [goalOwnership.progress integerValue]] stringValue]];
	[goalOwnership setCompletionStatus:[NSString stringWithFormat:@"%@%% complete", [NSNumber numberWithFloat:100*[[goalOwnership progress] floatValue] / [[goalOwnership repetitions] floatValue]]]];
	NSError *error = nil;
	[[[[[UIApplication sharedApplication] delegate] data_source] moc] save:&error];
	[[goalOwnership objectiveResource] updateRemote];
	[[self parentViewController] popViewControllerAnimated:YES];
	
	[[[[[UIApplication sharedApplication] delegate] data_source] goals] update_content];
	NSLog(@"nav controller: %@", [[[[[UIApplication sharedApplication] delegate] navigationController] topViewController] tableView]);
	[[[[[[UIApplication sharedApplication] delegate] navigationController] topViewController] tableView] reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	description.text = [goalOwnership derivedDescription];
	description.font = [UIFont fontWithName:@"TrebuchetMS" size:16];
	description.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	previous_progress.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	plus.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	if (![[goalOwnership progress] isEqualToString:@""]) {
		previous_progress.text = [goalOwnership progress];
	} else {
		previous_progress.text = @"0";
	}
	[new_progress becomeFirstResponder];
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
	self.description = nil;
	self.previous_progress = nil;
	self.new_progress = nil;
	self.goalOwnership = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
