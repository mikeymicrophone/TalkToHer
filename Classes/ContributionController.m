//
//  ContributionController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/3/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ContributionController.h"
#import "TalkToHerAppDelegate.h"
#import "DataDelegate.h"
#import <dispatch/dispatch.h>

@implementation ContributionController

@synthesize contentType, content, writtenContent, heading;

-(id)initWithContentType:(NSString *)cType{
	if (![super initWithNibName:nil bundle:nil])
		return nil;
	
	[self setContentType:cType];
	[self prepare_content];
	
	self.heading = [[UILabel alloc] initWithFrame:CGRectMake(60,5,202,21)];
	heading.textAlignment = UITextAlignmentCenter;
	if ([cType isEqualToString:@"Exercise"]) {
		heading.text = @"Sharing: an Exercise";
		
		exercise_name = [[UITextField alloc] initWithFrame:CGRectMake(21, 150, 166, 31)];
		exercise_name.borderStyle = UITextBorderStyleRoundedRect;
		exercise_name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		exercise_name.font = [UIFont systemFontOfSize:11];
		exercise_name.placeholder = @"name of exercise";
	} else {
		heading.text = [NSString stringWithFormat:@"Sharing: a %@", cType];
	}
	return self;
}

-(void)prepare_content {
	NSManagedObjectContext *moc = [[[UIApplication sharedApplication] delegate] managedObjectContext];
	NSEntityDescription *entity = [NSEntityDescription entityForName:contentType inManagedObjectContext:moc];
	self.content = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:moc];
	[content setValue:[NSNumber numberWithInt:[[[[[UIApplication sharedApplication] delegate] data_source] userId] integerValue]] forKey:@"userId"];
}

-(IBAction)submit_content {
	[content setWrittenContent:writtenContent.text];
	if ([contentType isEqualToString:@"Exercise"]) {
		[content setMoniker:exercise_name.text];
	}
	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.talktoher.submission", NULL);
	dispatch_async(queue, ^{
		if ([[[[UIApplication sharedApplication] delegate] data_source] lotd_is_reachable]) {
			[content createRemote];
		} else {
			[content markForDelayedSubmission];
		}
		NSError *error = nil;
		if (![[[[UIApplication sharedApplication] delegate] managedObjectContext] save:&error]) { NSLog(@"Unresolved error %@, %@", error, [error userInfo]); }
		[[[[UIApplication sharedApplication] delegate] data_source] increment:contentType];
	});
	dispatch_release(queue);
	
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

-(IBAction)cancel {
	[[[[UIApplication sharedApplication] delegate] managedObjectContext] deleteObject:self.content];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

-(IBAction)clear {
	writtenContent.text = @"";
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewDidAppear:(BOOL)animated {
	[self.view addSubview:heading];
	[self.view addSubview:exercise_name];
	[[self writtenContent] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
