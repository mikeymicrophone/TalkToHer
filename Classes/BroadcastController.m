//
//  BroadcastController.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import "BroadcastController.h"

@implementation BroadcastController

@synthesize display;

-(id)initWithBroadcast:(NSString *)broadcast {
	if (!(self = [super initWithNibName:nil bundle:nil]))
		return nil;
	
	self.display = [[UILabel alloc] initWithFrame:self.view.frame];
	display.text = broadcast;
	display.lineBreakMode = UILineBreakModeWordWrap;
	display.numberOfLines = 20;
	display.textAlignment = UITextAlignmentCenter;
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
}

-(void)viewWillAppear:(BOOL)animated {
	CGSize drawnSize = CGSizeMake(480, 500);
	NSInteger fontSize;
	CGSize constrain = CGSizeMake(420, FLT_MAX);
	for (fontSize = 86; drawnSize.height > 300; fontSize--) {
		drawnSize = [display.text sizeWithFont:[UIFont fontWithName:@"TrebuchetMS" size:fontSize] constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
	}
	display.font = [UIFont fontWithName:@"TrebuchetMS" size:fontSize];
	[self.view addSubview:display];
	
	UIButton *x = [UIButton buttonWithType:UIButtonTypeCustom];
	[x setTitle:@"x" forState:UIControlStateNormal];
	x.frame = CGRectMake(430, 250, 44, 44);
	[x setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:UIControlStateNormal];
	[x addTarget:self action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:x];
	
	UIButton *flash = [UIButton buttonWithType:UIButtonTypeCustom];
	[flash setTitle:@"!" forState:UIControlStateNormal];
	flash.frame = CGRectMake(10, 250, 44, 44);
	[flash setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:UIControlStateNormal];
	[flash addTarget:self action:@selector(flashScreen) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:flash];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
	[self resignFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	[self flashScreen];
}

-(void)flashScreen {
	self.view.alpha = 0.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.7];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (UIInterfaceOrientationIsLandscape(interfaceOrientation));
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
}

- (void)dealloc {
    [super dealloc];
}

@end
