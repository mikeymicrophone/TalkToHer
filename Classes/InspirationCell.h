//
//  InspirationCell.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/28/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoaderCell.h"

@interface InspirationCell : LoaderCell {
	NSString *main_text;
	NSString *additional_text;
	NSString *type;
	UILabel *main;
	UILabel *addl;
}

@property (nonatomic, retain) NSString *main_text;
@property (nonatomic, retain) NSString *additional_text;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) UILabel *main;

-(id)initWithContent:(NSObject *)c;
-(void)addLabels;
+(CGFloat)cellHeightForMainText:(NSString *)mtext additional:(NSString *)additional width:(CGFloat)width;

@end
