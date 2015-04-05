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

@property (strong, nonatomic) NSMutableDictionary *tagDictionary;

@end


@implementation BSILibrary

#pragma mark - Init
-(id) initWithData:(NSData *)data{
    
    if (self = [super init]) {
        
        //inicializo tagDictionary
        _tagDictionary = [[NSMutableDictionary alloc]init];


        NSError *error;
        
        //Creo un array con los objetos JSON
        NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
        
        //vuelvo a comporbar el vajor de JSONObjects para ver si hay error
        if (JSONObjects != nil) {
            for (NSDictionary *dic in JSONObjects) {
                BSIBook *aBook = [[BSIBook alloc]initWithDictionary:dic];
                if (!self.books) {
                    self.books = [NSArray arrayWithObject:aBook];
                }else{
                    NSMutableArray *aux = [self.books mutableCopy];
                    [aux addObject:aBook];
                    self.books = [NSArray arrayWithArray:aux];
                }
                [self updateTagsWithBook:aBook];
            }
        }else{
            NSLog(@"error al pasear JSON: %@", error.localizedDescription);
        }
        
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@", [ud objectForKey:@"Favorite"]);
        if ([ud objectForKey:@"Favorite"]!=nil) {
            [self addFavorites:[ud objectForKey:@"Favorite"]];
        }
        
    }
    return self;
}

#pragma mark - Requirements
-(NSUInteger) booksCount{
    
    return [self.books count];
    
}

-(NSArray *) tags{
    NSArray *tags = [[self.tagDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    if ([tags containsObject:@"Favorite"]) {
        NSMutableArray *tagAux = [tags mutableCopy];
        [tagAux removeObjectIdenticalTo:@"Favorite"];
        tags = [NSArray arrayWithArray:tagAux];
        tagAux = [NSMutableArray arrayWithObject:@"Favorite"];
        [tagAux addObjectsFromArray:tags];
        tags = [NSArray arrayWithArray:tagAux];
    }
    
    //existen más formas de ordenar alfabeticamente
    //Descriptors
    //Blocks
    //Selectors
    //Enlace de la documentación: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Collections/Articles/Arrays.html#//apple_ref/doc/uid/20000132-SW5
    return tags;
    
}

-(NSUInteger) booksCountForTag:(NSString *) tag{
    
    return [[self booksForTag:tag] count];
    
}

-(NSArray *) booksForTag:(NSString *) tag{
    
    return [self.tagDictionary objectForKey:tag];
    
}

-(BSIBook *) bookForTag: (NSString *) tag atIndex:(NSUInteger) index{
    
    BSIBook *aBook;
    if ([self booksCountForTag:tag]>index) {
        aBook = [[self booksForTag:tag] objectAtIndex:index];
    }else{
        NSLog(@"error al introducir el puntero");
    }
    return aBook;
    
}


#pragma mark - Utils
-(void) updateTagsWithBook: (BSIBook *)aBook{
    
    for (NSString *tag in aBook.tags) {
        NSArray *booksForTag = [self.tagDictionary objectForKey:tag];
        if (!booksForTag) {
            booksForTag = @[aBook];

        }else{
            NSMutableArray *aux=[booksForTag mutableCopy];
            [aux addObject:aBook];
            booksForTag=[NSArray arrayWithArray:aux];
        }
        [self.tagDictionary setObject:booksForTag
                               forKey:tag];
    }
    
}

-(BSIBook *) bookAtIndex:(NSUInteger) index{
    
    return [self.books objectAtIndex:index];
    
}

//añade un nuevo libro al tag Favoritos
-(void)addFavorite:(BSIBook *)aBook{
    
    NSArray *booksForTag = [self.tagDictionary objectForKey:@"Favorite"];
    if (!booksForTag) {
        booksForTag = @[aBook];
        
    }else{
        NSMutableArray *aux=[booksForTag mutableCopy];
        [aux addObject:aBook];
        booksForTag=[NSArray arrayWithArray:aux];
    }
    [self.tagDictionary setObject:booksForTag
                           forKey:@"Favorite"];
    [self saveFavorites];

    
}

//elimina un libro del tag Favoritos
-(void)deleteFavorite:(BSIBook *)aBook{
    
    NSArray *booksForTag = [self.tagDictionary objectForKey:@"Favorite"];
    if (booksForTag) {
        NSMutableArray *bookListAux=[booksForTag mutableCopy];
        [bookListAux removeObjectIdenticalTo:aBook];
        booksForTag = [NSArray arrayWithArray:bookListAux];
    }else{
        booksForTag=@[];
    }
    [self.tagDictionary setValue:booksForTag forKey:@"Favorite"];
    [self saveFavorites];
    
}

-(void) addFavorites:(NSArray *)someTitles{
    
    for (BSIBook *aBook in self.books) {
        for (NSString *title in someTitles) {
            if ([aBook.titleBook isEqualToString:title]) {
                [self addFavorite:aBook];
            }
        }
    }
    
}

//guarda los favoritos en disco
-(void) saveFavorites{
    
    NSMutableArray *favoritesMutable= [NSMutableArray arrayWithObject:@""];
    for (BSIBook *aBook in [self.tagDictionary objectForKey:@"Favorite"]) {
        [favoritesMutable addObject:aBook.titleBook];
    }
    [favoritesMutable removeObjectIdenticalTo:@""];
    NSArray *favorites = [NSArray arrayWithArray:favoritesMutable];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:favorites
           forKey:@"Favorite"];
    NSLog(@"%@",[ud objectForKey:@"Favorite"]);
    
    
}


@end
