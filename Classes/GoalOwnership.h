//
//  GoalOwnership.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class GoalOwnershipEntity;

@interface GoalOwnership : NSObject {
	NSString *goalOwnershipId;
	NSString *derivedDescription;
	NSString *progress;
	NSString *complete;
	NSString *completionStatus;
	NSString *remainingDaysText;
	NSString *repetitions;
	NSString *userId;
	BOOL delayed;
}

@property (nonatomic, retain) NSString *goalOwnershipId;
@property (nonatomic, retain) NSString *derivedDescription;
@property (nonatomic, retain) NSString *progress;
@property (nonatomic, retain) NSString *complete;
@property (nonatomic, retain) NSString *completionStatus;
@property (nonatomic, retain) NSString *remainingDaysText;
@property (nonatomic, retain) NSString *repetitions;
@property (nonatomic, retain) NSString *userId;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(NSString *)main_text;
-(NSString *)additional_text;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(void)persistInMoc:(NSManagedObjectContext *)moc;
+(NSArray *)findAllForUserWithId:(NSString *)personId;
@end
