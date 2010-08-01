//
//  CommentEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Comment;

@interface CommentEntity : NSManagedObject {
	BOOL delayed;
}
-(Comment *)objectiveResource;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;


@end
