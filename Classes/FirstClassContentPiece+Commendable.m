//
//  FirstClassContentPiece+Commendable.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import "FirstClassContentPiece+Commendable.h"
#import "Comment.h"

@implementation FirstClassContentPiece (Commendable)

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

-(void)updateComments {
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:[Comment findAllFor:self] ofType:@"comments"];
}

@end
