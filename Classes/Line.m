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
	NSLog(@"setting content: %@", writtenContent);
	self.phrasing = writtenContent;
	self.userId = @"1";
}

-(void)saveInRequest {
	NSLog(@"saving line with request");
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://localhost:3000/lines"]];
	[request setHTTPMethod:@"POST"];
	NSString *body = [NSString stringWithFormat:@"phrasing=%@", phrasing];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	NSLog(@"connection: %@", connection);
	[connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"response from grapes");
}

@end
