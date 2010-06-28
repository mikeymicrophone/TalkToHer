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


@implementation InspirationController

@synthesize content_set, content_type, displayed_content_amount, data_source;

-(void)load_content {
	[ObjectiveResourceConfig setSite:@"http://lineoftheday.com/"];
	
	if (self.content_type == @"lines") {
		self.content_set = [Line findAllRemote];
	} else if (self.content_type == @"tips") {
		self.content_set = [Tip findAllRemote];
	} else if (self.content_type == @"goals") {
		self.content_set = [Goal findAllRemote];
	} else if (self.content_type == @"exercises") {
		self.content_set = [Exercise findAllRemote];
	}
	
	if (self.content_set == nil) {
		self.content_set = [data_source performSelector:NSSelectorFromString(content_type)];
	} else {
		[[self.data_source performSelector:NSSelectorFromString(self.content_type)] addObjectsFromArray:self.content_set];
	}
	
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self load_content];
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

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int length;
	if (section == 0) {
		length = [self.displayed_content_amount integerValue];
	} else if (section == 1) {
		length = 1;
	}
	return length;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    }
    
	//NSLog(@"about to configure cell.");
	//NSLog(@"content set: %@", content_set);
	
	// Configure the cell...
	if (indexPath.section == 0) {
		if ([self content_type] == @"lines") {
			//NSLog(@"what is happening");
			//NSLog(@"content set, %@", content_set);
			//NSLog(@"index path, %@", indexPath);
			//NSLog(@"index at position, %@", indexPath.section);
			[[cell textLabel] setText:[[content_set objectAtIndex:indexPath.row] phrasing]];
		} else if (self.content_type == @"tips") {
			[[cell textLabel] setText:[[[self content_set] objectAtIndex:[indexPath indexAtPosition:1]] advice]];
		} else if (self.content_type == @"goals") {
			[[cell textLabel] setText:[[[self content_set] objectAtIndex:[indexPath indexAtPosition:1]] description]];
		} else if (self.content_type == @"exercises") {
			[[cell textLabel] setText:[[[self content_set] objectAtIndex:[indexPath indexAtPosition:1]] name]];
		}
	} else {
		[cell.textLabel setText:@"refresh"];
	}
	
	//NSLog(@"configured cell.");
    
    return cell;
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
		NSArray *insertedRows = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] inSection:0],
														  [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 1 inSection:0],
														  [NSIndexPath indexPathForRow:[self.displayed_content_amount integerValue] + 2 inSection:0], nil];
		self.displayed_content_amount = [NSNumber numberWithInt:[self.displayed_content_amount integerValue] + 3];
		[self.tableView insertRowsAtIndexPaths:insertedRows withRowAnimation:UITableViewRowAnimationRight];
	}
	
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

