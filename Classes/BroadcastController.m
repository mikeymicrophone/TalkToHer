//
//  BroadcastController.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
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
	display.textColor = [UIColor blackColor];
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
}

-(void)viewWillAppear:(BOOL)animated {
	CGSize drawnSize = CGSizeMake(480, 500);
	NSInteger fontSize;
	for (fontSize = 86; drawnSize.height > self.view.frame.size.width; fontSize--) {
		drawnSize = [display.text sizeWithFont:[UIFont fontWithName:@"TrebuchetMS" size:fontSize] constrainedToSize:self.view.frame.size lineBreakMode:UILineBreakModeWordWrap];
	}
	display.font = [UIFont fontWithName:@"TrebuchetMS" size:fontSize];
	[self.view addSubview:display];
	
	UIButton *x = [UIButton buttonWithType:UIButtonTypeCustom];
	[x setTitle:@"x" forState:UIControlStateNormal];
	x.frame = CGRectMake(430, 250, 44, 44);
	[x setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:UIControlStateNormal];
	[x addTarget:self action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:x];
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
