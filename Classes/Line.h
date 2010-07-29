//
//  Line.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class LineEntity;

@interface Line : NSObject {
	NSString *lineId;
	NSString *phrasing;
	NSString *userId;
	NSString *recentComment;
	NSString *recentTags;
	NSString *commentCount;
	NSString *tagCount;
	NSString *ratingCount;
	NSString *averageRating;
}

@property (nonatomic, retain) NSString *lineId;
@property (nonatomic, retain) NSString *phrasing;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *recentComment;
@property (nonatomic, retain) NSString *recentTags;
@property (nonatomic, retain) NSString *commentCount;
@property (nonatomic, retain) NSString *tagCount;
@property (nonatomic, retain) NSString *ratingCount;
@property (nonatomic, retain) NSString *averageRating;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(id)get_commentary;
-(NSString *)main_text;
-(NSString *)additional_text;
-(NSString *)full_text;
-(BOOL)matches:(NSManagedObject *)po;
-(void)persistInMoc:(NSManagedObjectContext *)moc;

@end
