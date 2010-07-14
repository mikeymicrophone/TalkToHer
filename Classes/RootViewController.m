//
//  RootViewController.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Exco Ventures 2010. All rights reserved.
//

#import "RootViewController.h"
#import "InspirationController.h"
#import "IdentificationController.h"
#import "DataDelegate.h"
#import "Line.h"
#import "Tip.h"
#import "Exercise.h"
#import "LoaderCell.h"
#import <dispatch/dispatch.h>

@implementation RootViewController

@synthesize data_source, lines_cell, tips_cell, goals_cell, exercises_cell, fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.data_source = [[DataDelegate alloc] init];
	[self.data_source initialize_data];
	data_source.moc = [self managedObjectContext];
	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.talktoher.lines", NULL);
	dispatch_async(queue, ^{
		NSArray *content = [Line findAllRemote];
		dispatch_async(dispatch_get_main_queue(), ^{
			[lines_cell stop_spinning];
			[data_source addAndPersistData:content ofType:@"lines"];
		});
	});
	dispatch_release(queue);

	queue = dispatch_queue_create("com.talktoher.tips", NULL);
	dispatch_async(queue, ^{
		NSArray *content = [Tip findAllRemote];
		dispatch_async(dispatch_get_main_queue(), ^{
			[tips_cell stop_spinning];
			[data_source addAndPersistData:content ofType:@"tips"];
		});
	});
	dispatch_release(queue);

	queue = dispatch_queue_create("com.talktoher.exercises", NULL);
	dispatch_async(queue, ^{
		NSArray *content = [Exercise findAllRemote];
		dispatch_async(dispatch_get_main_queue(), ^{
			[exercises_cell stop_spinning];
			[data_source addAndPersistData:content ofType:@"exercises"];
		});
	});
	dispatch_release(queue);
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
	// Return YES for supported orientations.
	return YES;
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell;
	
	if (indexPath.section == 0) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"lines"];
		if (cell == nil) {
			self.lines_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lines"] autorelease];
			cell = lines_cell;
			[lines_cell start_spinning];
		}
	} else if (indexPath.section == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"tips"];
		if (cell == nil) {
			self.tips_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tips"] autorelease];
			cell = tips_cell;
			[tips_cell start_spinning];
		}
	} else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"exercises"];
		if (cell == nil) {
			self.exercises_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exercises"] autorelease];
			cell = exercises_cell;
			[exercises_cell start_spinning];
		}
	} else if (indexPath.section == 3) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"goals"];
		if (cell == nil) {
			self.goals_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goals"] autorelease];
			cell = goals_cell;
		}
	} else if (indexPath.section == 4) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"log in"];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"log in"] autorelease];
			[[cell textLabel] setText:@"log in"];
		}
	}
	
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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
	if (indexPath.section < 4) {
		InspirationController *inspirationController = [[InspirationController alloc] initWithContentType:[[[self tableView:tableView cellForRowAtIndexPath:indexPath] textLabel] text] andDataSource:data_source];
		[self.navigationController pushViewController:inspirationController animated:YES];
		[inspirationController release];
	} else {
		IdentificationController *identificationController = [[IdentificationController alloc] initWithNibName:nil bundle:nil];
		[identificationController setData_source:data_source];
		[self presentModalViewController:identificationController animated:YES];
		[identificationController release];		
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

