//
//  BSIBookViewController.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSIBookViewController.h"
#import "BSIBook.h"
#import "BSISimplePDFViewController.h"
#import "Settings.h"

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
    [super viewWillAppear:animated];
    [self updateView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)readButton:(id)sender {
    
    [self.navigationController pushViewController:[[BSISimplePDFViewController alloc] initWithModel:self.model] animated:YES];
    
}

- (IBAction)isFavorite:(id)sender {
    NSLog(@"cambiamos el estado de favorito");
    if (self.model.isFavorite) {
        self.model.isFavorite = NO;
    }else{
        self.model.isFavorite = YES;
    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = @{BOOK_KEY : self.model};
    NSNotification *n = [NSNotification notificationWithName:BOOK_DID_CHANGE_NOTIFICATION_NAME
                                                      object:self
                                                    userInfo:dic];
    [nc postNotification:n];
}

#pragma mark - Utils

-(void) updateView{
    
    self.title = [self.model titleBook];
    self.labelTitle.text = [self.model titleBook];
    self.labelTags.text = [self.model tagDescription];
    self.labelAuthor.text = [self.model authorDescription];
    self.frontPage.image = [self.model frontPage];
    
}

#pragma mark - UISplitViewControllerDelegate
-(void) splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    // Averiguar si la tabla se ve o no
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        
        // La tabla está oculta y cuelga del botón
        // Ponemos ese botón en mi barra de navegación
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }else{
        // Se muestra la tabla: oculto el botón de la
        // barra de navegación
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    
}

#pragma mark - BSILibraryTableViewControllerDelegate
-(void) libraryTableViewController:(BSILibraryTableViewController *)libVC didSelectedBook:(BSIBook *)aBook{
    
    self.model=aBook;
    [self updateView];
    
}

@end
