//
//  InspirationController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/25/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentDelegate;
@class LoaderCell;

@interface InspirationController : UITableViewController {
	ContentDelegate *content_source;
	LoaderCell *more_button;
	LoaderCell *write_button;
}

@property (nonatomic, retain) ContentDelegate *content_source;
@property (nonatomic, retain) LoaderCell *more_button;
@property (nonatomic, retain) LoaderCell *write_button;

-(id)initWithContentSource:(ContentDelegate *)source;
-(id)contentForIndexPath:(NSIndexPath *)indexPath;
-(void)moveButtonsForOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
