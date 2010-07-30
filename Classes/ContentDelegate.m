//
//  ContentDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ContentDelegate.h"


@implementation ContentDelegate

@synthesize loaded_amount, displayed_amount, hidden_amount, content_page, content_type, content, order;

-(id)initWithContentType:(NSString *)klass {
	self = [super init];
	self.content_page = [NSNumber numberWithInt:1];
	self.displayed_amount = [NSNumber numberWithInt:3];
	self.content_type = klass;
	[self load_content];
	[self reorder_content];
//	NSLog(@"initWithContentType %@ %@", klass, order);
	return self;
}

-(void)insertNewContent {
	[self update_content];
	[self.order insertObject:[NSNumber numberWithInt:[content count] - 1] atIndex:[displayed_amount integerValue]];
	[self displayRows:1];
}

-(void)removeOrderedIndex:(NSInteger)index {
	[self.order removeObjectAtIndex:index];
	[self displayRows:-1];
	self.hidden_amount = [NSNumber numberWithInt:[hidden_amount integerValue] + 1];
}

-(NSManagedObject *)objectAtIndex:(NSInteger)index {
//	NSLog(@"order: %@", self.order);
//	NSLog(@"content: %@", self.content);
	if (!order) {
		NSLog(@"re-setting order");
		self.order = [self generateRandomizedArrayOfLength:[content count] - [hidden_amount integerValue]];
	}
	return [content objectAtIndex:[[self.order objectAtIndex:index] integerValue]];
}

-(void)load_content {
//	NSLog(@"load_content %@", content_type);
	self.content = [[[[UIApplication sharedApplication] delegate] data_source] fetch_collection:content_type];
	if (content) {
		self.loaded_amount = [NSNumber numberWithInt:[content count]];
	} else {
		self.loaded_amount = [NSNumber numberWithInt:0];
	}	
}

-(void)update_content {
	[self load_content];
	self.order = [self orderArrayWithoutTopIndices:[self.hidden_amount integerValue]];
	self.hidden_amount = [NSNumber numberWithInt:0];
}

-(void)reorder_content {
	if ([self.order count] == [loaded_amount integerValue] - [hidden_amount integerValue]) {
		self.order = [self shuffledArrayWithArray:order];
	} else {
		self.order = nil;
		self.order = [self generateRandomizedArrayOfLength:[loaded_amount integerValue]];
	}
	[order retain];
//	NSLog(@"order: %@, retain count %d", self.order, [self.order retainCount]);
}

-(void)download_more {
	[[[[UIApplication sharedApplication] delegate] data_source] loadDataSegmentOfType:[[[[[[UIApplication sharedApplication] delegate] data_source] class_names] allKeysForObject:content_type] objectAtIndex:0]
																		 andAlertCell:[[[[[UIApplication sharedApplication] delegate] navigationController] bottomViewController] cellForContent:content_type]];
}

-(NSInteger)undisplayed_row_count {
	return ([loaded_amount integerValue] - [displayed_amount integerValue]) - [hidden_amount integerValue];
}

-(NSInteger)display_amount {
	if ([displayed_amount integerValue] >= [loaded_amount integerValue]) {
		return [loaded_amount integerValue] - [hidden_amount integerValue];
	} else {
		return [displayed_amount integerValue];
	}
}

-(void)displayRows:(NSInteger)rows {
	self.displayed_amount = [NSNumber numberWithInt:[displayed_amount integerValue] + rows];
//	NSLog(@"displayed amount:%@", displayed_amount);
}

-(NSMutableArray *)generateRandomizedArrayOfLength:(NSInteger)length {
	NSMutableArray *indices = [self ascendingArrayOfLength:length];
	return [self shuffledArrayWithArray:indices];
}

-(NSMutableArray *)ascendingArrayOfLength:(NSInteger)length {
	NSMutableArray *indices = [[NSMutableArray alloc] init];
	for (NSInteger j = 0; j < length; j++) {
		[indices insertObject:[NSNumber numberWithInt:j] atIndex:j];
	}
	return indices;
}

-(NSMutableArray *)shuffledArrayWithArray:(NSMutableArray *)array {
	NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
	return array;	
}

-(NSMutableArray *)orderArrayWithoutTopIndices:(NSInteger)removedAmount {
	NSNumber *highest = [self largestValueInArray:self.order];
	for (NSInteger i = 0; i < removedAmount; i++) {
		[self.order removeObject:[NSNumber numberWithInt:[highest integerValue] - i]];
	}
}

-(NSNumber *)largestValueInArray:(NSMutableArray *)array {
	NSNumber *highest = [NSNumber numberWithInt:0];
	for (NSNumber *num in array) {
		if ([num integerValue] > [highest integerValue]) {
			highest = num;
		}
	}
	return highest;
}

@end
