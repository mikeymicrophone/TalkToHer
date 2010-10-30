//
//  FirstClassContentPiece+Commendable.h
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstClassContentPiece.h"

@interface FirstClassContentPiece (Commendable)
-(void)updateComments;
-(NSNumber *)commentCount;
-(NSString *)commentCountText;
@end
