//
//  ContentDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import "ContentDelegate.h"

@implementation ContentDelegate

@synthesize loaded_amount, displayed_amount, hidden_amount, content_page, content_type, content, order;

-(id)initWithContentType:(NSString *)klass {
	self = [super init];
	self.content_page = [NSNumber numberWithInt:1];
	self.displayed_amount = [NSNumber numberWithInt:0];
	self.content_type = klass;
	[self load_content];
	[self reorder_content];
	return self;
}

#pragma mark -
#pragma mark content delivery

-(NSManagedObject *)objectAtIndex:(NSInteger)index {
	if (!order) {
		NSLog(@"re-setting order");
		self.order = [self generateRandomizedArrayOfLength:[content count] - [hidden_amount integerValue] startingWith:0];
	}
	return [content objectAtIndex:[[self.order objectAtIndex:index] integerValue]];
}

-(void)load_content {
	self.content = [[[[UIApplication sharedApplication] delegate] data_source] fetch_collection:content_type];
	if (content) {
		self.loaded_amount = [NSNumber numberWithInt:[content count]];
	} else {
		self.loaded_amount = [NSNumber numberWithInt:0];
	}
}

-(void)update_content:(BOOL)multiple {
	[self load_content];
	self.order = [self arrayWithoutNoncontiguousIndices:[self arrayWithoutNoncontiguousIndices:order]];
	if (multiple) {
		NSInteger amount_of_new_content = [loaded_amount integerValue] - [order count];
		[order addObjectsFromArray:[self generateShuffledArrayOfLength:amount_of_new_content startingWith:[order count]]];
	}
	self.hidden_amount = [NSNumber numberWithInt:0];
}

#pragma mark -
#pragma mark content order control

-(void)reorder_content {
	if ([self.order count] == [loaded_amount integerValue] - [hidden_amount integerValue]) {
		self.order = [self shuffledArrayWithArray:order];
	} else {
		self.order = [self generateShuffledArrayOfLength:[loaded_amount integerValue] startingWith:0];
	}
}

#pragma mark -
#pragma mark content amount control

-(void)download_more {
	[[[[UIApplication sharedApplication] delegate] data_source] loadDataSegmentOfType:[[[[[[UIApplication sharedApplication] delegate] data_source] class_names] allKeysForObject:content_type] objectAtIndex:0]
																		 andAlertCell:[[[[[UIApplication sharedApplication] delegate] navigationController] bottomViewController] cellForContent:content_type]];
}

#pragma mark -
#pragma mark number of rows control

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
}

#pragma mark content creation aftermath

-(void)insertNewContent:(BOOL)multiple {
	[self update_content:multiple];
	if (!multiple) {
		[self.order insertObject:[NSNumber numberWithInt:[content count] - 1] atIndex:[displayed_amount integerValue]];
		[self displayRows:1];
	}
}

#pragma mark content hiding aftermath

-(void)removeOrderedIndex:(NSInteger)index {
	[self.order removeObjectAtIndex:index];
	[self displayRows:-1];
	self.hidden_amount = [NSNumber numberWithInt:[hidden_amount integerValue] + 1];
}

#pragma mark -
#pragma mark order array generation

-(NSMutableArray *)generateShuffledArrayOfLength:(NSInteger)length startingWith:(NSInteger)start {
	NSMutableArray *indices = [self ascendingArrayOfLength:length startingWith:start];
	NSMutableArray *randomized = [self shuffledArrayWithArray:indices];
	return randomized;
}

-(NSMutableArray *)ascendingArrayOfLength:(NSInteger)length startingWith:(NSInteger)start {
	NSMutableArray *indices = [[NSMutableArray alloc] init];
	for (NSInteger j = 0; j < length; j++) {
		[indices insertObject:[NSNumber numberWithInt:start++] atIndex:j];
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

#pragma mark -
#pragma mark order array adjustment

-(NSMutableArray *)arrayWithoutNoncontiguousIndices:(NSArray *)array {
	NSInteger length = [[self largestValueInArray:array] integerValue];
	NSMutableArray *indices = [NSMutableArray arrayWithCapacity:length];
	for (NSInteger i = 0; i <= length; i++) {
		[indices insertObject:[NSNumber numberWithInt:[array indexOfObject:[NSNumber numberWithInt:i]]] atIndex:i];
	}
	[indices removeObject:[NSNumber numberWithInt:2147483647]];
	return indices;
}

-(NSNumber *)largestValueInArray:(NSArray *)array {
	NSNumber *highest = [NSNumber numberWithInt:0];
	for (NSNumber *num in array) {
		if ([num integerValue] > [highest integerValue]) {
			highest = num;
		}
	}
	return highest;
}
@end
