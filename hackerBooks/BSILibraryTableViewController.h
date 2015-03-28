//
//  BSILibraryTableViewController.h
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSILibrary;

@interface BSILibraryTableViewController : UITableViewController

@property (strong, nonatomic) BSILibrary *model;

-(id) initWithModel: (BSILibrary *) aModel
              style: (UITableViewStyle *) aStyle;

@end
