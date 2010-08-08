//
//  Comment.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/31/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Comment.h"
#import "CommentEntity.h"
#import "Response.h"
#import "ORConnection.h"
#import "Foundation/NSException.h"

@implementation Comment

@synthesize text, targetId, targetType, userId, commentId;
-(Comment *)initWithManagedObject:(CommentEntity *)ps {
	[self init];
    
    self.text = [ps text];
	self.targetId = [ps targetId];
	self.targetType = [ps targetType];
    self.userId = [ps userId];
	self.commentId = [ps commentId];
    
    return self;	
}

-(void)persistInMoc:(NSManagedObjectContext *)moc {
    CommentEntity *ps = [[CommentEntity alloc] initWithEntity:[NSEntityDescription entityForName:@"Comment" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
    [ps setValue:targetType	forKey:@"targetType"];
	[ps setValue:text forKey:@"text"];
	[ps setValue:[NSNumber numberWithInt:[targetId integerValue]] forKey:@"targetId"];
    [ps setValue:[NSNumber numberWithInt:[commentId integerValue]] forKey:@"commentId"];
    [ps setValue:[NSNumber numberWithInt:[userId integerValue]] forKey:@"userId"];
	if ([commentId integerValue] == 0) {
		[ps markForDelayedSubmission];
	}
	
	NSError *mocSaveError = nil;
    if (![moc save:&mocSaveError]) { NSLog(@"Unresolved error %@, %@", mocSaveError, [mocSaveError userInfo]); }
    [ps release];
}

+ (NSArray *)findAllFor:(NSObject *)commendable {
    NSString *commentsPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
						   [self getRemoteSite],
						   [commendable getRemoteCollectionName],
						   [commendable getRemoteId],
						   [self getRemoteCollectionName],
						   [self getRemoteProtocolExtension]];
	
    Response *res = [ORConnection get:commentsPath withUser:[[self class] getRemoteUser] 
						  andPassword:[[self class] getRemotePassword]];
	NSError **aError;
	if([res isError] && aError) {
		*aError = res.error;
		return nil;
	}
	else {
		return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
	}
}

@end
