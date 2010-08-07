//
//  FirstClassContentPiece+Ratable.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/6/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "FirstClassContentPiece+Ratable.h"
#import "Rating.h"

@implementation FirstClassContentPiece (Ratable)

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

-(void)updateRatings {
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:[Rating findAllFor:self] ofType:@"ratings"];
}

@end
