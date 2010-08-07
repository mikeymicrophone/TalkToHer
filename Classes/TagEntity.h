//
//  TagEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Tag;

@interface TagEntity : NSManagedObject {
	BOOL delayed;
}

-(Tag *)objectiveResource;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(void)updateWith:(Tag *)t;
@end
