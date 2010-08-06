//
//  Exercise.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Exercise.h"
#import "ObjectiveResourceConfig.h"
#import "ExerciseEntity.h"

@implementation Exercise

@synthesize exerciseId, moniker, instruction, userId;
-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    self.instruction = [ps instruction];
	self.moniker = [ps moniker];
    self.userId = [ps userId];
	self.exerciseId = [ps exerciseId];
    
    return self;
}

-(BOOL)matches:(NSManagedObject *)po {
    return [instruction isEqualToString:[po valueForKey:@"instruction"]] && 
			[moniker isEqualToString:[po valueForKey:@"moniker"]];
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    ExerciseEntity *ps = [[ExerciseEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:instruction forKey:@"instruction"];
	[ps setValue:moniker forKey:@"moniker"];
    [ps setValue:[NSNumber numberWithInt:[exerciseId integerValue]] forKey:@"exerciseId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    [ps release];
}

@end
