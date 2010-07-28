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

@synthesize lines_cell, tips_cell, goals_cell, exercises_cell;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.lines_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lines"] autorelease];
	self.tips_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tips"] autorelease];
	self.exercises_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exercises"] autorelease];
	self.goals_cell = [[[LoaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goals"] autorelease];
	[goals_cell retain];
	
	NSArray *loadable_data_types = [NSArray arrayWithObjects:@"lines", @"tips", @"exercises", nil];
	
	[[[[UIApplication sharedApplication] delegate] data_source] loadRemoteDataOfTypes:loadable_data_types forCellDelegate:self];
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
		}
	} else if (indexPath.section == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"tips"];
		if (cell == nil) {
			cell = tips_cell;
		}
	} else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"exercises"];
		if (cell == nil) {
			cell = exercises_cell;
		}
	} else if (indexPath.section == 3) {
		if ([[[[UIApplication sharedApplication] delegate] data_source] userId] == nil) {
			cell = [tableView dequeueReusableCellWithIdentifier:@"log in"];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"log in"] autorelease];
				UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login"]];
				image.center = cell.center;
				[cell addSubview:image];
			}
		} else {
			cell = [tableView dequeueReusableCellWithIdentifier:@"goals"];
			if (cell == nil) {
				cell = goals_cell;
			}
		}
	}
	cell.selectionStyle = UITableViewCellSelectionStyleGray;

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section < 3) {
		ContentDelegate *source = [[[[UIApplication sharedApplication] delegate] data_source] performSelector:NSSelectorFromString([[self tableView:tableView cellForRowAtIndexPath:indexPath] reuseIdentifier])];
		InspirationController *inspirationController = [[InspirationController alloc] initWithContentSource:source];
		[self.navigationController pushViewController:inspirationController animated:YES];
		[inspirationController release];
	} else {
		if ([[[[UIApplication sharedApplication] delegate] data_source] userId] != nil) {
			ContentDelegate *source = [[[[UIApplication sharedApplication] delegate] data_source] performSelector:NSSelectorFromString([[self tableView:tableView cellForRowAtIndexPath:indexPath] reuseIdentifier])];
			InspirationController *inspirationController = [[InspirationController alloc] initWithContentSource:source];
			[self.navigationController pushViewController:inspirationController animated:YES];
			[inspirationController release];
		} else {
			IdentificationController *identificationController = [[IdentificationController alloc] initWithNibName:nil bundle:nil];
			[self presentModalViewController:identificationController animated:YES];
			[identificationController release];
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
