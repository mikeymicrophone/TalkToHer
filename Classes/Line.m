//
//  Line.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Line.h"


@implementation Line

@synthesize lineId, userId, phrasing;

-(NSString *)main_text {
	return phrasing;
}

-(NSString *)additional_text {
	return @"";
}


@end
