//
//  RootViewController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Charismatic Comfort 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class InspirationController;
@class LoaderCell;

@interface RootViewController : UITableViewController {
	LoaderCell *lines_cell;
	LoaderCell *tips_cell;
	LoaderCell *goals_cell;
	LoaderCell *exercises_cell;
	IBOutlet UIButton *site;
}

@property (nonatomic, retain) LoaderCell *lines_cell;
@property (nonatomic, retain) LoaderCell *tips_cell;
@property (nonatomic, retain) LoaderCell *goals_cell;
@property (nonatomic, retain) LoaderCell *exercises_cell;

-(LoaderCell *)cellForContent:(NSString *)type;
-(IBAction)goToSite;
-(IBAction)about;
-(void)moveButtonsForOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
