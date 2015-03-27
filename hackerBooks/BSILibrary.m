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

        //intento de descarga del JSON
        //Creo la request
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"]];
        //Creo la response y el error para la conexión
        NSURLResponse *response= [[NSURLResponse alloc]init];
        NSError *error;
        //Procedo a realizar la conexión
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        
        //compruebo si data es nil para ver si hay error
        if (data != nil) {
            
            //Creo un array con los objetos JSON
            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:&error];
            
            //vuelvo a comporbar el vajor de JSONObjects para ver si hay error
            if (JSONObjects != nil) {
                for (NSDictionary *dic in JSONObjects) {
                    BSIBook *aBook = [[BSIBook alloc]initWithDictionary:dic];
                    NSLog(@"el libro es: %@", aBook);
//                    if (!self.books) {
//                        self.books = @[aBook];
//                    }else{
//                        self.books=@[self.books, aBook];
//                    }
                }
            }else{
                NSLog(@"error al pasear JSON: %@", error.localizedDescription);
            }
            
        }else{
            
            NSLog(@"error al descargar los datos del servidor: %@", error.localizedDescription);
            
        }
        
//        Libros dummies!!!!!
//        //generar los libros dummies
//        BSIBook *book1 = [[BSIBook alloc]initWithAuthor:@[@"Author1"]
//                                               imageURL:nil
//                                                 pdfURL:nil
//                                                   tags:@[@"tag1"]
//                                              titleBook:@"title1"];
//        BSIBook *book2 = [[BSIBook alloc]initWithAuthor:@[@"Author2"]
//                                               imageURL:nil
//                                                 pdfURL:nil
//                                                   tags:@[@"tag2"]
//                                              titleBook:@"title2"];
//        BSIBook *book3 = [[BSIBook alloc]initWithAuthor:@[@"Author3"]
//                                               imageURL:nil
//                                                 pdfURL:nil
//                                                   tags:@[@"tag3"]
//                                              titleBook:@"title3"];
//        BSIBook *book4 = [[BSIBook alloc]initWithAuthor:@[@"Author4"]
//                                               imageURL:nil
//                                                 pdfURL:nil
//                                                   tags:@[@"tag4"]
//                                              titleBook:@"title4"];
//        self.books = @[book1, book2, book3, book4];
        
        
    }
    return self;
}


-(BSIBook *) bookAtIndex:(NSUInteger) index{
    
    return [self.books objectAtIndex:index];
    
}

@end
