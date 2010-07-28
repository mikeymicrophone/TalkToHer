//
//  ExerciseEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import "ExerciseEntity.h"
#import "Exercise.h"

@implementation ExerciseEntity

-(NSString *)main_text {
	return [self moniker];
}

-(NSString *)additional_text {
	return [self instruction];
}

-(void)setWrittenContent:(NSString *)writtenContent {
	[self setInstruction:writtenContent];
}

-(BOOL)matches:(NSManagedObject *)po {
    return [[self instruction] isEqualToString:[po valueForKey:@"instruction"]] && 
			[[self moniker] isEqualToString:[po valueForKey:@"moniker"]];
}

-(BOOL)createRemote {
    Exercise *e = [[Exercise alloc] initWithManagedObject:self];
    [e createRemote];
    [self setValue:[NSNumber numberWithInt:[[e exerciseId] integerValue]] forKey:@"exerciseId"];
    [e release];
}

-(Exercise *)objectiveResource {
	return [[Exercise alloc] initWithManagedObject:self];
}

-(void)updateWith:(Exercise *)e {
	[self setMoniker:[e moniker]];
	[self setInstruction:[e instruction]];
}

-(NSString *)getRemoteClassIdName {
    return @"exerciseId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	delayed = NO;
}

@end
