//
//  InspirationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InspirationController : UITableViewController {
	NSString *content_type;
	NSArray *content_set;
	NSNumber *content_amount;
}

@property (nonatomic, retain) NSString *content_type;
@property (nonatomic, retain) NSArray *content_set;
@property (nonatomic, retain) NSNumber *content_amount;

-(void)load_content;

@end
