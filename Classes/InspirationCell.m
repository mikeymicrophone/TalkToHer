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
	CGSize main_size = [mtext sizeWithFont:captionFont constrainedToSize:CGSizeMake(width-30.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	CGSize additional_size = [additional sizeWithFont:textFont constrainedToSize:CGSizeMake(width-30.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];

	return main_size.height + additional_size.height + 15.0;
}

-(id)initWithContent:(NSObject *)c {
	if (!(self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"%@_%@",
					[c className], [c performSelector:NSSelectorFromString([c getRemoteClassIdName])]]]))
		return nil;
	
	self.type = [c className];
	self.main_text = [c main_text];
	self.additional_text = [c additional_text];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];

	CGRect f = [self bounds];
	CGSize cs = [main_text sizeWithFont:[UIFont fontWithName:@"TrebuchetMS" size:18] constrainedToSize:CGSizeMake(f.size.width-30.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	
	UILabel *main = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, (NSInteger)f.size.width-30, (NSInteger)cs.height+5)];
	main.text = main_text;
	main.font = [UIFont fontWithName:@"TrebuchetMS" size:18];
	main.lineBreakMode = UILineBreakModeWordWrap;
	main.numberOfLines = 12;
	main.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	[self addSubview:main];
	
	UILabel *addl = [[UILabel alloc] initWithFrame:CGRectMake(15, (NSInteger)cs.height+10, (NSInteger)f.size.width-30, (NSInteger)f.size.height-cs.height-15)];
	addl.text = additional_text;
	addl.font = [UIFont fontWithName:@"TrebuchetMS" size:15];
	addl.lineBreakMode = UILineBreakModeWordWrap;
	addl.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	addl.numberOfLines = 12;
	[self addSubview:addl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if (selected) {
		if ([type isEqualToString:@"LineEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.983725490196078 green:0.964509803921569 blue:0.6980392156862745 alpha:1];
		} else if ([type isEqualToString:@"TipEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.985686274509804 green:0.786274509803922 blue:0.817647058823529 alpha:1];
		} else if ([type isEqualToString:@"ExerciseEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.747058823529412 green:0.998039215686274 blue:0.847058823529412 alpha:1];
		} else if ([type isEqualToString:@"GoalOwnershipEntity"]) {
			self.backgroundColor = [UIColor colorWithRed:0.811764705882353 green:0.905882352941176 blue:0.99156862745098 alpha:1];
		}
	} else {
		self.backgroundColor = [UIColor whiteColor];
	}
	[super setSelected:selected animated:animated];
}

- (void)dealloc {
    [super dealloc];
}

@end
