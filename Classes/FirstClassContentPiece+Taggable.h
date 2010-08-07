//
//  FirstClassContentPiece+Taggable.h
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstClassContentPiece.h"

@interface FirstClassContentPiece (Taggable) 
-(NSInteger)tagCount;
-(NSString *)tagCountText;	
-(NSString *)tagSummary;
-(void)updateTags;
@end
