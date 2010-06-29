//
//  Goal.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Goal : NSObject {
	NSString *goalId;
	NSString *description;
	NSString *progress;
	NSString *complete;
}

@property (nonatomic, retain) NSString *goalId;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *progress;
@property (nonatomic, retain) NSString *complete;

-(NSString *)main_text;
-(NSString *)additional_text;

@end
