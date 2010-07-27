//
//  Tip.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Tip.h"
#import "ObjectiveResourceConfig.h"


@implementation Tip

@synthesize tipId, advice, recentComment, recentTags, commentCount, tagCount, ratingCount, averageRating, userId;
-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    advice = [ps advice];
    userId = [ps userId];
    
    return self;
}

-(BOOL)matches:(NSManagedObject *)po {
    return [advice isEqualToString:[po valueForKey:@"advice"]];
}

-(TipEntity *)persistantSelfInMoc:(NSManagedObjectContext *)moc {
    TipEntity *ps = [[TipEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Tip" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
	//    NSLog(@"lineId is a: %@ and is: %d, a %@", [lineId className], [lineId integerValue], [[lineId integerValue] className]);
    [ps setValue:advice forKey:@"advice"];
    [ps setValue:[NSNumber numberWithInt:[tipId integerValue]] forKey:@"tipId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    NSLog(@"persisting object: %@", ps);
    return ps;
}

-(id)get_commentary {
	[ObjectiveResourceConfig setProtocolExtension:@"/inspect_content"];
	Tip *tip = [Tip findRemote:[self tipId]];
	[ObjectiveResourceConfig setProtocolExtension:@".xml"];
	return tip;
}

- (NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"commentCount", @"tagCount", @"ratingCount", @"recentComment", @"recentTags", @"averageRating", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}

@end
