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

+ (CGFloat)cellHeightForMainText:(NSString *)mtext additional:(NSString *)additional width:(CGFloat)width {
	UIFont *captionFont = [UIFont fontWithName:@"TrebuchetMS" size:18];
	UIFont *textFont = [UIFont fontWithName:@"TrebuchetMS" size:15];
	CGSize main_size = [mtext sizeWithFont:captionFont constrainedToSize:CGSizeMake(width-10.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	CGSize additional_size = [additional sizeWithFont:textFont constrainedToSize:CGSizeMake(width-10.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];

	return main_size.height + additional_size.height + 15.0;
}

-(id)initWithContent:(NSObject *)c {
	if (!(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@_%@",
					[c className], [c performSelector:NSSelectorFromString([c getRemoteClassIdName])]]]))
		return nil;
	
	self.main_text = [c main_text];
	self.additional_text = [c additional_text];
	
	return self;
}

- (void)drawRect:(CGRect)rect
{
	UIFont *captionFont = [UIFont fontWithName:@"TrebuchetMS" size:18];
	UIFont *textFont = [UIFont fontWithName:@"TrebuchetMS" size:15];

	CGRect f = [self bounds];
	CGSize cs = [main_text sizeWithFont:captionFont constrainedToSize:CGSizeMake(f.size.width-10.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	
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
