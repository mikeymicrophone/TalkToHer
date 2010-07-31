//
//  InspectionController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface InspectionController : UITableViewController <MFMailComposeViewControllerDelegate> {
	id content;
	UILabel *rating;
}

@property (nonatomic, retain) id content;

-(id)initWithContent:(id)contentObj;
-(id)inspect_content:(id)contentObj;

-(void)ratingReady:(id)sender;
-(void)ratingChanged:(id)sender;

@end
