//
//  RatingEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Rating;

@interface RatingEntity : NSManagedObject {
	BOOL delayed;
}
-(Rating *)objectiveResource;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(BOOL)matches:(NSManagedObject *)po;
-(void)updateWith:(Rating *)c;
@end
