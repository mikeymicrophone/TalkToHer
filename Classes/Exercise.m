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

@synthesize exerciseId, name, description, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating, userId;

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

-(void)setWrittenContent:(NSString *)writtenContent {
	self.description = writtenContent;
	self.userId = @"1";
}

-(void)saveInRequest {
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://localhost:3000/exercises"]];
	[request setHTTPMethod:@"POST"];
	NSString *body = [NSString stringWithFormat:@"description=%@", description];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
}

@end
