//
//  DataDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class LoaderCell;
@class ContentDelegate;

@interface DataDelegate : NSObject {
	NSString *userId;
	NSString *server_location;
	NSDictionary *class_names;
	ContentDelegate *lines;
	ContentDelegate *tips;
	ContentDelegate *exercises;
	ContentDelegate *goals;
	BOOL connectionIsFresh;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *server_location;
@property (nonatomic, retain) NSDictionary *class_names;
@property (nonatomic, retain) ContentDelegate *lines;
@property (nonatomic, retain) ContentDelegate *tips;
@property (nonatomic, retain) ContentDelegate *exercises;
@property (nonatomic, retain) ContentDelegate *goals;

-(void)initialize_constants;
-(void)initialize_content;
-(NSArray *)fetch_collection:(NSString *)type;
-(NSString *)classNameFor:(NSString *)identifier;
-(NSArray *)propertiesToFetchForType:(NSString *)type;
-(NSArray *)unidentified_set_of_type:(NSString *)type;
-(void)persistData:(NSArray *)data ofType:(NSString *)type;
-(void)loadDataSegmentOfType:(NSString *)type andAlertCell:(LoaderCell *)cell;
-(NSManagedObject *)itemExistsInStore:(NSObject *)item;
-(NSManagedObject *)item:(NSObject *)i existsInSet:(NSArray *)us;
-(void)setMyUserId:(NSString *)user_id forUsername:(NSString *)user_name withPassword:(NSString *)password;
-(void)attemptIdentification;
-(void)attemptDelayedSubmissions;
-(BOOL)lotd_is_reachable;
-(void)loadRemoteDataOfTypes:(NSArray *)types forCellDelegate:(UITableViewController *)cell_controller;
-(NSManagedObjectContext *)moc;
-(void)increment:(NSString *)type multiple:(BOOL)multiple;
-(void)insertNewElement:(NSManagedObject *)e multiple:(BOOL)multiple;
@end
