//
//  BSILibraryTableViewController.h
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSILibrary;
@class BSILibraryTableViewController;
@class BSIBook;

@protocol BSILibraryTableViewControllerDelegate <NSObject>

@optional
-(void) libraryTableViewController:(BSILibraryTableViewController *) libVC
                   didSelectedBook:(BSIBook *) aBook;

@end

@interface BSILibraryTableViewController : UITableViewController<BSILibraryTableViewControllerDelegate>

@property (strong, nonatomic) BSILibrary *model;
@property (weak, nonatomic) id<BSILibraryTableViewControllerDelegate> delegate;

-(id) initWithModel: (BSILibrary *) aModel
              style: (UITableViewStyle *) aStyle;

@end
