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

-(void)saveInRequest {
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://localhost:3000/tips"]];
	[request setHTTPMethod:@"POST"];
	NSString *body = [NSString stringWithFormat:@"advice=%@", advice];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
}


@end
