//
//  Exercise.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class ExerciseEntity;

@interface Exercise : NSObject {
	NSString *exerciseId;
	NSString *moniker;
	NSString *instruction;
	NSString *userId;
	BOOL delayed;
}

@property (nonatomic, retain) NSString *exerciseId;
@property (nonatomic, retain) NSString *moniker;
@property (nonatomic, retain) NSString *instruction;
@property (nonatomic, retain) NSString *userId;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(BOOL)matches:(NSManagedObject *)po;
-(void)persistInMoc:(NSManagedObjectContext *)moc;

@end
