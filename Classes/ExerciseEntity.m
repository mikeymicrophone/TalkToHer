//
//  ExerciseEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import "ExerciseEntity.h"
#import "Exercise.h"
#import "Comment.h"
#import "Tag.h"
#import "Rating.h"

@implementation ExerciseEntity

-(NSString *)main_text {
	return [self moniker];
}

-(NSString *)additional_text {
	return [self instruction];
}


-(NSNumber *)myRating {
	RatingEntity *mine = nil;
	for (RatingEntity *r in [self ratings]) {
		if ([r userId] == [[[UIApplication sharedApplication] delegate] userIsLoggedIn]) {
			mine = r;
		}
	}
	NSNumber *rating;
	if (mine) {
		rating = [NSNumber numberWithFloat:[[mine opinion] floatValue] / 10.0];
	} else {
		rating = [NSNumber numberWithFloat:0.0];
	}
	return rating;
}

-(float)averageRating {
	if ([self ratingCount] == 0) return 0.0;
	float dividend = 0.0;
	for (RatingEntity *r in [self ratings]) {
		dividend += [[r opinion] floatValue];
	}
	return dividend/([self ratingCount]*10);
}

-(NSString *)averageRatingText {
	return [NSString stringWithFormat:@"%.1f", [self averageRating]];
}

-(NSInteger)ratingCount {
	return [[self ratings] count];
}

-(NSString *)ratingCountText {
	NSString *txt = [NSString stringWithFormat:@"%d ratings", [self ratingCount]];
	if ([self ratingCount] == 1) {
		txt = [txt substringToIndex:[txt length] - 1];
	}
	return txt;	
}

-(NSNumber *)commentCount {
	return [NSNumber numberWithInt:[[self comments] count]];
}

-(NSString *)commentCountText {
	NSString *txt = [NSString stringWithFormat:@"%@ comments", [self commentCount]];
	if ([[self commentCount] integerValue] == 1) {
		txt = [txt substringToIndex:[txt length] - 1];
	}
	return txt;
}

-(void)updateRatings {
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:[Rating findAllFor:self] ofType:@"ratings"];
}

-(void)updateComments {
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:[Comment findAllFor:self] ofType:@"comments"];
}

-(void)updateTags {
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:[Tag findAllFor:self] ofType:@"tags"];
}

-(NSString *)getRemoteCollectionName {
	return @"exercises";
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
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

-(NSString *)full_text {
	return [self instruction];
}

@end
