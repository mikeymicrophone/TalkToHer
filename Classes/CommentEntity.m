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

-(NSString *)main_text {
	return [self text];
}

-(NSString *)additional_text {
	return @"";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

-(BOOL)matches:(NSManagedObject *)po {
    return [[self text] isEqualToString:[po valueForKey:@"text"]] && ([[self targetId] integerValue] == [[po valueForKey:@"targetId"] integerValue]) && [[self targetType] isEqualToString:[po targetType]];
}

-(void)updateWith:(Comment *)c {
	[self setText:[c text]];
}

@end
