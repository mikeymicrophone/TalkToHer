//
//  Rating.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class RatingEntity;

@interface Rating : NSObject {
	NSString *userId;
	NSString *ratingId;
	NSString *targetType;
	NSString *targetId;
	NSString *opinion;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *ratingId;
@property (nonatomic, retain) NSString *targetType;
@property (nonatomic, retain) NSString *targetId;
@property (nonatomic, retain) NSString *opinion;

-(Rating *)initWithManagedObject:(RatingEntity *)po;
-(void)persistInMoc:(NSManagedObjectContext *)moc;
@end
