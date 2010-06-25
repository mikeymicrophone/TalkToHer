//
//  InspirationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InspirationController : UITableViewController {
	NSArray *content_set;
}

@property (nonatomic, retain) NSArray *content_set;

-(void)load_content:(NSString *)model;

@end
