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
	
	self.lines_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lines"] autorelease];
	self.tips_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tips"] autorelease];
	self.exercises_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exercises"] autorelease];
	
	[data_source loadDataSegmentOfType:@"lines" andAlertCell:lines_cell];
	[data_source loadDataSegmentOfType:@"tips" andAlertCell:tips_cell];
	[data_source loadDataSegmentOfType:@"exercises" andAlertCell:exercises_cell];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell;
	
	if (indexPath.section == 0) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"lines"];
		if (cell == nil) {
			cell = lines_cell;
			[lines_cell start_spinning];
		}
	} else if (indexPath.section == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"tips"];
		if (cell == nil) {
			cell = tips_cell;
			[tips_cell start_spinning];
		}
	} else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"exercises"];
		if (cell == nil) {
			cell = exercises_cell;
			[exercises_cell start_spinning];
		}
	} else if (indexPath.section == 3) {
		if (data_source.userId == nil) {
			cell = [tableView dequeueReusableCellWithIdentifier:@"log in"];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"log in"] autorelease];
				[[cell textLabel] setText:@"log in"];
			}
		} else {
			cell = [tableView dequeueReusableCellWithIdentifier:@"goals"];
			if (cell == nil) {
				self.goals_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goals"] autorelease];
				cell = goals_cell;
			}
		}
	}
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section < 3) {
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
