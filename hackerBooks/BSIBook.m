//
//  BSIBook.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSIBook.h"

@implementation BSIBook

-(id) initWithAuthor: (NSArray *) author
            imageURL: (NSURL *) anImageURL
              pdfURL: (NSURL *) aPdfURL
                tags: (NSArray *) tags
           titleBook: (NSString *) aTitleBook{
    
    if (self = [super init]) {
        _author = author;
        _imageURL = anImageURL;
        _pdfURL = aPdfURL;
        _tags = tags;
        _titleBook = aTitleBook;
    }
    
    return self;
    
}

#pragma mark - Utils
-(NSString *)tagDescription{
    
    NSString *aux=@"";
    if ([self.tags count]== 1) {
        return @"%@", [self.tags objectAtIndex:0];
    }else{
        for (NSString *obj in self.tags) {
            aux = [NSString stringWithFormat:@"%@,%@", obj, aux];
        }
        return aux;
    }
}


-(NSString *)authorDescription{
    
    NSString *aux=@"";
    if ([self.author count]== 1) {
        return @"%@", [self.author objectAtIndex:0];
    }else{
        for (NSString *obj in self.author) {
            aux = [NSString stringWithFormat:@"%@,%@", obj, aux];
        }
        return aux;
    }
    
}

@end
