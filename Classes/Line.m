//
//  Line.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Line.h"
#import "ObjectiveResourceConfig.h"
#import "LineEntity.h"
#import "Comment.h"

@implementation Line

@synthesize lineId, userId, phrasing;

-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    self.phrasing = [ps phrasing];
    self.userId = [ps userId];
	self.lineId = [ps lineId];
    
    return self;
}

-(BOOL)matches:(NSManagedObject *)po {
    return [phrasing isEqualToString:[po valueForKey:@"phrasing"]];
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    LineEntity *ps = [[LineEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Line" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:phrasing forKey:@"phrasing"];
    [ps setValue:[NSNumber numberWithInt:[lineId integerValue]] forKey:@"lineId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    [ps release];
}

@end
