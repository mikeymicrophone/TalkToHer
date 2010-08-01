//
//  Tag.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class TagEntity;

@interface Tag : NSObject {
	NSString *userId;
	NSString *tagId;
	NSString *concept;
	NSString *targetId;
	NSString *targetType;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *tagId;
@property (nonatomic, retain) NSString *concept;
@property (nonatomic, retain) NSString *targetId;
@property (nonatomic, retain) NSString *targetType;
-(Tag *)initWithManagedObject:(TagEntity *)ps;
-(void)persistInMoc:(NSManagedObjectContext *)moc;
	
@end