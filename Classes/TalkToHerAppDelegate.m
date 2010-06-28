//
//  TalkToHerAppDelegate.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/24/10.
//  Copyright Exco Ventures 2010. All rights reserved.
//

#import "TalkToHerAppDelegate.h"
#import "RootViewController.h"
#import "ObjectiveResourceConfig.h"
#import "Line.h"

@implementation TalkToHerAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize lines, tips, exercises, goals;

-(void)load_content {
	[ObjectiveResourceConfig setSite:@"http://lineoftheday.com"];
	self.lines = [Line findAllRemote];
	
//	NSString *path = @"http://lineoftheday.com/iphone";
//	NSURL *url = [[NSURL alloc] initWithString:path];
//	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//	[url release];
//	[request startSynchronous];
//	NSError *error = [request error];
//	if (!error) {
//		NSString *response = [request responseString];
//		NSLog(@"response: %@", response);
//	}
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
	
	[self load_content];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

