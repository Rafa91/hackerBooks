//
//  BSILibrary.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSILibrary.h"
#import "BSIBook.h"

@interface BSILibrary ()

@property (strong,nonatomic) NSArray *books;

@end


@implementation BSILibrary

-(id) init{
    
    if (self = [super init]) {
        //generar los libros dummies
        BSIBook *book1 = [[BSIBook alloc]initWithAuthor:@[@"Author1"]
                                               imageURL:nil
                                                 pdfURL:nil
                                                   tags:@[@"tag1"]
                                              titleBook:@"title1"];
        BSIBook *book2 = [[BSIBook alloc]initWithAuthor:@[@"Author2"]
                                               imageURL:nil
                                                 pdfURL:nil
                                                   tags:@[@"tag2"]
                                              titleBook:@"title2"];
        BSIBook *book3 = [[BSIBook alloc]initWithAuthor:@[@"Author3"]
                                               imageURL:nil
                                                 pdfURL:nil
                                                   tags:@[@"tag3"]
                                              titleBook:@"title3"];
        BSIBook *book4 = [[BSIBook alloc]initWithAuthor:@[@"Author4"]
                                               imageURL:nil
                                                 pdfURL:nil
                                                   tags:@[@"tag4"]
                                              titleBook:@"title4"];
        self.books = @[book1, book2, book3, book4];
    }
    return self;
}


-(BSIBook *) bookAtIndex:(NSUInteger) index{
    
    return [self.books objectAtIndex:index];
    
}

@end
