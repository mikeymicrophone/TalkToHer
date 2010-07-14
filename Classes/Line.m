//
//  Line.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Line.h"
#import "ObjectiveResourceConfig.h"


@implementation Line

@synthesize lineId, userId, phrasing, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating;

-(NSString *)main_text {
	return phrasing;
}

-(NSString *)additional_text {
	return @"";
}

-(id)get_commentary {
	[ObjectiveResourceConfig setProtocolExtension:@"/inspect_content"];
	Line *line = [Line findRemote:[self lineId]];
	[ObjectiveResourceConfig setProtocolExtension:@".xml"];
	return line;
}

-(void)setWrittenContent:(NSString *)writtenContent {
	self.phrasing = writtenContent;
	self.userId = @"1";
}

- (NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"commentCount", @"tagCount", @"ratingCount", @"recentComment", @"recentTags", @"averageRating", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}

@end
