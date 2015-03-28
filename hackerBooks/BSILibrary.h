//
//  BSILibrary.h
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSIBook;


@interface BSILibrary : NSObject

@property (readonly, nonatomic) NSUInteger bookCount;

@property (strong,nonatomic) NSArray *books;

-(BSIBook *) bookAtIndex:(NSUInteger) index;

@end
