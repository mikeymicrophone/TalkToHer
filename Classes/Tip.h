//
//  Tip.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class TipEntity;

@interface Tip : NSObject {
	NSString *tipId;
	NSString *advice;
	NSString *userId;
}

@property (nonatomic, retain) NSString *tipId;
@property (nonatomic, retain) NSString *advice;
@property (nonatomic, retain) NSString *userId;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(BOOL)matches:(NSManagedObject *)po;
-(void)persistInMoc:(NSManagedObjectContext *)moc;

@end
