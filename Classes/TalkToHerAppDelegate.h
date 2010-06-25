//
//  TalkToHerAppDelegate.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Exco Ventures 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkToHerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSArray *lines;
	NSArray *tips;
	NSArray *goals;
	NSArray *exercises;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSArray *lines;
@property (nonatomic, retain) NSArray *tips;
@property (nonatomic, retain) NSArray *goals;
@property (nonatomic, retain) NSArray *exercises;

-(void)load_content;

@end

