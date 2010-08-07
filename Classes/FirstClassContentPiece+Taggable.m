//
//  FirstClassContentPiece+Taggable.m
//  TalkToHer
//
//  Created by Michael Schwab on 8/7/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "FirstClassContentPiece+Taggable.h"
#import "Tag.h"
#import "Concept.h"

@implementation FirstClassContentPiece (Taggable)

-(NSInteger)tagCount {
	return [[self tags] count];
}

-(NSString *)tagCountText {
	NSString *txt = [NSString stringWithFormat:@"%d tags", [self ratingCount]];
	if ([self tagCount] == 1) {
		txt = [txt substringToIndex:[txt length] - 1];
	}
	return txt;	
}

-(NSString *)tagSummary {
	NSString *summary = @"";
	NSFetchRequest *f = nil;
	for (TagEntity *t in [self tags]) {
		if ([[t subjectType] isEqualToString:@"Concept"]) {
			if (f == nil) {
				f = [[NSFetchRequest alloc] init];
				NSEntityDescription *e = [NSEntityDescription entityForName:@"Concept" inManagedObjectContext:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
				[f setEntity:e];				
			}
			[f setPredicate:[NSPredicate predicateWithFormat:[@"conceptId" stringByAppendingFormat:@" == %@", 
															  [NSNumber numberWithInt:[[t subjectId] integerValue]]]]];
			
			NSError *error = nil;
			NSArray *results = [[[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:f error:&error];
			
			if ([results count] == 0) {
				NSLog(@"missing concept #%@", [t subjectId]);
//				[[Concept findRemote:[t subjectId]] persistInMoc];
			} else {
				summary = [summary stringByAppendingFormat:@", %@", [[results objectAtIndex:0] name]];
			}
		}
	}
	if (f) {
		[f release];
	}
	
//	NSInteger num = [[summary componentsSeparatedByString:@","] count];
	if ([summary length] > 2) {
		summary = [summary substringFromIndex:2];
	}
	
	return summary;
}

-(void)updateTags {
	NSArray *updated_tags = [Tag findAllFor:self];
	[[[[UIApplication sharedApplication] delegate] managedObjectContext] refreshObject:self mergeChanges:YES];
	NSFetchRequest *f = nil;
	for (Tag *t in updated_tags) {
		if ([[t subjectType] isEqualToString:@"Concept"]) {
			if (f == nil) {
				f = [[NSFetchRequest alloc] init];
				NSEntityDescription *e = [NSEntityDescription entityForName:@"Concept" inManagedObjectContext:[[[UIApplication sharedApplication] delegate] managedObjectContext]];
				[f setEntity:e];				
			}
			[f setPredicate:[NSPredicate predicateWithFormat:[@"conceptId" stringByAppendingFormat:@" == %@", 
															  [NSNumber numberWithInt:[[t subjectId] integerValue]]]]];
			
			NSError *error = nil;
			NSArray *results = [[[[UIApplication sharedApplication] delegate] managedObjectContext] executeFetchRequest:f error:&error];
			
			if ([results count] == 0) {
				[[Concept findRemote:[t subjectId]] persistInMoc];
			}
		}
	}
	if (f) {
		[f release];
	}
	
	[[[[UIApplication sharedApplication] delegate] data_source] persistData:updated_tags ofType:@"tags"];
}

@end
