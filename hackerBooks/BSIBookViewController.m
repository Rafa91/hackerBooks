//
//  BSIBookViewController.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSIBookViewController.h"
#import "BSIBook.h"

@interface BSIBookViewController ()

@end

@implementation BSIBookViewController

#pragma mark - inits
-(id) initWithModel: (BSIBook *) model{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
        self.title = [model titleBook];
    }
    return self;
    
}


#pragma mark - view Lifecycle
-(void) viewWillAppear:(BOOL)animated{
    
    [self updateView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
#warning descargar la imagen del url y meterla en la propiedad
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)readButton:(id)sender {
    
    NSLog(@"cargamos la vista del pdf");
    
}

#pragma mark - Utils

-(void) updateView{
    
    self.title = [self.model titleBook];
    self.labelTags.text = [self.model tagDescription];
    self.labelAuthor.text = [self.model authorDescription];
    
}

@end
