//
//  RootViewController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Exco Ventures 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InspirationController;
@class DataDelegate;

@interface RootViewController : UITableViewController {
	DataDelegate *data_source;
}

@property (nonatomic, retain) DataDelegate *data_source;

@end
