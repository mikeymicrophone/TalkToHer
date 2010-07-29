//
//  Goal.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/29/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Goal : NSObject {
	NSString *repetitions;
	NSString *days;
	NSString *userId;
	NSString *goalId;
	NSString *objectiveType;
	NSString *objectiveId;
}

@property (nonatomic, retain) NSString *repetitions;
@property (nonatomic, retain) NSString *days;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *goalId;
@property (nonatomic, retain) NSString *objectiveType;
@property (nonatomic, retain) NSString *objectiveId;

@end
