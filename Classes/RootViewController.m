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
#import "InfoController.h"
#import "DataDelegate.h"
#import "Line.h"
#import "Tip.h"
#import "Exercise.h"
#import "UserEntity.h"
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
	
	NSArray *loadable_data_types = [NSArray arrayWithObjects:@"lines", @"tips", @"exercises", nil];
	
	[[[[UIApplication sharedApplication] delegate] data_source] loadRemoteDataOfTypes:loadable_data_types forCellDelegate:self];
}

-(LoaderCell *)cellForContent:(NSString *)type {
	LoaderCell *c;
	if ([type isEqualToString:@"Line"]) {
		c = lines_cell;
	} else if ([type isEqualToString:@"Tip"]) {
		c = tips_cell;
	} else if ([type isEqualToString:@"Exercise"]) {
		c = exercises_cell;
	} else if ([type isEqualToString:@"GoalOwnership"]) {
		c = goals_cell;
	}
	return c;
}

-(IBAction)goToSite {
	if ([[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
		NSEntityDescription *e = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
		NSFetchRequest *f = [[NSFetchRequest alloc] init];
		
		[f setEntity:e];
		[f setPredicate:[NSPredicate predicateWithFormat:@"userId == %d", [[[[UIApplication sharedApplication] delegate] userIsLoggedIn] integerValue]]];
		[f setPropertiesToFetch:[NSArray arrayWithObjects:@"username", @"password", nil]];
		
		NSError *error = nil;
		NSArray *results = [[[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:f error:&error];
		[f release];
		
		UserEntity *u = [results objectAtIndex:0];
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lineoftheday.com/user_sessions/iphone_login?user_session%%5Busername%%5D%%3D%@&user_session%%5Bpassword%%5D%%3D%@", [u username], [u password]]]];
	} else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://lineoftheday.com"]];
	}
}

-(IBAction)about {
	InfoController *infoController = [[InfoController alloc] initWithNibName:nil bundle:nil];
	[self presentModalViewController:infoController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	NSInteger fromInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
	if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		lines_cell.coloredLabel.center = CGPointMake(160, lines_cell.coloredLabel.center.y);
		tips_cell.coloredLabel.center = CGPointMake(160, lines_cell.coloredLabel.center.y);
		exercises_cell.coloredLabel.center = CGPointMake(160, lines_cell.coloredLabel.center.y);
		goals_cell.coloredLabel.center = CGPointMake(160, goals_cell.coloredLabel.center.y);
		
		lines_cell.spinner.center = CGPointMake(290, lines_cell.spinner.center.y);
		tips_cell.spinner.center = CGPointMake(290, tips_cell.spinner.center.y);
		exercises_cell.spinner.center = CGPointMake(290, exercises_cell.spinner.center.y);
		goals_cell.spinner.center = CGPointMake(290, goals_cell.spinner.center.y);
		
		site.center = CGPointMake(242, site.center.y);
	} else {
		lines_cell.coloredLabel.center = CGPointMake(100, lines_cell.coloredLabel.center.y);
		tips_cell.coloredLabel.center = CGPointMake(170, lines_cell.coloredLabel.center.y);
		exercises_cell.coloredLabel.center = CGPointMake(265, lines_cell.coloredLabel.center.y);
		goals_cell.coloredLabel.center = CGPointMake(350, goals_cell.coloredLabel.center.y);
		
		lines_cell.spinner.center = CGPointMake(450, lines_cell.spinner.center.y);
		tips_cell.spinner.center = CGPointMake(450, tips_cell.spinner.center.y);
		exercises_cell.spinner.center = CGPointMake(450, exercises_cell.spinner.center.y);
		goals_cell.spinner.center = CGPointMake(450, goals_cell.spinner.center.y);
		
		site.center = CGPointMake(400, site.center.y);
	}	
}

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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		lines_cell.coloredLabel.center = CGPointMake(100, lines_cell.coloredLabel.center.y);
		tips_cell.coloredLabel.center = CGPointMake(170, lines_cell.coloredLabel.center.y);
		exercises_cell.coloredLabel.center = CGPointMake(265, lines_cell.coloredLabel.center.y);
		goals_cell.coloredLabel.center = CGPointMake(350, goals_cell.coloredLabel.center.y);
		
		lines_cell.spinner.center = CGPointMake(450, lines_cell.spinner.center.y);
		tips_cell.spinner.center = CGPointMake(450, tips_cell.spinner.center.y);
		exercises_cell.spinner.center = CGPointMake(450, exercises_cell.spinner.center.y);
		goals_cell.spinner.center = CGPointMake(450, goals_cell.spinner.center.y);
		
		site.center = CGPointMake(400, site.center.y);
	} else {
		lines_cell.coloredLabel.center = CGPointMake(160, lines_cell.coloredLabel.center.y);
		tips_cell.coloredLabel.center = CGPointMake(160, lines_cell.coloredLabel.center.y);
		exercises_cell.coloredLabel.center = CGPointMake(160, lines_cell.coloredLabel.center.y);
		goals_cell.coloredLabel.center = CGPointMake(160, goals_cell.coloredLabel.center.y);
		
		lines_cell.spinner.center = CGPointMake(290, lines_cell.spinner.center.y);
		tips_cell.spinner.center = CGPointMake(290, tips_cell.spinner.center.y);
		exercises_cell.spinner.center = CGPointMake(290, exercises_cell.spinner.center.y);
		goals_cell.spinner.center = CGPointMake(290, goals_cell.spinner.center.y);
		
		site.center = CGPointMake(242, site.center.y);
	}
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
                [image release];
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
	self.lines_cell = nil;
	self.goals_cell = nil;
	self.tips_cell = nil;
	self.exercises_cell = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
