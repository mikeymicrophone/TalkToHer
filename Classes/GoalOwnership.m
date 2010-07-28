//
//  GoalOwnership.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "GoalOwnership.h"
#import "GoalOwnershipEntity.h"
#import "Response.h"
#import "ORConnection.h"

@implementation GoalOwnership

@synthesize goalOwnershipId, derivedDescription, progress, complete, completionStatus, remainingDaysText, userId;

-(id)initWithManagedObject:(NSManagedObject *)ps {
    [self init];
    
    self.derivedDescription = [ps derivedDescription];
	self.progress = [ps progress];
	self.complete = [ps complete];
	self.completionStatus = [ps completionStatus];
	self.remainingDaysText = [ps remainingDaysText];
    self.userId = [ps userId];
	self.goalOwnershipId = [ps goalOwnershipId];

    return self;
}

-(NSString *)main_text {
	return derivedDescription;
}

-(NSString *)additional_text {
	return [[completionStatus stringByAppendingString:@"\n"] stringByAppendingString:remainingDaysText];
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    GoalOwnershipEntity *ps = [[GoalOwnershipEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"GoalOwnership" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:derivedDescription forKey:@"derivedDescription"];
	[ps setValue:progress forKey:@"progress"];
	[ps setValue:[NSNumber numberWithInt:[complete integerValue]] forKey:@"complete"];
	[ps setValue:completionStatus forKey:@"completionStatus"];
	[ps setValue:remainingDaysText forKey:@"remainingDaysText"];
    [ps setValue:[NSNumber numberWithInt:[goalOwnershipId integerValue]] forKey:@"goalOwnershipId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
    [ps release];
}

-(NSArray *)excludedPropertyNames {
	NSArray *exclusions = [NSArray arrayWithObjects:@"derivedDescription", @"completionStatus", @"remainingDaysText", nil];
	return [[super excludedPropertyNames] arrayByAddingObjectsFromArray:exclusions];
}

-(void)markForDelayedSubmission {
	delayed = YES;
}

-(void)hasBeenSubmitted {
	delayed = NO;
}

+ (NSArray *)findAllForUserWithId:(NSString *)personId {
    NSString *goalsPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
						  [self getRemoteSite],
						   @"users",
						   personId,
						   [self getRemoteCollectionName],
						   [self getRemoteProtocolExtension]];
	
    Response *res = [ORConnection get:goalsPath withUser:[[self class] getRemoteUser] 
						andPassword:[[self class] getRemotePassword]];
    return [self allFromXMLData:res.body];
}

@end
