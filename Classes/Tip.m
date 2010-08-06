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

@synthesize tipId, advice, userId;
-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    self.advice = [ps advice];
    self.userId = [ps userId];
	self.tipId = [ps tipId];
    
    return self;
}

-(BOOL)matches:(NSManagedObject *)po {
    return [advice isEqualToString:[po valueForKey:@"advice"]];
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    TipEntity *ps = [[TipEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Tip" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:advice forKey:@"advice"];
    [ps setValue:[NSNumber numberWithInt:[tipId integerValue]] forKey:@"tipId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    [ps release];
}

@end
