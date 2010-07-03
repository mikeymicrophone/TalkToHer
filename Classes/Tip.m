//
//  Tip.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Tip.h"
#import "ObjectiveResourceConfig.h"


@implementation Tip

@synthesize tipId, advice, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating;

-(NSString *)main_text {
	return advice;
}

-(NSString *)additional_text {
	return @"";
}

-(id)get_commentary {
	[ObjectiveResourceConfig setProtocolExtension:@"/inspect_content"];
	Tip *tip = [Tip findRemote:[self tipId]];
	[ObjectiveResourceConfig setProtocolExtension:@".xml"];
	return tip;
}

@end
