//
//  InspectionController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@class InspirationCell;

@interface InspectionController : UITableViewController <MFMailComposeViewControllerDelegate> {
	id content;
	UILabel *rating;
	UITextField *tag_field;
	UITextField *comment_field;
	UISlider *slider;
	UIButton *tag_button;
	UIButton *comment_button;
	InspirationCell *text_her;
	InspirationCell *broadcast;
	BOOL comments_updated;
	UIActivityIndicatorView *comment_spinner;
	BOOL ratings_updated;
	UIActivityIndicatorView *rating_spinner;
	BOOL tags_updated;
	UIActivityIndicatorView *tag_spinner;
	NSInteger previous_ratings;
	NSInteger previous_comments;
	NSInteger previous_tags;
	UILabel *comment_count;
}

@property (nonatomic, retain) id content;
@property (nonatomic, retain) UITextField *tag_field;
@property (nonatomic, retain) UITextField *comment_field;
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UILabel *rating;
@property (nonatomic, retain) UIButton *tag_button;
@property (nonatomic, retain) UIButton *comment_button;
@property (nonatomic, retain) InspirationCell *text_her;
@property (nonatomic, retain) InspirationCell *broadcast;
@property (nonatomic, retain) UILabel *comment_count;

-(id)initWithContent:(id)contentObj;
-(id)inspect_content:(id)contentObj;

-(void)ratingReady:(id)sender;
-(void)ratingChanged:(id)sender;
-(void)log_in;
-(void)tagReady;
-(void)commentReady;
-(void)updateMetadataOfType:(NSString *)type;
@end
