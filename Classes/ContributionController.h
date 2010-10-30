//
//  ContributionController.h
//  TalkToHer
//
//  Created by Michael Schwab on 7/3/10.
//  Copyright 2010 Charismatic Comfort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ContributionController : UIViewController {
	NSString *contentType;
	id content;
	IBOutlet UITextView *writtenContent;
	UILabel *heading;
	UITextField *exercise_name;
}

@property (nonatomic, retain) NSString *contentType;
@property (nonatomic, retain) id content;
@property (nonatomic, retain) IBOutlet UITextView *writtenContent;
@property (nonatomic, retain) UILabel *heading;

-(id)initWithContentType:(NSString *)cType;
-(void)prepare_content;
-(IBAction)submit_content;
-(IBAction)cancel;
-(IBAction)clear;
@end
