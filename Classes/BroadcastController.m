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
	display.numberOfLines = 10;
	display.textAlignment = UITextAlignmentCenter;
	NSLog(@"display1: %@", display);
	display.textColor = [UIColor blackColor];
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
}

- (void)viewDidLoad {
}

-(void)viewWillAppear:(BOOL)animated {
	CGSize drawnSize = CGSizeMake(480, 500);
	NSInteger fontSize;
	NSLog(@"drawn: %f, view: %f", drawnSize.height, self.view.frame.size.height);
	for (fontSize = 86; drawnSize.height > self.view.frame.size.width; fontSize--) {
		drawnSize = [display.text sizeWithFont:[UIFont fontWithName:@"TrebuchetMS" size:fontSize] constrainedToSize:self.view.frame.size lineBreakMode:UILineBreakModeWordWrap];
		NSLog(@"size: %@", NSStringFromCGSize(drawnSize));
	}
	display.font = [UIFont fontWithName:@"TrebuchetMS" size:fontSize];
	NSLog(@"display2: %@", display);
	[self.view addSubview:display];	
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
