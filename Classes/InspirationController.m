//
//  InspirationController.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import "InspirationController.h"
#import "ObjectiveResourceConfig.h"
#import "Line.h"
#import "Tip.h"
#import "Exercise.h"
#import "GoalOwnership.h"
#import "InspirationCell.h"
#import "InspectionController.h"
#import "ContributionController.h"
#import "ProgressController.h"
#import "DataDelegate.h"
#import "ContentDelegate.h"

@implementation InspirationController

@synthesize content_source, more_button, write_button;

-(id)initWithContentSource:(ContentDelegate *)source {
	if (![super initWithNibName:@"InspirationController" bundle:nil])
		return nil;

	self.content_source = source;
	if ([[content_source loaded_amount] integerValue] >= 3) {
		if ([[content_source displayed_amount] integerValue] == 0) {
			[content_source displayRows:3];
		}
	} else {
		[content_source displayRows:[[content_source loaded_amount] integerValue]];
	}

	
	if ([[content_source content_type] isEqualToString:@"Line"]) {
		self.title = @"Lines";
	} else if ([[content_source content_type] isEqualToString:@"Tip"]) {
		self.title = @"Tips";
	} else if ([[content_source content_type] isEqualToString:@"Exercise"]) {
		self.title = @"Exercises";
	} else if ([[content_source content_type] isEqualToString:@"GoalOwnership"]) {
		self.title = @"Goals";
	}

	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	if (more_button == nil) {
		self.more_button = 	[[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"more"] autorelease];
		more_button.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	if (write_button == nil) {
		self.write_button = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"write"] autorelease];
		write_button.selectionStyle = UITableViewCellSelectionStyleNone;
	}
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}
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
		more_button.coloredLabel.center = CGPointMake(160, more_button.coloredLabel.center.y);
		write_button.coloredLabel.center = CGPointMake(160, write_button.coloredLabel.center.y);
	} else {
		more_button.coloredLabel.center = CGPointMake(175, more_button.coloredLabel.center.y);
		write_button.coloredLabel.center = CGPointMake(305, write_button.coloredLabel.center.y);
	}

}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger length;
	if ([[content_source content_type] isEqualToString:@"GoalOwnership"]) {
		length = 2;
	} else {
		length = 3;
	}
    return length;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger length;
	if (section == 0) {
		length = [content_source display_amount];
	} else {
		length = 1;
	}
	return length;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;

	if (indexPath.section == 1) {
		NSString *identifier = @"more";

		cell = more_button;
		if (cell == nil) {
			cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			self.more_button = cell;
		}
	} else if (indexPath.section == 2) {
		NSString *identifier = @"write";
		
		cell = write_button;
		if (cell == nil) {
			cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
			self.write_button = cell;
		}
	} else if ([indexPath indexAtPosition:1] < [[content_source loaded_amount] integerValue]) {
		id content = [self contentForIndexPath:indexPath];
		NSString *identifier = [NSString stringWithFormat:@"%@_%@", [content className], [content getRemoteId]];

		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithContent:content] autorelease];
			UISwipeGestureRecognizer *hide_gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
			hide_gesture.direction = UISwipeGestureRecognizerDirectionLeft;
			[cell addGestureRecognizer:hide_gesture];
			[hide_gesture release];
			cell.contentMode = UIViewContentModeRedraw;
		}
	}
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		id content = [self contentForIndexPath:indexPath];
		if (content) {
			return [InspirationCell cellHeightForMainText:[content main_text]
												   additional:[content additional_text]
												  width:[[self view] frame].size.width];
		} else {
			return 44;
		}
	} else {
		return 44;
	}
}

- (id)contentForIndexPath:(NSIndexPath *)indexPath {
	if ([indexPath indexAtPosition:1] < [[content_source loaded_amount] integerValue]) {
		return [content_source objectAtIndex:[indexPath indexAtPosition:1]];
	} else {
		return nil;
	}
}

