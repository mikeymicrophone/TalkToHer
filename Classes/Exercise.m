//
//  Exercise.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Exercise.h"
#import "ObjectiveResourceConfig.h"


@implementation Exercise

@synthesize exerciseId, name, description, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating;

-(NSString *)main_text {
	return name;
}
-(NSString *)additional_text {
	return description;
}

-(id)get_commentary {
	[ObjectiveResourceConfig setProtocolExtension:@"/inspect_content"];
	Exercise *exercise = [Exercise findRemote:[self exerciseId]];
	[ObjectiveResourceConfig setProtocolExtension:@".xml"];
	return exercise;
}

@end
