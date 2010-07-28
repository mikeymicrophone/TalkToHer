//
//  TipEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import "TipEntity.h"
#import "Tip.h"

@implementation TipEntity

-(NSString *)main_text {
	return [self advice];
}

-(NSString *)additional_text {
	return @"";
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
	delayed = NO;
}

@end
