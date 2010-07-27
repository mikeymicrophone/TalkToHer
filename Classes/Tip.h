//
//  Tip.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class TipEntity;

@interface Tip : NSObject {
	NSString *tipId;
	NSString *advice;
	NSString *recentComment;
	NSString *recentTags;
	NSString *commentCount;
	NSString *tagCount;
	NSString *ratingCount;
	NSString *averageRating;
	NSString *userId;
}

@property (nonatomic, retain) NSString *tipId;
@property (nonatomic, retain) NSString *advice;
@property (nonatomic, retain) NSString *recentComment;
@property (nonatomic, retain) NSString *recentTags;
@property (nonatomic, retain) NSString *commentCount;
@property (nonatomic, retain) NSString *tagCount;
@property (nonatomic, retain) NSString *ratingCount;
@property (nonatomic, retain) NSString *averageRating;
@property (nonatomic, retain) NSString *userId;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(NSString *)main_text;
-(NSString *)additional_text;
-(id)get_commentary;
-(BOOL)matches:(NSManagedObject *)po;
-(TipEntity *)persistantSelfInMoc:(NSManagedObjectContext *)moc;

@end
