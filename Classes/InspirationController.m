//
//  InspirationController.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
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

@implementation InspirationController

@synthesize content_source;

-(id)initWithContentSource:(ContentDelegate *)source {
	if (![super initWithNibName:nil bundle:nil])
		return nil;
	
	self.content_source = source;

	return self;
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger length;
	if (section == 0) {
		length = [content_source display_amount];
	} else if (section == 1) {
		length = 2;
	}
	return length;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;

	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			static NSString *CellIdentifier = @"more";
			
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				UIImageView *show_more = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
				show_more.center = cell.center;
				[cell addSubview:show_more];				
			}
		} else if (indexPath.row == 1) {
			static NSString *CellIdentifier = @"write";
			
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				UIImageView *write_one = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"write"]];
				write_one.center = cell.center;
				[cell addSubview:write_one];				
			}			
		}
	} else if ([indexPath indexAtPosition:1] < [[content_source loaded_amount] integerValue]) {
		id content = [self contentForIndexPath:indexPath];
		NSString *identifier = [NSString stringWithFormat:@"%@_%@", [content className], [content performSelector:NSSelectorFromString([content getRemoteClassIdName])]];

		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithContent:content] autorelease];
		}
	}
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
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
		return [[content_source content] objectAtIndex:[indexPath indexAtPosition:1]];
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
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
			if ([[content_source loaded_amount] integerValue] > 0) {
				[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:displayed_rows - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
			}
			[[tableView dequeueReusableCellWithIdentifier:@"more"] setSelected:NO animated:YES];
		} else if (indexPath.row == 1) {
			ContributionController *contributionController = [[ContributionController alloc] initWithContentType:[content_source content_type]];
			[self presentModalViewController:contributionController animated:YES];
			[contributionController release];
		}
	} else {
		if ([[content_source content_type] isEqualToString:@"GoalOwnership"]) {
			ProgressController *progressController = [[ProgressController alloc] initWithGoal:[self contentForIndexPath:indexPath]];
			[self.navigationController pushViewController:progressController animated:YES];
			[progressController release];
		} else {
			if (![[[self contentForIndexPath:indexPath] getRemoteId] isEqualToString:@"0"]) {
				InspectionController *inspectionController = [[InspectionController alloc] initWithContent:[self contentForIndexPath:indexPath]];

				[self.navigationController pushViewController:inspectionController animated:YES];
				[inspectionController release];
			} else {
				[[self tableView:tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
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
}

- (void)dealloc {
    [super dealloc];
}

@end

