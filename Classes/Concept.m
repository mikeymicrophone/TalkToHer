//
//  Concept.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Concept.h"
#import "ConceptEntity.h"

@implementation Concept

@synthesize conceptId, name, userId;

-(void)persistInMoc {
	ConceptEntity *ps = [[ConceptEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Concept" inManagedObjectContext:[[[UIApplication sharedApplication] delegate] managedObjectContext]] insertIntoManagedObjectContext:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
    [ps setValue:name forKey:@"name"];
    [ps setValue:[NSNumber numberWithInt:[conceptId integerValue]] forKey:@"conceptId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    [ps release];	
}

@end
