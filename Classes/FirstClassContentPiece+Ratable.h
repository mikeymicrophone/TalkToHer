//
//  FirstClassContentPiece+Ratable.h
//  TalkToHer
//
//  Created by Michael Schwab on 8/6/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstClassContentPiece.h"

@interface FirstClassContentPiece (Ratable)

-(NSNumber *)myRating;
-(float)averageRating;
-(NSString *)averageRatingText;
-(NSInteger)ratingCount;
-(NSString *)ratingCountText;
-(void)updateRatings;
@end
