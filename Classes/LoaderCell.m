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

-(void)addColoredLabel {
	self.coloredLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self reuseIdentifier]]];
	coloredLabel.center = self.center;
	[self addSubview:coloredLabel];
}

-(void)addSpinner {
	self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	spinner.center = CGPointMake(290, 23);
	[self addSubview:spinner];	
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
