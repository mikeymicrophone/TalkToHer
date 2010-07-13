//
//  DataDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/27/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataDelegate : NSObject {
	NSMutableArray *lines;
	NSMutableArray *tips;
	NSMutableArray *goals;
	NSMutableArray *exercises;
	NSString *userId;
	NSString *server_location;
	NSManagedObjectContext *moc;
}

@property (nonatomic, retain) NSMutableArray *lines;
@property (nonatomic, retain) NSMutableArray *tips;
@property (nonatomic, retain) NSMutableArray *goals;
@property (nonatomic, retain) NSMutableArray *exercises;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *server_location;
@property (nonatomic, retain) NSManagedObjectContext *moc;

-(void)initialize_data;
-(void)addAndPersistData:(NSArray *)data ofType:(NSString *)type;

@end
