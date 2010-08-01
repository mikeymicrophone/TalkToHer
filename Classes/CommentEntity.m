//
//  CommentEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "CommentEntity.h"
#import "Comment.h"

@implementation CommentEntity

-(Comment *)objectiveResource {
	return [[Comment alloc] initWithManagedObject:self];
}

-(NSString *)getRemoteClassIdName {
    return @"commentId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

@end
