//
//  GoalOwnership.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GoalOwnership : NSManagedObject {
	NSString *goalOwnershipId;
	NSString *derivedDescription;
	NSString *progress;
	NSString *complete;
	NSString *userId;
}

@property (nonatomic, retain) NSString *goalOwnershipId;
@property (nonatomic, retain) NSString *derivedDescription;
@property (nonatomic, retain) NSString *progress;
@property (nonatomic, retain) NSString *complete;
@property (nonatomic, retain) NSString *userId;

-(NSString *)main_text;
-(NSString *)additional_text;

@end