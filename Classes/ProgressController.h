//
//  ProgressController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/16/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoalOwnership;
@class DataDelegate;

@interface ProgressController : UIViewController {
	IBOutlet UITextField *new_progress;
	IBOutlet UITextView *description;
	IBOutlet UITextView *previous_progress;
	IBOutlet UITextView *plus;
	GoalOwnership *goalOwnership;
}

@property (nonatomic, retain) IBOutlet UITextField *new_progress;
@property (nonatomic, retain) IBOutlet UITextView *previous_progress;
@property (nonatomic, retain) IBOutlet UITextView *description;
@property (nonatomic, retain) GoalOwnership *goalOwnership;

-(IBAction)update;

@end
