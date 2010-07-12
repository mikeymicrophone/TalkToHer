//
//  ContributionController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/3/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ContributionController.h"


@implementation ContributionController

@synthesize contentType, content, writtenContent;

-(id)initWithContentType:(NSString *)cType {
	if (![super initWithNibName:nil bundle:nil])
		return nil;
	
	[self setContentType:cType];
	[self prepare_content];
	return self;
}

-(void)prepare_content {
	self.content = [objc_getClass([contentType cStringUsingEncoding:NSASCIIStringEncoding]) alloc];
	NSLog(@"content of contribution controller is %@", content);
}

-(IBAction)submit_content {
	[self.content setWrittenContent:writtenContent.text];
	NSLog(@"about to save");
	NSLog(@"receiving object: %@", self.content);//, [self.content respondsToSelector:@selector(saveInRequest)]);
	[self.content saveInRequest];
	//	[self.content createRemote];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewDidAppear:(BOOL)animated {
	[[self writtenContent] becomeFirstResponder];
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
