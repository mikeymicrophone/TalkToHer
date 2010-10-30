//
//  TalkToHerAppDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Charismatic Comfort 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class DataDelegate;

@interface TalkToHerAppDelegate : NSObject <UIApplicationDelegate> {
	DataDelegate *data_source;
    UIWindow *window;
    UINavigationController *navigationController;
	
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) DataDelegate *data_source;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSString *)applicationDocumentsDirectory;
-(NSString *)userIsLoggedIn;
@end

