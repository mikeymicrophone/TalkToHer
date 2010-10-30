//
//  GoalSettingController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/29/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GoalSettingController : UIViewController {
	IBOutlet UITextField *repetitions;
	IBOutlet UITextField *days;
	IBOutlet UITextView *description;
	IBOutlet UILabel *heading;
	NSString *objectiveType;
	NSString *objectiveId;
	NSString *text;
}

@property (nonatomic, retain) NSString *objectiveType;
@property (nonatomic, retain) NSString *objectiveId;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UILabel *heading;

-(IBAction)submit;

@end
