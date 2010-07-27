//
//  LineEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LineEntity : NSManagedObject {
	BOOL delayed;
}

-(NSString *)main_text;
-(NSString *)additional_text;
-(void)setWrittenContent:(NSString *)writtenContent;
-(BOOL)matches:(NSManagedObject *)po;
-(void)markForDelayedSubmission;
-(void)hasBeenSubmitted;
@end
