//
//  ExerciseEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FirstClassContentPiece.h"
@class Exercise;

@interface ExerciseEntity : FirstClassContentPiece {
	BOOL delayed;
}
-(Exercise *)objectiveResource;
-(NSString *)main_text;
-(NSString *)additional_text;
-(NSString *)full_text;
-(void)setWrittenContent:(NSString *)writtenContent;
-(BOOL)matches:(NSManagedObject *)po;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(void)updateWith:(Exercise *)e;
@end
