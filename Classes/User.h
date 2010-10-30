//
//  User.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/7/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
	NSString *username;
	NSString *userId;
	NSString *password;
	NSString *password_confirmation;
	NSString *email;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *password_confirmation;
@property (nonatomic, retain) NSString *email;

@end
