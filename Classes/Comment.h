//
//  Comment.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class CommentEntity;

@interface Comment : NSObject {
	NSString *userId;
	NSString *commentId;
	NSString *targetId;
	NSString *tagetType;
	NSString *text;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *commentId;
@property (nonatomic, retain) NSString *targetId;
@property (nonatomic, retain) NSString *targetType;
@property (nonatomic, retain) NSString *text;

-(Comment *)initWithManagedObject:(CommentEntity *)ps;
-(void)persistInMoc:(NSManagedObjectContext *)moc;
@end
