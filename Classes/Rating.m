//
//  Rating.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Rating.h"
#import "RatingEntity.h"
#import "Response.h"
#import "ORConnection.h"

@implementation Rating

@synthesize userId, ratingId, targetType, targetId, opinion;

-(Rating *)initWithManagedObject:(RatingEntity *)ps {
	[self init];
    
    self.opinion = [ps opinion];
	self.targetId = [ps targetId];
	self.targetType = [ps targetType];
    self.userId = [ps userId];
	self.ratingId = [ps ratingId];
    
    return self;	
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
	NSFetchRequest *f = [[NSFetchRequest alloc] init];
	NSEntityDescription *e = [NSEntityDescription entityForName:@"Rating" inManagedObjectContext:moc];
	[f setEntity:e];
	[f setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"userId = %@ and targetId = %@ and targetType = '%@'",
													   [self userId], [self targetId], [self targetType]]]];
	NSError *error;
	NSArray *results = [moc executeFetchRequest:f error:&error];
	
	for (RatingEntity *r in results) {
		NSLog(@"deleting: %@", r);
		[moc deleteObject:r];
	}
	
	RatingEntity *ps = [[RatingEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Rating" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
	[ps setValue:targetType	forKey:@"targetType"];
	[ps setValue:[NSNumber numberWithInt:[targetId integerValue]] forKey:@"targetId"];
	[ps setValue:[NSNumber numberWithInt:[ratingId integerValue]] forKey:@"ratingId"];
	[ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
	[ps setValue:[NSNumber numberWithInt:[opinion integerValue]] forKey:@"opinion"];
	if ([ratingId integerValue] == 0) {
		[ps markForDelayedSubmission];
	}
	
	NSLog(@"and replacing: %@", ps);

	NSError *mocSaveError = nil;
    if (![moc save:&mocSaveError]) { NSLog(@"Unresolved error %@, %@", mocSaveError, [mocSaveError userInfo]); }
    [ps release];
}

+ (NSArray *)findAllFor:(NSObject *)ratable {
	
    NSString *ratingsPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
							  [self getRemoteSite],
							  [ratable getRemoteCollectionName],
							  [ratable getRemoteId],
							  [self getRemoteCollectionName],
							  [self getRemoteProtocolExtension]];
	
    Response *res = [ORConnection get:ratingsPath withUser:[[self class] getRemoteUser] 
						  andPassword:[[self class] getRemotePassword]];
	NSError **aError;
	if([res isError]) {
		*aError = res.error;
		return [NSArray array];
	} else {
		return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
	}
}

-(BOOL)matches:(NSManagedObject *)po {
	return [[self targetType] isEqualToString:[po targetType]] && ([[self targetId] integerValue] == [[po targetId] integerValue]) && ([[self userId] integerValue] == [[po userId] integerValue]);
}

@end
