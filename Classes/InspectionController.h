//
//  InspectionController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@class InspirationCell;

@interface InspectionController : UITableViewController <MFMailComposeViewControllerDelegate> {
	id content;
	InspirationCell *ratings_cell;
	InspirationCell *tags_cell;
	InspirationCell *comments_header_cell;
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
	NSNumber *previous_ratings;
	NSNumber *previous_comments;
	NSNumber *previous_tags;
	BOOL rating_is_fresh;
}

@property (nonatomic, retain) id content;
@property (nonatomic, retain) InspirationCell *ratings_cell;
@property (nonatomic, retain) InspirationCell *tags_cell;
@property (nonatomic, retain) InspirationCell *comments_header_cell;
@property (nonatomic, retain) UITextField *tag_field;
@property (nonatomic, retain) UITextField *comment_field;
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UILabel *rating;
@property (nonatomic, retain) UIButton *tag_button;
@property (nonatomic, retain) UIButton *comment_button;
@property (nonatomic, retain) InspirationCell *text_her;
@property (nonatomic, retain) InspirationCell *broadcast;
@property (nonatomic, retain) NSNumber *previous_ratings;
@property (nonatomic, retain) NSNumber *previous_comments;
@property (nonatomic, retain) NSNumber *previous_tags;

-(id)initWithContent:(id)contentObj;
-(id)inspect_content:(id)contentObj;

-(void)ratingReady:(id)sender;
-(void)ratingChanged:(id)sender;
-(void)log_in;
-(void)tagReady;
-(void)commentReady;
-(void)updateMetadataOfType:(NSString *)type;
-(void)reloadForLogin;
@end
