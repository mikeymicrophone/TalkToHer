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
	[self update_content];
	return self;
}

-(void)update_content {
	self.content = [[[[UIApplication sharedApplication] delegate] data_source] fetch_collection:content_type];
	if (content) {
		self.loaded_amount = [NSNumber numberWithInt:[content count]];
	} else {
		self.loaded_amount = [NSNumber numberWithInt:0];
	}
}

-(NSInteger)undisplayed_row_count {
	return [loaded_amount integerValue] - [displayed_amount integerValue];
}

-(NSInteger)display_amount {
	if ([displayed_amount integerValue] >= [loaded_amount integerValue]) {
		return [loaded_amount integerValue];
	} else {
		return [displayed_amount integerValue];
	}
}

-(void)displayRows:(NSInteger)rows {
	self.displayed_amount = [NSNumber numberWithInt:[displayed_amount integerValue] + rows];
}
@end
