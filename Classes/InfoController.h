//
//  InfoController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/30/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoController : UIViewController {
	IBOutlet UITextView *about;
}

@property (nonatomic, retain) UITextView *about;

-(IBAction)dismiss;
-(IBAction)sinns;
-(IBAction)approach_anxiety;
-(IBAction)lotd;	

@end
