//
//  CommentEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Comment;

@interface CommentEntity : NSManagedObject {
	BOOL delayed;
}
-(Comment *)objectiveResource;
-(NSString *)main_text;
-(NSString *)additional_text;	
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(BOOL)matches:(NSManagedObject *)po;
-(void)updateWith:(Comment *)c;
@end
