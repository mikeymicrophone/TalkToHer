//
//  ContentDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ContentDelegate.h"


@implementation ContentDelegate

@synthesize loaded_amount, displayed_amount, content_page, content_type, content;

-(id)initWithContentType:(NSString *)klass {
	self = [super init];
	self.content_page = [NSNumber numberWithInt:1];
	self.displayed_amount = [NSNumber numberWithInt:3];
	self.content_type = klass;
	self.content = [[[[UIApplication sharedApplication] delegate] data_source] fetch_collection:klass];
	self.loaded_amount = [NSNumber numberWithInt:[self.content count]];
	NSLog(@"content of %@: %@", [self content_type], [self content]);
	return self;
}

-(NSInteger)undisplayed_row_count {
	return [loaded_amount integerValue] - [displayed_amount integerValue];
}

-(void)displayRows:(NSInteger)rows {
	self.displayed_amount = [NSNumber numberWithInt:[displayed_amount integerValue] + rows];
}
@end
