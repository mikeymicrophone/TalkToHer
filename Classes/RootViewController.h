//
//  RootViewController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Exco Ventures 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class InspirationController;
@class DataDelegate;
@class LoaderCell;

@interface RootViewController : UITableViewController {
	DataDelegate *data_source;
	LoaderCell *lines_cell;
	LoaderCell *tips_cell;
	LoaderCell *goals_cell;
	LoaderCell *exercises_cell;

@private
	NSFetchedResultsController *fetchedResultsController_;
	NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) DataDelegate *data_source;
@property (nonatomic, retain) LoaderCell *lines_cell;
@property (nonatomic, retain) LoaderCell *tips_cell;
@property (nonatomic, retain) LoaderCell *goals_cell;
@property (nonatomic, retain) LoaderCell *exercises_cell;

-(BOOL)lotd_is_reachable;

@end
