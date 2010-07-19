//
//  ContributionController.m
//  TalkToHer
//
//  Created by Michael Schwab on 7/3/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import "ContributionController.h"
#import <dispatch/dispatch.h>

@implementation ContributionController

@synthesize contentType, content, writtenContent, heading, moc;

-(id)initWithContentType:(NSString *)cType andManagedObjectContext:(NSManagedObjectContext *)m {
	if (![super initWithNibName:nil bundle:nil])
		return nil;
	
	[self setContentType:cType];
	self.heading = [[UILabel alloc] initWithFrame:CGRectMake(60,5,202,21)];
	self.heading.textAlignment = UITextAlignmentCenter;
	if ([cType isEqualToString:@"Exercise"]) {
		self.heading.text = @"Sharing an Exercise";
	} else {
		self.heading.text = [NSString stringWithFormat:@"Sharing a %@", cType];
	}
	[self setMoc:m];
	[self prepare_content];
	return self;
}

-(void)prepare_content {
	NSEntityDescription *entity = [NSEntityDescription entityForName:contentType inManagedObjectContext:moc];
	self.content = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:moc];
}

-(IBAction)submit_content {
	[self.content setWrittenContent:writtenContent.text];
	NSLog(@"content about to be saved: %@", self.content);
	[self.content retain];
	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.talktoher.submission", NULL);
	dispatch_async(queue, ^{
		[self.content createRemote];
		NSError *error = nil;
		if (![moc save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		}		
	});
	[self.content release];
	dispatch_release(queue);
	
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

-(IBAction)cancel {
	[moc deleteObject:self.content];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

-(IBAction)clear {
	writtenContent.text = @"";
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewDidAppear:(BOOL)animated {
	[self.view addSubview:self.heading];
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
