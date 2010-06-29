//
//  Exercise.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Exercise.h"


@implementation Exercise

@synthesize exerciseId, name, description;

-(NSString *)main_text {
	return name;
}
-(NSString *)additional_text {
	return description;
}

@end
