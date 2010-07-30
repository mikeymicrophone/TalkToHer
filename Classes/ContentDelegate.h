//
//  ContentDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ContentDelegate : NSObject {
	NSNumber *loaded_amount;
	NSNumber *displayed_amount;
	NSNumber *hidden_amount;
	NSNumber *content_page;
	NSString *content_type;
	NSMutableArray *content;
	NSMutableArray *order;
}

@property (nonatomic, retain) NSNumber *loaded_amount;
@property (nonatomic, retain) NSNumber *displayed_amount;
@property (nonatomic, retain) NSNumber *hidden_amount;
@property (nonatomic, retain) NSNumber *content_page;
@property (nonatomic, retain) NSString *content_type;
@property (nonatomic, retain) NSMutableArray *content;
@property (nonatomic, retain) NSMutableArray *order;

-(id)initWithContentType:(NSString *)klass;
-(NSInteger)undisplayed_row_count;
-(void)displayRows:(NSInteger)rows;
-(NSInteger)display_amount;
-(NSManagedObject *)objectAtIndex:(NSInteger)index;
-(NSMutableArray *)generateRandomizedArrayOfLength:(NSInteger)length startingWith:(NSInteger)start;
-(NSMutableArray *)ascendingArrayOfLength:(NSInteger)length startingWith:(NSInteger)start;
-(NSMutableArray *)shuffledArrayWithArray:(NSMutableArray *)array;
-(void)load_content;
-(void)update_content;
-(void)reorder_content;
-(void)download_more;
-(void)insertNewContent;
-(void)removeOrderedIndex:(NSInteger)index;
-(NSMutableArray *)orderArrayWithoutNoncontiguousIndices;
@end
