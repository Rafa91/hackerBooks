//
//  BSIBookViewController.h
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSIBook;

@interface BSIBookViewController : UIViewController

@property (strong, nonatomic) BSIBook *model;
@property (weak, nonatomic) IBOutlet UILabel *labelTags;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *frontPage;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;

-(id) initWithModel: (BSIBook *) model;


- (IBAction)readButton:(id)sender;


@end
