//
//  BSILibraryTableViewController.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSILibraryTableViewController.h"
#import "BSIBookViewController.h"
#import "BSILibrary.h"
#import "BSIBook.h"
#import "Settings.h"

@interface BSILibraryTableViewController ()

@end

@implementation BSILibraryTableViewController

#pragma mark - init
-(id) initWithModel: (BSILibrary *) aModel
              style: (UITableViewStyle *) aStyle{
    
    if (self = [super initWithStyle:aStyle]) {
        _model = aModel;
        self.title = @"Library";
    }
    
    return self;
    
}

#pragma mark - livecycle

-(void) viewWillAppear:(BOOL)animated{
    
    // Alta en notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION_NAME
             object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.model saveFavorites];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[self.model tags] objectAtIndex:section];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[self.model tags] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *tags = [self.model tags];
    return [self.model booksCountForTag:[tags objectAtIndex:section]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //averiguar de que modelo me esta hablando
    NSArray *tags = [self.model tags];
    
    BSIBook *aBook = [self.model bookForTag:[tags objectAtIndex:indexPath.section] atIndex:indexPath.row];
    
    //crear una celda
    static NSString *cellId = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:cellId];
    }
    
    //configurarla
    cell.imageView.image = [aBook frontPage];
    cell.textLabel.text = aBook.titleBook;
    cell.detailTextLabel.text = [aBook tagDescription];
    
    //devolverla
    return cell;

}

#pragma mark - delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BSIBook *aBook = [self.model bookForTag:[[self.model tags] objectAtIndex:indexPath.section]
                                    atIndex:indexPath.row];
    
    //aviso al delegate en caso de que lo entienda
    if ([self.delegate respondsToSelector:@selector(libraryTableViewController:didSelectedBook:) ]) {
        [self.delegate libraryTableViewController:self
                                  didSelectedBook:aBook];
    }
    NSNotificationCenter *nc =[NSNotificationCenter defaultCenter];
    NSDictionary *dict = @{BOOK_SELECTED_KEY : aBook};
    NSNotification *n = [NSNotification notificationWithName:BOOK_DID_SELECTED_NOTIFICATION_NAME
                                                      object:self
                                                    userInfo:dict];
    [nc postNotification:n];
    
    
}

-(void)libraryTableViewController:(BSILibraryTableViewController *)libVC didSelectedBook:(BSIBook *)aBook{
    
    BSIBookViewController *bookVC = [[BSIBookViewController alloc] initWithModel:aBook];
    [self.navigationController pushViewController:bookVC
                                         animated:YES];
    
    
}

#pragma mark - notifications
//BOOK_DID_CHANGE_NOTIFICATION_NAME
-(void)notifyThatBookDidChange:(NSNotification *)notification{
    
    BSIBook *bookNotified = [notification.userInfo objectForKey:BOOK_KEY];
    if (bookNotified.isFavorite) {
        [self.model addFavorite:bookNotified];
    }else{
        [self.model deleteFavorite:bookNotified];
    }
    [self.tableView reloadData];
}

@end
