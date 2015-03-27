//
//  BSIBook.h
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface BSIBook : NSObject

@property (strong, nonatomic) NSArray *author;
@property (strong, nonatomic) UIImage *frontPage;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSURL *pdfURL;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *titleBook;

//tendremos que quitarlo
-(id) initWithAuthor: (NSArray *) author
            imageURL: (NSURL *) anImageURL
              pdfURL: (NSURL *) aPdfURL
                tags: (NSArray *) tags
           titleBook: (NSString *) aTitleBook;

//el inicializador final
-(id) initWithDictionary: (NSDictionary *)aDic;

-(NSString *)tagDescription;
-(NSString *)authorDescription;

@end
