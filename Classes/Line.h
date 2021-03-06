//
//  Line.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class LineEntity;

@interface Line : NSObject {
	NSString *lineId;
	NSString *phrasing;
	NSString *userId;
}

@property (nonatomic, retain) NSString *lineId;
@property (nonatomic, retain) NSString *phrasing;
@property (nonatomic, retain) NSString *userId;

-(id)initWithManagedObject:(NSManagedObject *)ps;
-(BOOL)matches:(NSManagedObject *)po;
-(void)persistInMoc:(NSManagedObjectContext *)moc;

@end
