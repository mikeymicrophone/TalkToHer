//
//  UserSession.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/7/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserSession : NSObject {
	NSString *username;
	NSString *password;
	NSString *email;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;

@end
