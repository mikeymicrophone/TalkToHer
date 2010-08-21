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
#import "BroadcastController.h"
#import "Rating.h"
#import "Tag.h"
#import "Comment.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@implementation InspectionController

@synthesize content, ratings_cell, tags_cell, comments_header_cell, tag_field, comment_field, slider, tag_button, comment_button, rating, text_her, broadcast, previous_comments, previous_tags, previous_ratings;

-(id)initWithContent:(id)contentObj {
	if (![super initWithNibName:@"InspectionController" bundle:nil])
		return nil;

	[self setContent:contentObj];
	tags_updated = NO;
	ratings_updated = NO;

	self.slider = [[UISlider alloc] initWithFrame:CGRectMake(78, 18, 180, 20)];
	[slider addTarget:self action:@selector(ratingChanged:) forControlEvents:UIControlEventValueChanged];
	[slider addTarget:self action:@selector(ratingReady:) forControlEvents:UIControlEventTouchUpInside];
	[slider addTarget:self action:@selector(ratingArmed:) forControlEvents:UIControlEventTouchDown];

	self.rating = [[UILabel alloc] initWithFrame:CGRectMake(273, 18, 30, 20)];
	self.tag_field = [[UITextField alloc] initWithFrame:CGRectMake(78, 8, 180, 24)];
	self.tag_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	tag_button.frame = CGRectMake(265, 3, 44, 44);
	self.comment_field = [[UITextField alloc] initWithFrame:CGRectMake(118, 8, 140, 24)];
	self.comment_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	comment_button.frame = CGRectMake(265, 3, 44, 44);
	self.text_her = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"text_her"] autorelease];
	self.broadcast = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"broadcast"] autorelease];
	
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

#pragma mark -
#pragma mark rotation control

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self moveButtonsForOrientation:self.interfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self moveButtonsForOrientation:toInterfaceOrientation];
}

