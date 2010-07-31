//
//  InfoController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InfoController.h"


@implementation InfoController

@synthesize about;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	about.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
	about.textColor = [UIColor whiteColor];
	about.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}

-(IBAction)dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)sinns {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://sinnsofattraction.blogspot.com"]];
}

-(IBAction)approach_anxiety {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://approachanxiety.com"]];
}

-(IBAction)lotd {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://lineoftheday.com"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
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
