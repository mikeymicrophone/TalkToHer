//
//  ExerciseEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Exercise;

@interface ExerciseEntity : NSManagedObject {
	BOOL delayed;
}
-(Exercise *)objectiveResource;
-(NSString *)main_text;
-(NSString *)additional_text;
-(void)setWrittenContent:(NSString *)writtenContent;
-(BOOL)matches:(NSManagedObject *)po;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(void)updateWith:(Exercise *)e;
-(void)updateComments;
-(void)updateRatings;
-(void)updateTags;
-(NSNumber *)myRating;
-(float)averageRating;
-(NSString *)averageRatingText;
-(NSInteger)ratingCount;
-(NSString *)ratingCountText;
-(NSNumber *)commentCount;
-(NSString *)commentCountText;

@end