-(void)moveButtonsForOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
		slider.frame = CGRectMake(slider.frame.origin.x, slider.frame.origin.y, 180, slider.frame.size.height);
		rating.frame = CGRectMake(273, rating.frame.origin.y, rating.frame.size.width, rating.frame.size.height);
		tag_field.frame = CGRectMake(tag_field.frame.origin.x, tag_field.frame.origin.y, 180, tag_field.frame.size.height);
		tag_button.frame = CGRectMake(265, tag_button.frame.origin.y, tag_button.frame.size.width, tag_button.frame.size.height);
		comment_field.frame = CGRectMake(comment_field.frame.origin.x, comment_field.frame.origin.y, 140, comment_field.frame.size.height);
		comment_button.frame = CGRectMake(265, comment_button.frame.origin.y, comment_button.frame.size.width, comment_button.frame.size.height);
		text_her.coloredLabel.center = CGPointMake(160, text_her.coloredLabel.center.y);
		broadcast.coloredLabel.center = CGPointMake(160, broadcast.coloredLabel.center.y);
	} else {
		slider.frame = CGRectMake(slider.frame.origin.x, slider.frame.origin.y, 340, slider.frame.size.height);
		rating.frame = CGRectMake(433, rating.frame.origin.y, rating.frame.size.width, rating.frame.size.height);
		tag_field.frame = CGRectMake(tag_field.frame.origin.x, tag_field.frame.origin.y, 340, tag_field.frame.size.height);
		tag_button.frame = CGRectMake(425, tag_button.frame.origin.y, tag_button.frame.size.width, tag_button.frame.size.height);
		comment_field.frame = CGRectMake(comment_field.frame.origin.x, comment_field.frame.origin.y, 300, comment_field.frame.size.height);
		comment_button.frame = CGRectMake(425, comment_button.frame.origin.y, comment_button.frame.size.width, comment_button.frame.size.height);
		text_her.coloredLabel.center = CGPointMake(240, text_her.coloredLabel.center.y);
		broadcast.coloredLabel.center = CGPointMake(300, broadcast.coloredLabel.center.y);
	}
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([MFMessageComposeViewController canSendText]) {
		return 7;
	} else {
		return 6;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger length;
	if (section == 3) {
		length = [[content commentCount] integerValue] + 1;
	} else {
		length = 1;
	}
    return length;
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
		
		cell = ratings_cell;//(InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:[content averageRatingText]];
			[cell setAdditional_text:[content ratingCountText]];
			
			if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
				slider.maximumValue = 5.0;
//				[slider addTarget:self action:@selector(ratingChanged:) forControlEvents:UIControlEventValueChanged];
//				[slider addTarget:self action:@selector(ratingReady:) forControlEvents:UIControlEventTouchUpInside];
				[cell addSubview:slider];
				slider.value = [[content myRating] floatValue];
				
				rating.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
				[cell addSubview:rating];
				if ([[content myRating] floatValue] > 0.0) {
					rating.text = [NSString stringWithFormat:@"%.1f", [[content myRating] floatValue]];
				}
			} else {
				UIButton *log_in_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				log_in_button.frame = CGRectMake(80, 15, 210, 30);
				log_in_button.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:13];
				[log_in_button setTitle:@"Log in to rate, tag, and comment" forState:nil];
				[log_in_button setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:nil];
				log_in_button.titleLabel.frame = CGRectMake(5, 5, 200, 20);
				
				[log_in_button addTarget:self action:@selector(log_in) forControlEvents:UIControlEventTouchUpInside];
				[cell addSubview:log_in_button];
			}
			self.ratings_cell = cell;
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		if (!ratings_updated) {
			[cell start_spinning];
			rating_spinner = [cell spinner];
			[cell bringSubviewToFront:cell.spinner];
		}
	} else if (indexPath.section == 2) {
		CellIdentifier = @"tags";
		
		cell = tags_cell;//(InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell setMain_text:[content tagCountText]];
			[cell setAdditional_text:[content tagSummary]];
			
			if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
				tag_field.borderStyle = UITextBorderStyleRoundedRect;
				tag_field.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
				tag_field.placeholder = @"separate, with commas";
				tag_field.autocapitalizationType = UITextAutocapitalizationTypeNone;
				
				[tag_button setTitle:@"+" forState:nil];
				tag_button.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:30];
				[tag_button setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:nil];
				
				[tag_button addTarget:self action:@selector(tagReady) forControlEvents:UIControlEventTouchUpInside];
				
				[cell addSubview:tag_field];
				[cell addSubview:tag_button];
			}
			self.tags_cell = cell;
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		if (!tags_updated) {
			[cell start_spinning];
			tag_spinner = [cell spinner];
			[cell bringSubviewToFront:cell.spinner];
		}		
    } else if (indexPath.section == 3) {
		if (indexPath.row == 0) {
			CellIdentifier = @"comments";
			
			cell = comments_header_cell;//(InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				
				[cell setMain_text:[content commentCountText]];

				if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
					comment_field.borderStyle = UITextBorderStyleRoundedRect;
					comment_field.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
					comment_field.autocapitalizationType = UITextAutocapitalizationTypeNone;
					
					comment_button.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:23];
					[comment_button setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:nil];
					[comment_button setTitle:@"!" forState:nil];
					
					[comment_button addTarget:self action:@selector(commentReady) forControlEvents:UIControlEventTouchUpInside];
					
					[cell addSubview:comment_field];
					[cell addSubview:comment_button];
				}
				self.comments_header_cell = cell;
			}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;

			if (!comments_updated) {
				[cell start_spinning];
				comment_spinner = [cell spinner];
				[cell bringSubviewToFront:cell.spinner];
			}
		} else {
			CommentEntity *comment = [[content comments] objectAtIndex:indexPath.row - 1];
			NSString *identifier = [NSString stringWithFormat:@"CommentEntity_%@", [comment getRemoteId]];
			
			cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
			if (cell == nil) {
				cell = [[[InspirationCell alloc] initWithContent:comment] autorelease];
			}
		}

	} else if (indexPath.section == 4) {
		CellIdentifier = @"set_a_goal";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	} else if (indexPath.section == 5) {
		if ([MFMessageComposeViewController canSendText]) {
			CellIdentifier = @"text_her";
			
			cell = text_her;
			if (cell == nil) {
				cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				self.text_her = cell;
			}
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
		} else {
			CellIdentifier = @"broadcast";
			
			cell = broadcast;
			if (cell == nil) {
				cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				self.broadcast = cell;
			}
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
		}
	} else if (indexPath.section == 6) {
		CellIdentifier = @"broadcast";
		
		cell = broadcast;
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			self.broadcast = cell;
		}
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
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
		height = [InspirationCell cellHeightForMainText:[content averageRatingText]
											 additional:[content ratingCountText]
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 2) {
		height = [InspirationCell cellHeightForMainText:[content tagCountText]
											 additional:[content tagSummary]
												  width:[[self view] frame].size.width];
	} else if (indexPath.section == 3) {
		if (indexPath.row == 0) {
			height = 44;
		} else {
			CommentEntity *c = [[content comments] objectAtIndex:(indexPath.row - 1)];
			height = [InspirationCell cellHeightForMainText:[c main_text]
												 additional:[c additional_text]
													  width:[[self view] frame].size.width];
		}
	} else if (indexPath.section == 4) {
		height = 40;
	} else if (indexPath.section == 5) {
		height = 40;
	}
	return height;
}

