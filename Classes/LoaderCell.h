//
//  LoaderCell.h
//  TalkToHer
//
//  Created by Raquel Hernandez on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoaderCell : UITableViewCell {
	UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

-(void)stop_spinning;
-(void)start_spinning;

@end