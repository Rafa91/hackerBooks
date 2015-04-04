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

@property (strong,nonatomic) NSArray *books;

-(BSIBook *) bookAtIndex:(NSUInteger) index;

//Número total de libros
-(NSUInteger) booksCount;

//Array inmutable (NSArray) con todas las distintas temáticas (tags)
//en orden alfabético. No puede bajo ningún concepto haber ninguna repetida.
-(NSArray *) tags;

//Cantidad de libros que hay en una temática. Si el tag no existe, debe devolver cero.
-(NSUInteger) booksCountForTag:(NSString *) tag;

//Array inmutable (NSArray) de los libros (instancias de BSIBook) que hay en
//una temática. Un libro puede estar en una o más temáticas. Si no hay libros para una
//temática, ha de devolver un nil.
-(NSArray *) booksForTag:(NSString *) tag;

//Un BSIBook para el libro que está en la posición "index" de quellos bajo un cierto
//tag, usando el método anterior. Si el índice no existe o el tag no existe, ha de devolver nil.
-(BSIBook *) bookForTag: (NSString *) tag atIndex:(NSUInteger) index;

-(void)addFavorite:(BSIBook *)aBook;
-(void)deleteFavorite:(BSIBook *)aBook;

@end
