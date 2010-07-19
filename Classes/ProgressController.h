//
//  ProgressController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/16/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoalOwnership;
@class DataDelegate;

@interface ProgressController : UIViewController {
	IBOutlet UITextField *new_progress;
	IBOutlet UITextView *description;
	IBOutlet UITextView *previous_progress;
	GoalOwnership *goalOwnership;
	DataDelegate *data_source;
}

@property (nonatomic, retain) IBOutlet UITextField *new_progress;
@property (nonatomic, retain) IBOutlet UITextView *previous_progress;
@property (nonatomic, retain) IBOutlet UITextView *description;
@property (nonatomic, retain) GoalOwnership *goalOwnership;
@property (nonatomic, retain) DataDelegate *data_source;

-(IBAction)update;

@end
