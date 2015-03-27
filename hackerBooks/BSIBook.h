//
//  BSIBook.h
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSIBook : NSObject

@property (strong, nonatomic) NSArray *author;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSURL *pdfURL;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *titleBook;

-(id) initWithAuthor: (NSArray *) author
            imageURL: (NSURL *) anImageURL
              pdfURL: (NSURL *) aPdfURL
                tags: (NSArray *) tags
           titleBook: (NSString *) aTitleBook;

-(NSString *)tagDescription;
-(NSString *)authorDescription;

@end
