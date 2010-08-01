//
//  InspectionController.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InspectionController.h"
#import "IdentificationController.h"
#import "InspirationCell.h"
#import "GoalSettingController.h"
#import "Rating.h"
#import "Tag.h"
#import "Comment.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@implementation InspectionController

@synthesize content, tag_field, comment_field;

-(id)initWithContent:(id)contentObj {
	if (![super initWithNibName:@"InspectionController" bundle:nil])
		return nil;

	[self setContent:contentObj];

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
	if ([MFMessageComposeViewController canSendText]) {
		return 6;
	} else {
		return 5;
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
			cell = [[[InspirationCell alloc] initWithContent:content] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else if (indexPath.section == 1) {
		CellIdentifier = @"rating";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:[content averageRating]];
			[cell setAdditional_text:[content ratingCount]];
			
			if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
				UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(78, 18, 180, 20)];
				slider.maximumValue = 5.0;
				[slider addTarget:self action:@selector(ratingChanged:) forControlEvents:UIControlEventValueChanged];
				[slider addTarget:self action:@selector(ratingReady:) forControlEvents:UIControlEventTouchUpInside];
				[cell addSubview:slider];
				
				rating = [[UILabel alloc] initWithFrame:CGRectMake(273, 18, 30, 20)];
				[cell addSubview:rating];				
			} else {
				UIButton *log_in_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				log_in_button.frame = CGRectMake(80, 15, 210, 30);
				log_in_button.titleLabel.frame = CGRectMake(5, 5, 200, 20);
				log_in_button.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:13];
				log_in_button.titleLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
				log_in_button.titleLabel.text = @"Log in to rate, tag, and comment";
				log_in_button.titleLabel.hidden = NO;
				
				[log_in_button addTarget:self action:@selector(log_in) forControlEvents:UIControlEventTouchUpInside];
				[cell addSubview:log_in_button];
			}
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else if (indexPath.section == 2) {
		CellIdentifier = @"tags";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell setMain_text:[content tagCount]];
			[cell setAdditional_text:[content recentTags]];
			
			if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
				self.tag_field = [[UITextField alloc] initWithFrame:CGRectMake(78, 8, 180, 24)];
				tag_field.borderStyle = UITextBorderStyleRoundedRect;
				tag_field.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
				tag_field.placeholder = @"separate, with commas";
				tag_field.autocapitalizationType = UITextAutocapitalizationTypeNone;
				
				UIButton *tag_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				tag_button.frame = CGRectMake(275, 8, 24, 24);
				tag_button.titleLabel.frame = CGRectMake(5, 3, 20, 15);
				tag_button.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:28];
				tag_button.titleLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
				tag_button.titleLabel.text = @"+";
				tag_button.titleLabel.hidden = NO;
				
				[tag_button addTarget:self action:@selector(tagReady) forControlEvents:UIControlEventTouchUpInside];
				
				[cell addSubview:tag_field];
				[cell addSubview:tag_button];
			}
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.section == 3) {
		CellIdentifier = @"comments";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:[content commentCount]];
			[cell setAdditional_text:[content recentComment]];
			
			if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
				self.comment_field = [[UITextField alloc] initWithFrame:CGRectMake(118, 8, 140, 24)];
				comment_field.borderStyle = UITextBorderStyleRoundedRect;
				comment_field.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
				comment_field.autocapitalizationType = UITextAutocapitalizationTypeNone;
				
				UIButton *comment_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				comment_button.frame = CGRectMake(275, 8, 24, 24);
				comment_button.titleLabel.frame = CGRectMake(7, 3, 20, 20);
				comment_button.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:26];
				comment_button.titleLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
				comment_button.titleLabel.text = @"!";
				comment_button.titleLabel.hidden = NO;
				
				[comment_button addTarget:self action:@selector(commentReady) forControlEvents:UIControlEventTouchUpInside];
				
				[cell addSubview:comment_field];
				[cell addSubview:comment_button];
			}
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else if (indexPath.section == 4) {
		CellIdentifier = @"goal setting";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:@"set a goal"];
			if ([[content className] isEqualToString:@"Line"]) {
				[cell setAdditional_text:@"to try this line"];
			} else if ([[content className] isEqualToString:@"Tip"]) {
				[cell setAdditional_text:@"to use this tip"];
			} else if ([[content className] isEqualToString:@"Exercise"]) {
				[cell setAdditional_text:@"to do this exercise"];
			}
		}
	}else if (indexPath.section == 5) {
		CellIdentifier = @"text message";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			UIImageView *coloredLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"text"]];
			coloredLabel.center = cell.center;
			[cell addSubview:coloredLabel];
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
		height = [InspirationCell cellHeightForMainText:@"set a goal"
											 additional:@"to do this exercise"
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 5) {
		height = [InspirationCell cellHeightForMainText:@"send as a text"
											 additional:@"2"
												  width:[[self view] frame].size.width];
	}
	return height;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 5) {
		MFMessageComposeViewController *textController = [[MFMessageComposeViewController alloc] init];
		textController.body = [content main_text];
		textController.messageComposeDelegate = self;
		
		[self presentModalViewController:textController animated:YES];
		[textController release];
	} else if (indexPath.section == 4) {
		GoalSettingController *goalSettingController = [[GoalSettingController alloc] initWithObjective:content];
		
		[self.navigationController pushViewController:goalSettingController animated:YES];
	}
}

#pragma mark -
#pragma mark sms controller delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark rating control

-(void)ratingChanged:(UISlider *)sender {
	rating.text = [NSString stringWithFormat:@"%.1f", [sender value]];
}

-(void)ratingReady:(UISlider *)sender {
	Rating *r = [[Rating alloc] init];
	r.opinion = [NSString stringWithFormat:@"%d", (NSInteger)([sender value] * 10)];
	r.targetId = [content getRemoteId];
	r.targetType = [content className];
	r.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
	
	if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
		[r createRemote];
	} else {
		[r markForDelayedSubmission];
	}
}

-(void)log_in {
	IdentificationController *identificationController = [[IdentificationController alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:identificationController animated:YES];
	[identificationController release];
}

#pragma mark -
#pragma mark tag control

-(void)tagReady {
	[tag_field resignFirstResponder];
	Tag *t = [[Tag alloc] init];
	t.concept = tag_field.text;
	tag_field.text = @"";
	t.targetId = [content getRemoteId];
	t.targetType = [content className];
	t.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
	
	if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
		[t createRemote];
	} else {
		[t markForDelayedSubmission];
	}	
}

#pragma mark -
#pragma mark comment control

-(void)commentReady {
	[comment_field resignFirstResponder];
	Comment *c = [[Comment alloc] init];
	c.text = comment_field.text;
	comment_field.text = @"";
	c.targetId = [content getRemoteId];
	c.targetType = [content className];
	c.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
	
	if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
		[c createRemote];
	} else {
		[c markForDelayedSubmission];
	}	
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
	self.content = nil;
    [super dealloc];
}

@end
