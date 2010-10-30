//
//  LoaderCell.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/12/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoaderCell : UITableViewCell {
	UIActivityIndicatorView *spinner;
	UIImageView *coloredLabel;
	UIButton *contentCount;
}

@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView *coloredLabel;
@property (nonatomic, retain) UIButton *contentCount;

-(void)stop_spinning;
-(void)start_spinning;
-(void)addColoredLabel;
-(void)addSpinner;
-(void)addContentCount;

@end