-(void)updateMetadataOfType:(NSString *)type {
	if (previous_comments == nil) {
		self.previous_comments = [content commentCount];
		self.previous_ratings = [NSNumber numberWithInt:[content ratingCount]];
		self.previous_tags = [NSNumber numberWithInt:[content tagCount]];
	}
	[[[[UIApplication sharedApplication] delegate] managedObjectContext] refreshObject:content mergeChanges:YES];
	if ([type isEqualToString:@"CommentEntity"]) {
		comments_updated = YES;
		NSInteger current_comments = [[content commentCount] integerValue];
		if (current_comments > [previous_comments integerValue]) {
			NSInteger new_comments = current_comments - [previous_comments integerValue];
			NSMutableArray *new_comment_indices = [NSMutableArray arrayWithCapacity:new_comments];
			for (NSInteger i = 0; i < new_comments; i++) {
				NSUInteger indexSet[] = {3, i + [previous_comments integerValue] + 1};
				NSIndexPath *indexOfComment = [NSIndexPath indexPathWithIndexes:indexSet length:2];
				[new_comment_indices insertObject:indexOfComment atIndex:i];
			}
			[self.tableView insertRowsAtIndexPaths:new_comment_indices withRowAnimation:UITableViewRowAnimationBottom];
			if (current_comments == 1) {
				comments_header_cell.main.text = @"1 comment";
			} else {
				comments_header_cell.main.text = [NSString stringWithFormat:@"%d comments", current_comments];
			}
		}
		[comment_spinner stopAnimating];
		self.previous_comments = [content commentCount];
	} else if ([type isEqualToString:@"RatingEntity"]) {
		ratings_updated = YES;
		NSInteger current_ratings = [content ratingCount];
		if (current_ratings > [previous_ratings integerValue]) {
			ratings_updated = YES;
			self.ratings_cell = nil;
			NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSRangeFromString(@"1 1")];
			[self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationBottom];
		 } else {
			[rating_spinner stopAnimating]; 
		 }
	} else if ([type isEqualToString:@"TagEntity"]) {
		tags_updated = YES;
		NSInteger current_tags = [content tagCount];
		if (current_tags > [previous_tags integerValue]) {
			NSString *tag_in_progress = nil;
			if ([tag_field isFirstResponder]) {
				tag_in_progress = tag_field.text;
				[tag_field resignFirstResponder];
			}
			tags_updated = YES;
			self.tags_cell = nil;
			NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSRangeFromString(@"2 1")];
			[self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationBottom];
			if (tag_in_progress) {
				tag_field.text = tag_in_progress;
				[tag_field becomeFirstResponder];
			}
		} else {
			[tag_spinner stopAnimating];
		}
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 5) {
		if ([MFMessageComposeViewController canSendText]) {
			MFMessageComposeViewController *textController = [[MFMessageComposeViewController alloc] init];
			textController.body = [content main_text];
			textController.messageComposeDelegate = self;
			
			[self presentModalViewController:textController animated:YES];
			[textController release];			
		} else {
			BroadcastController *broadcastController = [[BroadcastController alloc] initWithBroadcast:[content full_text]];
			[self presentModalViewController:broadcastController animated:NO];
		}
	} else if (indexPath.section == 4) {
		if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
			GoalSettingController *goalSettingController = [[GoalSettingController alloc] initWithObjective:content];			
			[self.navigationController pushViewController:goalSettingController animated:YES];
			[goalSettingController release];
		} else {
			[self log_in];
		}
	} else if (indexPath.section == 6) {
		BroadcastController *broadcastController = [[BroadcastController alloc] initWithBroadcast:[content full_text]];
		[self presentModalViewController:broadcastController animated:NO];
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
	
	NSDecimalNumber *previous_average = [NSDecimalNumber decimalNumberWithString:[content averageRatingText]];
	NSDecimalNumber *previous_count = [NSDecimalNumber decimalNumberWithMantissa:[content ratingCount] exponent:0 isNegative:NO];

	NSDecimalNumber *dividend;
	NSDecimalNumber *multiplier;
	if ([[content myRating] floatValue] > 0.0) {
		multiplier = [previous_count decimalNumberBySubtracting:[NSDecimalNumber one]];
		dividend = previous_count;
	} else {
		multiplier = previous_count;
		dividend = [previous_count decimalNumberByAdding:[NSDecimalNumber one]];
		if ([content ratingCount] == 0) {
			ratings_cell.addl.text = @"1 rating";
		} else {
			ratings_cell.addl.text = [NSString stringWithFormat:@"%@ ratings", [[NSDecimalNumber decimalNumberWithMantissa:[content ratingCount] exponent:0 isNegative:NO] decimalNumberByAdding:[NSDecimalNumber one]]];
		}									  
	}
	NSDecimalNumber *aggregate = [previous_average decimalNumberByMultiplyingBy:multiplier];
	NSDecimalNumber *new_value = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", [sender value]]];
	NSDecimalNumber *divisor = [aggregate decimalNumberByAdding:new_value];
	
	ratings_cell.main.text = [NSString stringWithFormat:@"%.1f", [[divisor decimalNumberByDividingBy:dividend] floatValue]];
}

