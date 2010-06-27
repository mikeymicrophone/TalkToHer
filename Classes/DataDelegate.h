//
//  DataDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataDelegate : NSObject {
	NSMutableArray *lines;
	NSMutableArray *tips;
	NSMutableArray *goals;
	NSMutableArray *exercises;
}

@property (nonatomic, retain) NSMutableArray *lines;
@property (nonatomic, retain) NSMutableArray *tips;
@property (nonatomic, retain) NSMutableArray *goals;
@property (nonatomic, retain) NSMutableArray *exercises;

-(void)initialize_data;

@end
