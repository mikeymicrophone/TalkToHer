//
//  InspirationCell.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/28/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InspirationCell : UITableViewCell {
	NSString *main_text;
	NSString *additional_text;
}

@property (assign) NSString *main_text;
@property (assign) NSString *additional_text;

+(CGFloat)cellHeightForMainText:(NSString *)main_text additional:(NSString *)additional width:(CGFloat)width;

@end
