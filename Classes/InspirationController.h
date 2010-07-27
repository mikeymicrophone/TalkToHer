//
//  InspirationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentDelegate;


@interface InspirationController : UITableViewController {
	ContentDelegate *content_source;
}

@property (nonatomic, retain) ContentDelegate *content_source;

-(id)initWithContentSource:(ContentDelegate *)source;
-(id)contentForIndexPath:(NSIndexPath *)indexPath;

@end
