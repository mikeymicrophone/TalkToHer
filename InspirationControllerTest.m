//
//  InspirationControllerTest.m
//  TalkToHer
//
//  Created by Michael Schwab on 10/16/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InspirationControllerTest.h"


@implementation InspirationControllerTest

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {
    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
    
}


#endif


@end
