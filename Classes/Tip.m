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

@synthesize tipId, advice, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating, userId;

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

-(void)setWrittenContent:(NSString *)writtenContent {
	self.advice = writtenContent;
	self.userId = @"1";
}

- (NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"commentCount", @"tagCount", @"ratingCount", @"recentComment", @"recentTags", @"averageRating", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}


@end
