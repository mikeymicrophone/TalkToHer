//
//  TipEntity.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
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
