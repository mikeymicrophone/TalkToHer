//
//  InspectionController.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InspectionController.h"
#import "InspirationCell.h"


@implementation InspectionController

@synthesize content;


-(id)initWithContent:(id)contentObj {
	if (![super initWithStyle:UITableViewStylePlain])
		return nil;
	
	self.content = contentObj;
	return self;
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
    // Return the number of sections.
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
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
	} else if (indexPath.section == 1) {
		CellIdentifier = @"rating";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:@"3.72"];
			[cell setAdditional_text:@"after 314 ratings"];
		}
	} else if (indexPath.section == 2) {
		CellIdentifier = @"tags";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:@"14 tags"];
			[cell setAdditional_text:@"kino, touch, first minute...11 more"];
		}
    } else if (indexPath.section == 3) {
		CellIdentifier = @"comments";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:@"2 comments"];
			[cell setAdditional_text:@"cookie monster would say that"];
		}
	} else if (indexPath.section == 4) {
		CellIdentifier = @"approach";
		
		cell = (InspirationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[InspirationCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell setMain_text:@"I just said this."];
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
		height = [InspirationCell cellHeightForMainText:@"3.72"
											 additional:@"after 314 ratings"
												  width:[[self view] frame].size.width];		
	} else if (indexPath.section == 2) {
		height = [InspirationCell cellHeightForMainText:@"2 tags"
											 additional:@"black, magic, attraction... and 3 more"
												  width:[[self view] frame].size.width];		
	} else if (indexPath.section == 3) {
		height = [InspirationCell cellHeightForMainText:@"38 comments"
											 additional:@"Cookie monster would love cokie roberts"
												  width:[[self view] frame].size.width];		
	} else if (indexPath.section == 4) {
		height = [InspirationCell cellHeightForMainText:@"I just said this."
											 additional:nil
												  width:[[self view] frame].size.width];		
	}
	return height;
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
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

