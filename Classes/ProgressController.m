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
	[goalOwnership setProgress:[[NSNumber numberWithInt:[self.new_progress.text intValue] + [goalOwnership.progress intValue]] stringValue]];
	NSError *error = nil;
	[[[[[UIApplication sharedApplication] delegate] data_source] moc] save:&error];
	[[goalOwnership objectiveResource] updateRemote];
	[[self parentViewController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	description.text = [goalOwnership derivedDescription];
	if ([goalOwnership progress]) {
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
