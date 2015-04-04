//
//  BSISimplePDFViewController.m
//  hackerBooks
//
//  Created by Rafael Navarro on 3/4/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSISimplePDFViewController.h"
#import "BSIBook.h"
#import "Settings.h"

@interface BSISimplePDFViewController ()

@property (nonatomic) BOOL canLoad;

@end

@implementation BSISimplePDFViewController

-(id) initWithModel: (BSIBook *) model{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
        self.title = self.model.titleBook;
        _canLoad = YES;
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // Asegurarse de que no se ocupa toda la pantalla
    // cuando estás en un combinador
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookSelectedDidChange:)
               name:BOOK_DID_SELECTED_NOTIFICATION_NAME
             object:nil];
    
    // sincronizar modelo -> vista
    [self syncWithModel];
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // Asignar delegados
    self.webPDF.delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    

    
    self.canLoad = NO;
    
}

-(BOOL) webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType{
    
    return self.canLoad;
    
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    // ocultar activityView
    // hacer un NSLog
    
}

#pragma mark - Notifications
//BOOK_DID_SELECTED_NOTIFICATION_NAME
-(void)notifyThatBookSelectedDidChange:(NSNotification *)notification{
    
    BSIBook *aBook  = [notification.userInfo objectForKey:BOOK_SELECTED_KEY];
    self.model = aBook;
    [self syncWithModel];
    
}

#pragma mark - utils

-(void) syncWithModel{
    
    self.canLoad = YES;
    NSError *error;
    
    [self.webPDF loadData:[NSData dataWithContentsOfURL:self.model.pdfURL
                                                options:NSDataReadingMappedIfSafe
                                                  error:&error]
                 MIMEType:@"application/pdf"
         textEncodingName:@"UTF-8"
                  baseURL:[NSURL URLWithString:@"https://"]];
    
}

@end
