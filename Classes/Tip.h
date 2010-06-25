//
//  Tip.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tip : NSObject {
	NSString *tipId;
	NSString *advice;
}

@property (nonatomic, retain) NSString *tipId;
@property (nonatomic, retain) NSString *advice;

@end
