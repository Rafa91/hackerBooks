//
//  BSIBook.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSIBook.h"


@implementation BSIBook

#pragma mark - Propiedades
@synthesize frontPage = _frontPage;
-(UIImage *)frontPage{
    
    if (_frontPage==nil) {
        _frontPage = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    }
    return _frontPage;
}


-(id) initWithAuthor: (NSArray *) author
           frontPage: (UIImage *) frontPage
            imageURL: (NSURL *) anImageURL
              pdfURL: (NSURL *) aPdfURL
                tags: (NSArray *) tags
           titleBook: (NSString *) aTitleBook
          isFavorite: (BOOL)isFavorite{
    
    if (self = [super init]) {
        _author = author;
        _imageURL = anImageURL;
        _pdfURL = aPdfURL;
        _tags = tags;
        _titleBook = aTitleBook;
        _frontPage = frontPage;
        _isFavorite = isFavorite;
    }
    
    return self;
    
}

-(id) initWithDictionary: (NSDictionary *)aDic{
    
    return [self initWithAuthor: [self extractAuthorFromJSONArray:[aDic objectForKey:@"authors"]]
                      frontPage: [self imageOfURL:[NSURL URLWithString:[aDic objectForKey:@"image_url"]]]
                       imageURL: [NSURL URLWithString:[aDic objectForKey:@"image_url"]]
                         pdfURL: [NSURL URLWithString:[aDic objectForKey:@"pdf_url"]]
                           tags: [self extractTagFromJSONArray:[aDic objectForKey:@"tags"]]
                      titleBook: [aDic objectForKey:@"title"]
                     isFavorite: NO];

    
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

-(NSArray *)extractAuthorFromJSONArray: (NSString *)JSONString{
    NSArray *author = [JSONString componentsSeparatedByString:@", "];
    return author;
}

-(NSArray *)extractTagFromJSONArray: (NSString *)JSONString{
    NSArray *tags = [JSONString componentsSeparatedByString:@", "];
    return tags;
}

-(UIImage *) imageOfURL:(NSURL *) aURL{
    
    NSError *error;
    UIImage *aImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:aURL
                                                                   options:NSDataReadingMappedIfSafe
                                                                     error:&error]];
    if (aImage) {
        return aImage;
    }else{
        NSLog(@"error en la descarga de imagen: %@", error.localizedDescription);
        return nil;
    }
    
}

@end
