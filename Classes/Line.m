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

@implementation Line

@synthesize lineId, userId, phrasing, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating;

-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    phrasing = [ps phrasing];
    userId = [ps userId];
    
    return self;
}

-(id)get_commentary {
	[ObjectiveResourceConfig setProtocolExtension:@"/inspect_content"];
	Line *line = [Line findRemote:[self lineId]];
	[ObjectiveResourceConfig setProtocolExtension:@".xml"];
	return line;
}

-(BOOL)matches:(NSManagedObject *)po {
    return [phrasing isEqualToString:[po valueForKey:@"phrasing"]];
}

-(LineEntity *)persistantSelfInMoc:(NSManagedObjectContext *)moc {
    LineEntity *ps = [[LineEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Line" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
//    NSLog(@"lineId is a: %@ and is: %d, a %@", [lineId className], [lineId integerValue], [[lineId integerValue] className]);
    [ps setValue:phrasing forKey:@"phrasing"];
    [ps setValue:[NSNumber numberWithInt:[lineId integerValue]] forKey:@"lineId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    NSLog(@"persisting object: %@", ps);
    return ps;
}

- (NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"commentCount", @"tagCount", @"ratingCount", @"recentComment", @"recentTags", @"averageRating", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}

@end
