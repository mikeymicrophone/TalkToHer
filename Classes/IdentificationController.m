//
//  IdentificationController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "IdentificationController.h"
#import "UserSession.h"
#import "User.h"
#import "ObjectiveResourceConfig.h"
#import "ASIHTTPRequest.h"

@implementation IdentificationController

@synthesize username_field, password_field, data_source;

- (IBAction)log_in {
	// log in
	UserSession *user_session = [[UserSession alloc] init];
	user_session.username = username_field.text;
	user_session.password = password_field.text;
	[ObjectiveResourceConfig setRemoteProtocolExtension:@".iphone"];
	[user_session createRemote];
	[ObjectiveResourceConfig setRemoteProtocolExtension:@".xml"];

	// get id
	NSString *path = [[data_source server_location] stringByAppendingString:@"users/"];
	path = [path stringByAppendingString:user_session.username];
	path = [path stringByAppendingString:@"/identity"];
	NSURL *url = [[NSURL alloc] initWithString:path];
	ASIHTTPRequest *nextRequest = [ASIHTTPRequest requestWithURL:url];
	[url release];
	[nextRequest startSynchronous];
	NSError *error = [nextRequest error];
	if (!error) {
		NSString *nextResponse = [nextRequest responseString];
		NSString *user_id = nextResponse;
		[data_source setUserId:user_id];
	}
	
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
	[[[[self parentViewController] topViewController] tableView] reloadData];
}

- (IBAction)sign_up {
	User *user = [User alloc];
	UserSession *user_session = [[UserSession alloc] init];
	user.username = user_session.username;
	user.password = user_session.password;
	NSError *creation_response;
	[user createRemoteWithResponse:&creation_response];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
	NSLog(@"creation response: %@", creation_response);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[username_field becomeFirstResponder];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
