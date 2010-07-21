//
//  IdentificationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataDelegate;

@interface IdentificationController : UIViewController {
	IBOutlet UITextField *username_field;
	IBOutlet UITextField *password_field;
	UITextField *email_field;
	UILabel *email_heading;
	IBOutlet UIButton *login_button;
	DataDelegate *data_source;
	BOOL email_shown;
}

@property (nonatomic, retain) UITextField *username_field;
@property (nonatomic, retain) UITextField *password_field;
@property (nonatomic, retain) UITextField *email_field;
@property (nonatomic, retain) UILabel *email_heading;
@property (nonatomic, retain) DataDelegate *data_source;

-(IBAction)log_in;
-(IBAction)sign_up;
-(void)get_identity:(NSString *)username;
@end
