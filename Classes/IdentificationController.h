//
//  IdentificationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IdentificationController : UIViewController {
	IBOutlet UITextField *username_field;
	IBOutlet UITextField *password_field;
}

@property (nonatomic, retain) UITextField *username_field;
@property (nonatomic, retain) UITextField *password_field;

- (IBAction)log_in;
- (IBAction)sign_up;

@end
