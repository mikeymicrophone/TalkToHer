//
//  GoalOwnershipEntity.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/26/10.
//  Copyright (c) 2010 Charismatic Comfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class GoalOwnership;

@interface GoalOwnershipEntity : NSManagedObject {

}

-(NSString *)main_text;
-(NSString *)additional_text;
-(GoalOwnership *)objectiveResource;
-(void)updateWith:(GoalOwnership *)g;

@end
