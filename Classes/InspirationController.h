//
//  InspirationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataDelegate;


@interface InspirationController : UITableViewController {
	NSString *content_type;
	NSArray *content_set;
	NSNumber *displayed_content_amount;
	NSNumber *available_content_amount;
	DataDelegate *data_source;
}

@property (nonatomic, retain) NSString *content_type;
@property (nonatomic, retain) NSArray *content_set;
@property (nonatomic, retain) NSNumber *displayed_content_amount;
@property (nonatomic, retain) NSNumber *available_content_amount;
@property (nonatomic, retain) DataDelegate *data_source;

-(void)load_content;
-(id)contentForIndexPath:(NSIndexPath *)indexPath;

@end
