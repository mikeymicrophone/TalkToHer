//
//  LoaderCell.m
//  TalkToHer
//
//  Created by Raquel Hernandez on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoaderCell.h"


@implementation LoaderCell

@synthesize spinner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		CGPoint center;
		center.x = 290;
		center.y = 23;
		[self.spinner setCenter:center];
		[self addSubview:self.spinner];
		[[self textLabel] setText:reuseIdentifier];
    }
    return self;
}

-(void)stop_spinning {
	[self.spinner stopAnimating];
}

-(void)start_spinning {
	[self.spinner startAnimating];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end