-(void)ratingReady:(UISlider *)sender {
	if (rating_is_fresh) {
		rating_is_fresh = NO;
		dispatch_queue_t queue;
		queue = dispatch_queue_create("com.talktoher.submit", NULL);
		dispatch_async(queue, ^{
			Rating *r = [[Rating alloc] init];
			r.opinion = [NSString stringWithFormat:@"%d", (NSInteger)([sender value] * 10)];
			r.targetId = [content getRemoteId];
			r.targetType = [[content className] substringToIndex:[[content className] length] - 6];
			r.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
			
			if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
				[r createRemote];
			}
			[r persistInMoc:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
			[[[[UIApplication sharedApplication] delegate] managedObjectContext] refreshObject:content mergeChanges:YES];
		});
		dispatch_release(queue);
	}
}

-(void)ratingArmed:(UISlider *)sender {
	NSLog(@"touch down");
	rating_is_fresh = YES;
}

#pragma mark -
#pragma mark login control

-(void)log_in {
	IdentificationController *identificationController = [[IdentificationController alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:identificationController animated:YES];
	[identificationController release];
}

-(void)reloadForLogin {
	self.ratings_cell = nil;
	self.tags_cell = nil;
	self.comments_header_cell = nil;
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSRangeFromString(@"1 3")] withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark -
#pragma mark tag control

-(void)tagReady {
	[tag_field resignFirstResponder];
	if (!(tag_field.text == nil)) {
		dispatch_queue_t queue;
		queue = dispatch_queue_create("com.talktoher.submit", NULL);
		dispatch_async(queue, ^{
			Tag *t = [[Tag alloc] init];
			t.concept = tag_field.text;
			dispatch_async(dispatch_get_main_queue(), ^{ tag_field.text = @""; });
			t.targetId = [content getRemoteId];
			t.targetType = [[content className] substringToIndex:[[content className] length] - 6];
			t.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
			
			if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
				[t createRemote];
			}
			[t persistInMoc:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
			dispatch_async(dispatch_get_main_queue(), ^{ [self updateMetadataOfType:@"TagEntity"]; });
		});
		dispatch_release(queue);
	}
}

#pragma mark -
#pragma mark comment control

-(void)commentReady {
	[comment_field resignFirstResponder];
	if (!(comment_field.text == nil)) {
		dispatch_queue_t queue;
		queue = dispatch_queue_create("com.talktoher.submit", NULL);
		dispatch_async(queue, ^{
			Comment *c = [[Comment alloc] init];
			c.text = comment_field.text;
			dispatch_async(dispatch_get_main_queue(), ^{ comment_field.text = @""; });
			c.targetId = [content getRemoteId];
			c.targetType = [[content className] substringToIndex:[[content className] length] - 6];
			c.userId = [[[[UIApplication sharedApplication] delegate] data_source] userId];
			
			if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
				[c createRemote];
			}
			[c persistInMoc:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self updateMetadataOfType:@"CommentEntity"];
			});
		});
		dispatch_release(queue);
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
	self.ratings_cell = nil;
	self.tags_cell = nil;
	self.comments_header_cell = nil;	
	self.slider = nil;
	self.comment_field = nil;
	self.comment_button = nil;
	self.tag_field = nil;
	self.tag_button = nil;
    [super dealloc];
}

@end