-(void)popCreatedContent {
	NSArray *created_content_index = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[content_source display_amount] - 1 inSection:0]];
	[self.tableView insertRowsAtIndexPaths:created_content_index withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark -
#pragma mark Table view delegate

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	[content_source reorder_content];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
	// hide the row immediately
	NSIndexPath *cellPathToRemove = [self.tableView indexPathForRowAtPoint:[recognizer locationInView:self.tableView]];
	NSArray *indexPaths = [NSArray arrayWithObject:cellPathToRemove];
	
	[self.tableView beginUpdates];
	[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
	
	// remove the index from the ordering array so it won't be shown on a reorder
	[content_source removeOrderedIndex:cellPathToRemove.row];
	[self.tableView endUpdates];
	
	// mark the content as hidden so it won't be shown again
	NSString *identifier = [[recognizer view] reuseIdentifier];
	NSRange r = [identifier rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"_"]];
	NSInteger content_id = [[identifier substringFromIndex:r.location + 1] integerValue];
	NSString *content_id_type = [NSClassFromString([content_source content_type]) getRemoteClassIdName];
	NSEntityDescription *e = [NSEntityDescription entityForName:[content_source content_type] inManagedObjectContext:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	
	[f setEntity:e];
	[f setPredicate:[NSPredicate predicateWithFormat:[content_id_type stringByAppendingFormat:@" == %d", content_id]]];
	[f setPropertiesToFetch:[NSArray arrayWithObject:content_id_type]];
    
	NSError *error = nil;
	NSArray *results = [[[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:f error:&error];
	[f release];
	
	[[results objectAtIndex:0] setValue:[NSNumber numberWithInt:1] forKey:@"hidden"];
	[[[[UIApplication sharedApplication] delegate] managedObjectContext] save:&error];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		NSArray *insertableRows;
		
		NSInteger displayed_rows = [content_source display_amount];
		NSInteger undisplayed_rows = [content_source undisplayed_row_count];
		
		if (undisplayed_rows >= 3) {
			insertableRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:displayed_rows inSection:0],
													   [NSIndexPath indexPathForRow:displayed_rows + 1 inSection:0],
													   [NSIndexPath indexPathForRow:displayed_rows + 2 inSection:0], nil];
			[content_source displayRows:3];
		} else if (undisplayed_rows == 2) {
			insertableRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:displayed_rows inSection:0],
													   [NSIndexPath indexPathForRow:displayed_rows + 1 inSection:0], nil];
			[content_source displayRows:2];
		} else if (undisplayed_rows == 1) {
			insertableRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:displayed_rows inSection:0], nil];
			[content_source displayRows:1];
		} else {
			insertableRows = [NSArray arrayWithObjects:nil];
		}
		
		[tableView insertRowsAtIndexPaths:insertableRows withRowAnimation:UITableViewRowAnimationRight];
		if (displayed_rows > 0) {
			[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:displayed_rows - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
		}

		if (undisplayed_rows < 10) {
			[content_source download_more];
		}
	} else if (indexPath.section == 2) {
		ContributionController *contributionController = [[ContributionController alloc] initWithContentType:[content_source content_type]];
		[self presentModalViewController:contributionController animated:YES];
		[contributionController release];
	} else {
		if ([[content_source content_type] isEqualToString:@"GoalOwnership"]) {
			ProgressController *progressController = [[ProgressController alloc] initWithGoal:[self contentForIndexPath:indexPath]];
			[self.navigationController pushViewController:progressController animated:YES];
			[progressController release];
		} else {
			if ((![[[self contentForIndexPath:indexPath] getRemoteId] isEqualToString:@"0"])) {
				NSObject *uninspected_content = [self contentForIndexPath:indexPath];
				
				InspectionController *inspectionController = [[InspectionController alloc] initWithContent:uninspected_content];
				[self.navigationController pushViewController:inspectionController animated:YES];
				
				dispatch_queue_t queue;
				queue = dispatch_queue_create("com.talktoher.inspect", NULL);
				dispatch_async(queue, ^{
					if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) { [uninspected_content updateComments]; }
					dispatch_async(dispatch_get_main_queue(), ^{
						[inspectionController updateMetadataOfType:@"CommentEntity"];
					});
				});
				dispatch_async(queue, ^{
					if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) { [uninspected_content updateRatings]; }
					dispatch_async(dispatch_get_main_queue(), ^{
						[inspectionController updateMetadataOfType:@"RatingEntity"];
					});
				});
				dispatch_async(queue, ^{
					if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) { [uninspected_content updateTags]; }
					dispatch_async(dispatch_get_main_queue(), ^{
						[inspectionController updateMetadataOfType:@"TagEntity"];
					});
				});
				dispatch_release(queue);
				[inspectionController release];
			} else {
				[[self tableView] deselectRowAtIndexPath:indexPath animated:NO];
			}
		}
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
	self.more_button = nil;
	self.write_button = nil;
}

- (void)dealloc {
    [super dealloc];
	self.content_source = nil;
}

@end

