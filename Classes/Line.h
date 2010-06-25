//
//  Line.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Line : NSObject {
	NSString *lineId;
	NSString *phrasing;
	NSString *userId;
}

@property (nonatomic, retain) NSString *lineId;
@property (nonatomic, retain) NSString *phrasing;
@property (nonatomic, retain) NSString *userId;

@end
