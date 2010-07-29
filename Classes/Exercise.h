//
//  Exercise.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class ExerciseEntity;

@interface Exercise : NSObject {
	NSString *exerciseId;
	NSString *moniker;
	NSString *instruction;
	NSString *recentComment;
	NSString *recentTags;
	NSString *commentCount;
	NSString *tagCount;
	NSString *ratingCount;
	NSString *averageRating;
	NSString *userId;
	BOOL delayed;
}

@property (nonatomic, retain) NSString *exerciseId;
@property (nonatomic, retain) NSString *moniker;
@property (nonatomic, retain) NSString *instruction;
@property (nonatomic, retain) NSString *recentComment;
@property (nonatomic, retain) NSString *recentTags;
@property (nonatomic, retain) NSString *commentCount;
@property (nonatomic, retain) NSString *tagCount;
@property (nonatomic, retain) NSString *ratingCount;
@property (nonatomic, retain) NSString *averageRating;
@property (nonatomic, retain) NSString *userId;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(id)get_commentary;
-(NSString *)main_text;
-(NSString *)additional_text;
-(NSString *)full_text;
-(BOOL)matches:(NSManagedObject *)po;
-(void)persistInMoc:(NSManagedObjectContext *)moc;

@end
