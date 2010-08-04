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
	UITextField *tag_field;
	UITextField *comment_field;
	BOOL updated;
}

@property (nonatomic, retain) id content;
@property (nonatomic, retain) UITextField *tag_field;
@property (nonatomic, retain) UITextField *comment_field;

-(id)initWithContent:(id)contentObj;
-(id)inspect_content:(id)contentObj;

-(void)ratingReady:(id)sender;
-(void)ratingChanged:(id)sender;
-(void)log_in;
-(void)tagReady;
-(void)commentReady;
-(void)updateMetadata:(NSObject *)inspected_content;
@end
