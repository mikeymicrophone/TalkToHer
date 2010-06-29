//
//  InspirationCell.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/28/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InspirationCell.h"


@implementation InspirationCell

@synthesize main_text, additional_text;

+ (CGFloat)cellHeightForMainText:(NSString *)main_text additional:(NSString *)additional width:(CGFloat)width {
	UIFont *captionFont = [UIFont boldSystemFontOfSize:13];
	UIFont *textFont = [UIFont systemFontOfSize:13];
	CGSize main_size = [main_text sizeWithFont:captionFont constrainedToSize:CGSizeMake(width-20.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	CGSize additional_size = [additional sizeWithFont:textFont constrainedToSize:CGSizeMake(width-20.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];

	return main_size.height + additional_size.height + 15.0;
}

- (void)drawRect:(CGRect)rect
{
	UIColor *captionColor = [UIColor blackColor];
	UIColor *textColor = [UIColor darkGrayColor];
	UIFont *captionFont = [UIFont boldSystemFontOfSize:13];
	UIFont *textFont = [UIFont systemFontOfSize:13];
	CGRect f = [self bounds];
	CGSize cs = [main_text sizeWithFont:captionFont constrainedToSize:CGSizeMake(f.size.width-10, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];

	CGRect c = CGRectMake(5.0, 5.0, f.size.width-10.0, cs.height+5.0);
	[main_text drawInRect:c withFont:captionFont lineBreakMode:UILineBreakModeWordWrap];

	CGRect r = CGRectMake(5.0, cs.height+10.0, f.size.width-10.0, f.size.height-cs.height-15.0);
	[additional_text drawInRect:r withFont:textFont lineBreakMode:UILineBreakModeWordWrap];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame])
	{
		self.opaque = YES;
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
