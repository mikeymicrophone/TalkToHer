//
//  InspectionController.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InspectionController.h"
#import "InspirationCell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@implementation InspectionController

@synthesize content;

-(id)initWithContent:(id)contentObj {
	if (![super initWithStyle:UITableViewStylePlain])
		return nil;
	
	[self setContent:[self inspect_content:contentObj]];

	return self;
}

-(id)inspect_content:(id)contentObj {
	return [[contentObj objectiveResource] get_commentary];
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([MFMessageComposeViewController canSendText] || YES) {
		return 5;
	} else {
		return 4;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *CellIdentifier;
	InspirationCell *cell;
	
    // Configure the cell...
	if (indexPath.section == 0) {
		CellIdentifier = @"display";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:[content main_text]];
			[cell setAdditional_text:[content additional_text]];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else if (indexPath.section == 1) {
		CellIdentifier = @"rating";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:[content averageRating]];
			[cell setAdditional_text:[content ratingCount]];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else if (indexPath.section == 2) {
		CellIdentifier = @"tags";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			[cell setMain_text:[content tagCount]];
			[cell setAdditional_text:[content recentTags]];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.section == 3) {
		CellIdentifier = @"comments";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:[content commentCount]];
			[cell setAdditional_text:[content recentComment]];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else if (indexPath.section == 4) {
		CellIdentifier = @"text_message";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];

			[cell setMain_text:@"send as a text"];
			[cell setAdditional_text:@""];
		}		
	}
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height;
	if (indexPath.section == 0) {
		height = [InspirationCell cellHeightForMainText:[content main_text]
											 additional:[content additional_text]
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 1) {
		height = [InspirationCell cellHeightForMainText:[content averageRating]
											 additional:[content ratingCount]
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 2) {
		height = [InspirationCell cellHeightForMainText:[content tagCount]
											 additional:[content recentTags]
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 3) {
		height = [InspirationCell cellHeightForMainText:[content commentCount]
											 additional:[content recentComment]
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 4) {
		height = [InspirationCell cellHeightForMainText:@"send as a text"
											 additional:@""
												  width:[[self view] frame].size.width];
	}
	return height;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"index: %@", indexPath);
	if (indexPath.section == 4) {
		MFMessageComposeViewController *textController = [[MFMessageComposeViewController alloc] init];
		NSLog(@"text controller: %@", textController);
		textController.body = [content main_text];
		textController.messageComposeDelegate = self;
		
		[self presentModalViewController:textController animated:YES];
		[textController release];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
