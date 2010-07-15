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
#import "Goal.h"
#import "InspirationCell.h"
#import "InspectionController.h"
#import "ContributionController.h"

@implementation InspirationController

@synthesize content_set, content_type, displayed_content_amount, available_content_amount, data_source, content_page;

-(id)initWithContentType:(NSString *)cType andDataSource:(DataDelegate *)source {
	if (![super initWithNibName:nil bundle:nil])
		return nil;
	
	self.content_type = cType;
	self.data_source = source;

	self.available_content_amount = [NSNumber numberWithInt:[[self.data_source performSelector:NSSelectorFromString(self.content_type)] count]];
	if (displayed_content_amount == nil) {
		if ([self.available_content_amount integerValue] > 2) {
			self.displayed_content_amount = [NSNumber numberWithInt:3];
		} else {
			self.displayed_content_amount = self.available_content_amount;
		}
	}
	
	if (content_page == nil) {
		self.content_page = [NSNumber numberWithInt:1];
	}
	
	return self;
}

-(void)load_content {
	if (self.content_page != nil) {
		[ObjectiveResourceConfig setRemoteProtocolExtension:[NSString stringWithFormat:@".xml?page=%@", content_page]];
	}
	
	if (self.content_type == @"lines") {
		self.content_set = [Line findAllRemote];
	} else if (self.content_type == @"tips") {
		self.content_set = [Tip findAllRemote];
	} else if (self.content_type == @"goals") {
		self.content_set = [Goal findAllRemote];
	} else if (self.content_type == @"exercises") {
		self.content_set = [Exercise findAllRemote];
	}
	
	if (self.content_page != nil) {
		[ObjectiveResourceConfig setRemoteProtocolExtension:@".xml"];
	}	
	
	if (self.content_set == nil) {
		self.content_set = [self.data_source performSelector:NSSelectorFromString(content_type)];
	} else {
		[[self.data_source performSelector:NSSelectorFromString(self.content_type)] addObjectsFromArray:self.content_set];
		self.available_content_amount = [NSNumber numberWithInt:[[self.data_source performSelector:NSSelectorFromString(self.content_type)] count]];
	}
	
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	if ([[self.data_source performSelector:NSSelectorFromString(self.content_type)] count] == 0) {
		[self load_content];
		self.content_set = [self.data_source fetch_collection:self.content_type];
		[[self.data_source performSelector:NSSelectorFromString(self.content_type)] addObjectsFromArray:self.content_set];
		self.available_content_amount = [NSNumber numberWithInt:[[self.data_source performSelector:NSSelectorFromString(self.content_type)] count]];
	}
}

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
	int length;
	if (section == 0) {
		length = [self.displayed_content_amount integerValue];
	} else if (section == 1) {
		length = 2;
	}
	return length;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	UITableViewCell *cell;
	
	if (indexPath.section == 1) {
		static NSString *CellIdentifier = @"Cell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		if (indexPath.row == 0) {
			[cell.textLabel setText:@"refresh"];
		} else if (indexPath.row == 1) {
			[cell.textLabel setText:@"write one"];
		}
	} else if ([indexPath indexAtPosition:1] < [self.available_content_amount integerValue]) {
		id content = [self contentForIndexPath:indexPath];
		NSString *CellIdentifier = [NSString stringWithFormat:@"%@_%@", [content className], [content performSelector:(NSSelectorFromString([NSString stringWithFormat:@"%@Id", [[content className] lowercaseString]]))]];
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
				
			[cell setMain_text:[content main_text]];
			[cell setAdditional_text:[content additional_text]];
		}
	}
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		id content = [self contentForIndexPath:indexPath];
		
		return [InspirationCell cellHeightForMainText:[content main_text]
												   additional:[content additional_text]
												  width:[[self view] frame].size.width];
	} else {
		return 44;
	}
}

- (id)contentForIndexPath:(NSIndexPath *)indexPath {
	return [[self.data_source performSelector:NSSelectorFromString(self.content_type)] objectAtIndex:[indexPath indexAtPosition:1]];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			NSArray *insertableRows;
			if ([[self available_content_amount] integerValue] <= [[self displayed_content_amount] integerValue] + 2) {
				self.content_page = [NSNumber numberWithInt:[self.content_page integerValue] + 1];
				[self load_content];
			}
			
			NSNumber *difference = [NSNumber numberWithInt:[available_content_amount integerValue] - [displayed_content_amount integerValue]];
			
			if ([difference integerValue] >= 3) {
				insertableRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] inSection:0],
														   [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 1 inSection:0],
														   [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 2 inSection:0], nil];
				self.displayed_content_amount = [NSNumber numberWithInt:[self.displayed_content_amount integerValue] + 3];
			} else if ([difference integerValue] == 2) {
				insertableRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] inSection:0],
														   [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 1 inSection:0], nil];
				self.displayed_content_amount = [NSNumber numberWithInt:[self.displayed_content_amount integerValue] + 2];
			} else if ([difference integerValue] == 1) {
				insertableRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] inSection:0], nil];
				self.displayed_content_amount = [NSNumber numberWithInt:[self.displayed_content_amount integerValue] + 1];				
			} else {
				insertableRows = [NSArray arrayWithObjects:nil];
			}
			
			[self.tableView insertRowsAtIndexPaths:insertableRows withRowAnimation:UITableViewRowAnimationRight];
			[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
		} else if (indexPath.row == 1) {
			ContributionController *contributionController = [[ContributionController alloc] initWithContentType:[[[self.data_source performSelector:NSSelectorFromString(self.content_type)] objectAtIndex:0] className] andManagedObjectContext:[data_source moc]];
			[self presentModalViewController:contributionController animated:YES];
			[contributionController release];
		}
	} else {
	
    // Navigation logic may go here. Create and push another view controller.
	 InspectionController *inspectionController = [[InspectionController alloc] initWithContent:[self contentForIndexPath:indexPath]];

	 [self.navigationController pushViewController:inspectionController animated:YES];
	 [inspectionController release];
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

