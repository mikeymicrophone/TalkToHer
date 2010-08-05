//
//  LineEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import "LineEntity.h"
#import "Line.h"
#import "Comment.h"
#import "Tag.h"
#import "Rating.h"

@implementation LineEntity

-(NSString *)main_text {
	return [self phrasing];
}

-(NSString *)additional_text {
	return @"";
}

-(float)averageRating {
	if ([self ratingCount] == 0) return 0.0;
	float dividend = 0.0;
	for (RatingEntity *r in [self ratings]) {
		dividend += [[r opinion] floatValue];
	}
	return dividend/[self ratingCount];
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
		txt = [txt substringToIndex:[txt length] - 2];
	}
	return txt;	
}

-(NSInteger)commentCount {
	return [[self comments] count];
}

-(NSString *)commentCountText {
	NSString *txt = [NSString stringWithFormat:@"%d comments", [self commentCount]];
	if ([self commentCount] == 1) {
		txt = [txt substringToIndex:[txt length] - 1];
	}
	return txt;
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

-(Line *)objectiveResource {
	return [[Line alloc] initWithManagedObject:self];
}

-(void)updateWith:(Line *)l {
	[self setPhrasing:[l phrasing]];
}

-(void)updateRatings {
	NSArray *allRatings = [Rating findAllFor:self];
	for (Rating *r in allRatings) {
		[r persistInMoc:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
	}	
}

-(void)updateComments {
	NSArray *allComments = [Comment findAllFor:self];
	for (Comment *c in allComments) {
		[c persistInMoc:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
	}
}

-(void)updateTags {
	NSArray *allTags = [Tag findAllFor:self];
	for (Tag *t in allTags) {
		[t persistInMoc:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
	}
}

-(NSString *)getRemoteCollectionName {
	return @"lines";
}

-(NSString *)getRemoteClassIdName {
    return @"lineId";
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"delayed"];
}

@end
