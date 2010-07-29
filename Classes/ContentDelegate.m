//
//  ContentDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ContentDelegate.h"


@implementation ContentDelegate

@synthesize loaded_amount, displayed_amount, content_page, content_type, content, order;

-(id)initWithContentType:(NSString *)klass {
	self = [super init];
	self.content_page = [NSNumber numberWithInt:1];
	self.displayed_amount = [NSNumber numberWithInt:3];
	self.content_type = klass;
	[self update_content];
	self.order = [self generateRandomizedArrayOfLength:loaded_amount];
	return self;
}

-(void)insertNewContent:(NSManagedObject *)c {
	[content insertObject:c atIndex:[displayed_amount integerValue]];
	[self displayRows:1];
}

-(NSManagedObject *)objectAtIndex:(NSInteger)index {
	[content objectAtIndex:index];
}

-(void)update_content {
	self.content = [[[[UIApplication sharedApplication] delegate] data_source] fetch_collection:content_type];
	if (content) {
		self.loaded_amount = [NSNumber numberWithInt:[content count]];
	} else {
		self.loaded_amount = [NSNumber numberWithInt:0];
	}
}

-(void)download_more {
	[[[[UIApplication sharedApplication] delegate] data_source] loadDataSegmentOfType:[[[[[[UIApplication sharedApplication] delegate] data_source] class_names] allKeysForObject:content_type] objectAtIndex:0]
																		 andAlertCell:[[[[[UIApplication sharedApplication] delegate] navigationController] bottomViewController] cellForContent:content_type]];
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

-(NSMutableArray *)generateRandomizedArrayOfLength:(NSInteger)length {
	NSMutableArray *indices = [NSMutableArray arrayWithObjects:0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, nil];
	NSUInteger count = [indices count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [indices exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
	return indices;
}
@end
