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

@property (nonatomic, retain) NSString *main_text;
@property (nonatomic, retain) NSString *additional_text;

-(id)initWithContent:(NSObject *)c;
+(CGFloat)cellHeightForMainText:(NSString *)mtext additional:(NSString *)additional width:(CGFloat)width;

@end
