//
//  LoaderCell.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/12/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import "LoaderCell.h"

@implementation LoaderCell

@synthesize spinner, coloredLabel, contentCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
		return nil;
	
	[self addSpinner];
	[self addColoredLabel];
	
	if ([reuseIdentifier isEqualToString:@"lines"] || [reuseIdentifier isEqualToString:@"tips"] || [reuseIdentifier isEqualToString:@"exercises"] || [reuseIdentifier isEqualToString:@"goals"]) {
		[self addContentCount];
	}
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

-(void)addContentCount {
	self.contentCount = [UIButton buttonWithType:UIButtonTypeCustom];
	contentCount.frame = CGRectMake(self.frame.size.width - 60, 0, 60, 44);
	contentCount.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:16];
	[contentCount setTitle:[NSString stringWithFormat:@"%@", [[[[[UIApplication sharedApplication] delegate] data_source] performSelector:NSSelectorFromString([self reuseIdentifier])] loaded_amount]] forState:nil];
	[contentCount setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:nil];
	[self addSubview:contentCount];
}

- (void)dealloc {
    [super dealloc];
	self.spinner = nil;
	self.coloredLabel = nil;
//	self.contentCount = nil;
}

@end
