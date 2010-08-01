//
//  TagEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "TagEntity.h"
#import "Tag.h"

@implementation TagEntity

-(Tag *)objectiveResource {
	return [[Tag alloc] initWithManagedObject:self];
}

-(NSString *)getRemoteClassIdName {
    return @"tagId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

@end
