//
//  Concept.h
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Concept : NSObject {
	NSString *name;
	NSString *conceptId;
	NSString *userId;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *conceptId;
@property (nonatomic, retain) NSString *userId;

@end
