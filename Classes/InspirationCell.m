//
//  InspirationCell.m
//  TalkToHer
//
//  Created by Michael Schwab on 6/28/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "InspirationCell.h"

@implementation InspirationCell

@synthesize main_text, additional_text, type;

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
	
	self.type = [c className];
	self.main_text = [c main_text];
	self.additional_text = [c additional_text];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
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

//- (id)initWithFrame:(CGRect)frame {
//	if (self = [super initWithFrame:frame])
//	{
//		self.opaque = YES;
//		self.backgroundColor = [UIColor whiteColor];
//	}
//	return self;
//}
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
//        // Initialization code
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if (selected) {
		if ([type isEqualToString:@"LineEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.815686274509804 green:0.705882352941177 blue:0.223529411764706 alpha:0.4];
		} else if ([type isEqualToString:@"TipEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.666666666666667 green:0.0352941176470588 blue:0.0862745098039216 alpha:0.4];
		} else if ([type isEqualToString:@"ExerciseEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.105882352941176 green:0.384313725490196 blue:0.196078431372549 alpha:0.4];
		} else if ([type isEqualToString:@"GoalOwnershipEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.164705882352941 green:0.392156862745098 blue:0.556862745098039 alpha:0.4];
		}
	} else {
		self.backgroundColor = [UIColor whiteColor];
	}

	
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}

@end
