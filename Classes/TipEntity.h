//
//  TipEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Tip;

@interface TipEntity : NSManagedObject {
	BOOL delayed;
}
-(Tip *)objectiveResource;
-(NSString *)main_text;
-(NSString *)additional_text;
-(void)setWrittenContent:(NSString *)writtenContent;
-(BOOL)matches:(NSManagedObject *)po;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
-(void)updateWith:(Tip *)t;
@end
