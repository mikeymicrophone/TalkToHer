//
//  Tag.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "Tag.h"
#import "TagEntity.h"
#import <CoreData/CoreData.h>
#import "Response.h"
#import "ORConnection.h"

@implementation Tag

@synthesize concept, targetType, targetId, subjectType, subjectId, tagId, userId;

-(Tag *)initWithManagedObject:(TagEntity *)ps {
	[self init];
    
    self.concept = [ps concept];
	self.targetId = [ps targetId];
	self.targetType = [ps targetType];
    self.userId = [ps userId];
	self.tagId = [ps tagId];
	self.subjectId = [ps subjectId];
	self.subjectType = [ps subjectType];
    
    return self;	
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    TagEntity *ps = [[TagEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:targetType	forKey:@"targetType"];
	[ps setValue:concept forKey:@"concept"];
	[ps setValue:[NSNumber numberWithInt:[targetId integerValue]] forKey:@"targetId"];
    [ps setValue:subjectType forKey:@"subjectType"];
	[ps setValue:[NSNumber numberWithInt:[subjectId integerValue]] forKey:@"subjectId"];
    [ps setValue:[NSNumber numberWithInt:[tagId integerValue]] forKey:@"tagId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
	if ([tagId integerValue] == 0) {
		[ps markForDelayedSubmission];
	}
	
	NSError *mocSaveError = nil;
    if (![moc save:&mocSaveError]) { NSLog(@"Unresolved error %@, %@", mocSaveError, [mocSaveError userInfo]); }
    [ps release];
}

+ (NSArray *)findAllFor:(NSObject *)taggable {
	
    NSString *tagsPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
						  [self getRemoteSite],
						  [taggable getRemoteCollectionName],
						  [taggable getRemoteId],
						  [self getRemoteCollectionName],
						  [self getRemoteProtocolExtension]];
	NSLog(@"path: %@; taggable: %@; id: %@", tagsPath, taggable, [taggable getRemoteId]);
    Response *res = [ORConnection get:tagsPath withUser:[[self class] getRemoteUser] 
						  andPassword:[[self class] getRemotePassword]];
	NSError **aError;
	if([res isError]) {
		*aError = res.error;
		return nil;
	} else {
		return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
	}
}

-(BOOL)matches:(NSManagedObject *)po {
	return [[self targetType] isEqualToString:[po targetType]] && [[self subjectType] isEqualToString:[po subjectType]] && ([self targetId] == [po targetId]) && ([self subjectId] == [po subjectId]);
}

@end
