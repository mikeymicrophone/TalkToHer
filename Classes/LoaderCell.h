//
//  LoaderCell.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoaderCell : UITableViewCell {
	UIActivityIndicatorView *spinner;
	UIImageView *coloredLabel;
}

@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView *coloredLabel;

-(void)stop_spinning;
-(void)start_spinning;
-(void)addColoredLabel;
-(void)addSpinner;

@end
