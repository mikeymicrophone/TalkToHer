//
//  LoaderCell.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoaderCell.h"

@implementation LoaderCell

@synthesize spinner, coloredLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
		return nil;
	
	[self addSpinner];
	[self addColoredLabel];
    return self;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	[coloredLabel removeFromSuperview];
	[spinner removeFromSuperview];
	[self addSubview:coloredLabel];
	spinner.center = CGPointMake(self.frame.size.width - 30, 23);
	[self addSubview:spinner];
}

-(void)addColoredLabel {
	self.coloredLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self reuseIdentifier]]];
	coloredLabel.center = self.center;
}

-(void)addSpinner {
	self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

-(void)stop_spinning {
	[self.spinner stopAnimating];
}

-(void)start_spinning {
	[self.spinner startAnimating];
}

- (void)dealloc {
    [super dealloc];
	self.spinner = nil;
	self.coloredLabel = nil;
}

@end
