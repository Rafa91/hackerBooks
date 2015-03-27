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

-(id) initWithDictionary: (NSDictionary *)aDic{
    
    return [self initWithAuthor:[self extractAuthorFromJSONArray:[aDic objectForKey:@"authors"]]
                       imageURL:[NSURL URLWithString:[aDic objectForKey:@"image_url"]]
                         pdfURL:[NSURL URLWithString:[aDic objectForKey:@"pdf_url"]]
                           tags:[self extractTagFromJSONArray:[aDic objectForKey:@"tags"]]
                      titleBook:[aDic objectForKey:@"title"]];
    
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

-(NSArray *)extractAuthorFromJSONArray: (NSArray *)JSONArray{
    NSMutableArray *author = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    for (NSDictionary *dic in JSONArray) {
        [author addObject:[dic objectForKey:@"author"]];
    }
    return author;
}

-(NSArray *)extractTagFromJSONArray: (NSArray *)JSONArray{
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    for (NSDictionary *dic in JSONArray) {
        [tags addObject:[dic objectForKey:@"tags"]];
    }
    return tags;
}

@end
