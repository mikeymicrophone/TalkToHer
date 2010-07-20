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
	DataDelegate *data_source;
}

@property (nonatomic, retain) UITextField *username_field;
@property (nonatomic, retain) UITextField *password_field;
@property (nonatomic, retain) DataDelegate *data_source;

-(IBAction)log_in;
-(IBAction)sign_up;
-(void)get_identity:(NSString *)username;
@end
