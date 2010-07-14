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
	self.displayed_content_amount = [NSNumber numberWithInt:3];
	self.data_source = source;
	self.available_content_amount = [NSNumber numberWithInt:[[self.data_source performSelector:NSSelectorFromString(self.content_type)] count]];
	self.content_page = [NSNumber numberWithInt:1];
	
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
//		[self load_content];
		self.content_set = [self.data_source fetch_collection:self.content_type];
		NSLog(@"just fetched data from db");
		[[self.data_source performSelector:NSSelectorFromString(self.content_type)] addObjectsFromArray:self.content_set];
	}
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
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
	NSLog(@"data: %@", [self.data_source performSelector:NSSelectorFromString(self.content_type)]);
	return [[self.data_source performSelector:NSSelectorFromString(self.content_type)] objectAtIndex:[indexPath indexAtPosition:1]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		
		if (indexPath.row == 0) {
		
			if ([[self available_content_amount] integerValue] <= [[self displayed_content_amount] integerValue] + 2) {
				self.content_page = [NSNumber numberWithInt:[self.content_page integerValue] + 1];
				[self load_content];
			}
			
			NSArray *insertedRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] inSection:0],
															  [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 1 inSection:0],
															  [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 2 inSection:0], nil];
			self.displayed_content_amount = [NSNumber numberWithInt:[self.displayed_content_amount integerValue] + 3];
			[self.tableView insertRowsAtIndexPaths:insertedRows withRowAnimation:UITableViewRowAnimationRight];
		} else if (indexPath.row == 1) {
			ContributionController *contributionController = [[ContributionController alloc] initWithContentType:[[[self.data_source performSelector:NSSelectorFromString(self.content_type)] objectAtIndex:0] className]];
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

