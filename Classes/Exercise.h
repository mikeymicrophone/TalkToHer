//
//  Exercise.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Exercise : NSObject {
	NSString *exerciseId;
	NSString *name;
	NSString *description;
}

@property (nonatomic, retain) NSString *exerciseId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;

-(NSString *)main_text;
-(NSString *)additional_text;

@end
