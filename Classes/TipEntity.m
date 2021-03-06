//
//  TipEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Charismatic Comfort. All rights reserved.
//

#import "TipEntity.h"
#import "Tip.h"
#import "Comment.h"
#import "Tag.h"
#import "Rating.h"

@implementation TipEntity

-(NSString *)main_text {
	return [self advice];
}

-(NSString *)additional_text {
	return @"";
}

-(NSString *)full_text {
	return [self advice];
}

-(NSString *)getRemoteCollectionName {
	return @"tips";
}

-(void)setWrittenContent:(NSString *)writtenContent {
	[self setAdvice:writtenContent];
}

-(BOOL)matches:(NSManagedObject *)po {
    return [[self advice] isEqualToString:[po valueForKey:@"advice"]];
}

-(BOOL)createRemote {
    Tip *t = [[Tip alloc] initWithManagedObject:self];
    [t createRemote];
    [self setValue:[NSNumber numberWithInt:[[t tipId] integerValue]] forKey:@"tipId"];
    [t release];
}

-(Tip *)objectiveResource {
	return [[Tip alloc] initWithManagedObject:self];
}

-(void)updateWith:(Tip *)t {
	[self setAdvice:[t advice]];
}

-(NSString *)getRemoteClassIdName {
    return @"tipId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

@end
