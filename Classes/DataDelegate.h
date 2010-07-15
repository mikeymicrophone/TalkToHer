//
//  DataDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LoaderCell.h"

@interface DataDelegate : NSObject {
	NSMutableArray *lines;
	NSMutableArray *tips;
	NSMutableArray *goals;
	NSMutableArray *exercises;
	NSString *userId;
	NSString *server_location;
	NSDictionary *class_names;
	NSManagedObjectContext *moc;
}

@property (nonatomic, retain) NSMutableArray *lines;
@property (nonatomic, retain) NSMutableArray *tips;
@property (nonatomic, retain) NSMutableArray *goals;
@property (nonatomic, retain) NSMutableArray *exercises;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *server_location;
@property (nonatomic, retain) NSDictionary *class_names;
@property (nonatomic, retain) NSManagedObjectContext *moc;

-(void)initialize_data;
-(NSArray *)fetch_collection:(NSString *)type;
-(NSArray *)propertiesToFetchForType:(NSString *)type;
-(void)addAndPersistData:(NSArray *)data ofType:(NSString *)type;
-(void)loadDataSegmentOfType:(NSString *)type andAlertCell:(LoaderCell *)cell;
-(BOOL)itemExistsInStore:(NSManagedObject *)item;
@end
