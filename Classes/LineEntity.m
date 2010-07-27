//
//  LineEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import "LineEntity.h"
#import "Line.h"

@implementation LineEntity

-(NSString *)main_text {
	return [self phrasing];
}

-(NSString *)additional_text {
	return @"";
}

-(void)setWrittenContent:(NSString *)writtenContent {
	[self setPhrasing:writtenContent];
}

-(BOOL)matches:(NSManagedObject *)po {
    return [[self phrasing] isEqualToString:[po valueForKey:@"phrasing"]];
}

-(BOOL)createRemote {
    Line *l = [[Line alloc] initWithManagedObject:self];
    [l createRemote];
    [self setValue:[NSNumber numberWithInt:[[l lineId] integerValue]] forKey:@"lineId"];
    [l release];
}

-(NSString *)getRemoteClassIdName {
    return @"lineId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	delayed = NO;
}

@end
