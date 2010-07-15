//
//  Exercise.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Exercise : NSManagedObject {
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

-(NSString *)main_text;
-(NSString *)additional_text;
-(id)get_commentary;
-(void)setWrittenContent:(NSString *)writtenContent;
-(void)saveInRequest;
@end
