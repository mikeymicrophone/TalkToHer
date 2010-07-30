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
#import "LoaderCell.h"
#import <AddressBook/AddressBook.h>

@implementation IdentificationController

@synthesize username_field, password_field, email_field, email_heading;

- (IBAction)log_in {
	UserSession *user_session = [[UserSession alloc] init];
	user_session.username = username_field.text;
	user_session.password = password_field.text;

	UITableView *s = [[[self parentViewController] bottomViewController] tableView];
	LoaderCell *c = [[[self parentViewController] bottomViewController] goals_cell];

	dispatch_queue_t queue = dispatch_queue_create("com.talktoher.login", NULL);
	dispatch_async(queue, ^{
		NSError *response = nil;
		[ObjectiveResourceConfig setRemoteProtocolExtension:@".iphone"];
		[user_session createRemoteWithResponse:&response];
		[ObjectiveResourceConfig setRemoteProtocolExtension:@".xml"];
		if (response == nil) {
			[self get_identity:username_field.text];
			dispatch_async(dispatch_get_main_queue(), ^{ [s reloadData]; });
//			[[[[UIApplication sharedApplication] delegate] data_source] loadDataSegmentOfType:@"goals" andAlertCell:c];
		}
	});
	dispatch_release(queue);

	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)sign_up {
	if (email_shown) {
		User *user = [User alloc];
		user.username = username_field.text;
		user.password = password_field.text;
		user.password_confirmation = password_field.text;
		user.email = email_field.text;

		UITableView *s = [[[self parentViewController] bottomViewController] tableView];
		
		dispatch_queue_t queue = dispatch_queue_create("com.talktoher.login", NULL);
		dispatch_async(queue, ^{
			[user createRemote];
			[self get_identity:username_field.text];
			dispatch_async(dispatch_get_main_queue(), ^{ [s reloadData]; });
		});
		dispatch_release(queue);
		
		[[self parentViewController] dismissModalViewControllerAnimated:YES];
	} else {
		[login_button removeFromSuperview];
		email_heading = [[UILabel alloc] initWithFrame:CGRectMake(171, 99, 70, 21)];
		email_heading.text = @"email";
		email_heading.textColor = [UIColor whiteColor];
		email_heading.font = [UIFont fontWithName:@"TrebuchetMS" size:17];
		email_heading.shadowColor = [UIColor blackColor];
		email_heading.opaque = NO;
		email_heading.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		
		email_field = [[UITextField alloc] initWithFrame:CGRectMake(20, 98, 136, 31)];
		email_field.autocapitalizationType = UITextAutocapitalizationTypeNone;
		email_field.autocorrectionType = UITextAutocorrectionTypeNo;
		email_field.borderStyle = UITextBorderStyleRoundedRect;
		email_field.font = username_field.font;
		email_field.textAlignment = username_field.textAlignment;
		email_field.contentVerticalAlignment = username_field.contentVerticalAlignment;
		[self.view addSubview:email_field];
		[self.view addSubview:email_heading];
		[self.view setNeedsDisplay];
		[email_field becomeFirstResponder];
		email_shown = YES;
	}
}

-(void)get_identity:(NSString *)username {
	NSString *path = [[[[[UIApplication sharedApplication] delegate] data_source] server_location] stringByAppendingString:@"users/"];
	path = [path stringByAppendingString:username];
	path = [path stringByAppendingString:@"/identity"];
	NSURL *url = [[NSURL alloc] initWithString:path];
	ASIHTTPRequest *nextRequest = [ASIHTTPRequest requestWithURL:url];
	[url release];
	[nextRequest startSynchronous];
	NSError *error = [nextRequest error];
	if (!error) {
		NSString *nextResponse = [nextRequest responseString];
		NSString *user_id = nextResponse;
		[[[[UIApplication sharedApplication] delegate] data_source] setMyUserId:user_id forUsername:username];
	}	
}

-(IBAction)cancel {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[username_field becomeFirstResponder];
	username_field.autocorrectionType = UITextAutocorrectionTypeNo;
	email_shown = NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
	self.email_field = nil;
	self.email_heading = nil;
	self.username_field = nil;
	self.password_field = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
