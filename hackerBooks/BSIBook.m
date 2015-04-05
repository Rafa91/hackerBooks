//
//  BSIBook.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "BSIBook.h"
#import "Settings.h"


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
        _titleBook = aTitleBook;
        _author = author;
        _imageURL = anImageURL;
        _pdfURL = aPdfURL;
        _tags = tags;
        _frontPage = frontPage;
        _isFavorite = isFavorite;
    }
    
    return self;
    
}

-(id) initWithDictionary: (NSDictionary *)aDic{
    
    //objetos para pasarle al init
    UIImage *aImage;
    NSURL *imageURL=[NSURL URLWithString:[aDic objectForKey:@"image_url"]];
    
    //Compruebo si hay algún fichero con ese nombre para la imagen
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *urls = [manager URLsForDirectory:NSDocumentDirectory
                                    inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    url = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",[aDic objectForKey:@"title"]]];
    NSData *someData = [NSData dataWithContentsOfURL:url];
    
    //si lo hay la paso a imagen
    if (someData) {
        aImage = [UIImage imageWithData:someData];
    }else{
        //si no la hay me la descargo
        NSError *error;
        someData =[NSData dataWithContentsOfURL:imageURL
                                        options:NSDataReadingMappedIfSafe
                                          error:&error];
        //la guardo en disco para evitar volverla a descargar
        if (someData) {
            [someData writeToURL:url
                      atomically:YES];
            aImage = [UIImage imageWithData:someData];
        }else{
            NSLog(@"error en la descarga de imagen: %@", error.localizedDescription);
        }
        
    }
    
    return [self initWithAuthor: [self extractAuthorFromJSONArray:[aDic objectForKey:@"authors"]]
                      frontPage: aImage
                       imageURL: imageURL
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

-(void) setIsFavorite:(BOOL) estado{
    
    _isFavorite=estado;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = @{BOOK_KEY : self};
    NSNotification *n = [NSNotification notificationWithName:BOOK_DID_CHANGE_NOTIFICATION_NAME
                                                      object:self
                                                    userInfo:dic];
    [nc postNotification:n];
    
}

@end
