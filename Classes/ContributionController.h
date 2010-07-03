//
//  ContributionController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/3/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContributionController : UIViewController {
	NSString *contentType;
	id content;
	IBOutlet UITextView *writtenContent;
}

@property (nonatomic, retain) NSString *contentType;
@property (nonatomic, retain) id content;
@property (nonatomic, retain) IBOutlet UITextView *writtenContent;

-(id)initWithContentType:(NSString *)cType;
-(void)prepare_content;
-(IBAction)submit_content;
@end
