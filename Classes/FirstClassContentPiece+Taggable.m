//
//  FirstClassContentPiece+Taggable.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "FirstClassContentPiece+Taggable.h"
#import "Tag.h"

@implementation FirstClassContentPiece (Taggable)

-(void)updateTags {
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:[Tag findAllFor:self] ofType:@"tags"];
}

@end
