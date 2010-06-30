//
//  InspectionController.h
//  TalkToHer
//
//  Created by Michael Schwab on 6/30/10.
//  Copyright 2010 Exco Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InspectionController : UITableViewController {
	id content;
}

@property (nonatomic, retain) id content;

-(id)initWithContent:(id)contentObj;

@end
