//
//  BSILibraryTableViewController.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSILibraryTableViewController.h"
#import "BSILibrary.h"
#import "BSIBook.h"

@interface BSILibraryTableViewController ()

@end

@implementation BSILibraryTableViewController

#pragma mark - init
-(id) initWithModel: (BSILibrary *) aModel
              style: (UITableViewStyle *) aStyle{
    
    if (self = [super initWithStyle:aStyle]) {
        _model = aModel;
    }
    
    return self;
    
}

#pragma mark - livecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.model.books count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //averiguar de que modelo me esta hablando
    BSIBook *aBook = [self.model.books objectAtIndex:indexPath.row];
    
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



@end
