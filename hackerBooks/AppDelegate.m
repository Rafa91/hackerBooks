//
//  AppDelegate.m
//  hackerBooks
//
//  Created by Rafael Navarro on 27/3/15.
//  Copyright (c) 2015 Beside. All rights reserved.
//

#import "AppDelegate.h"
#import "BSIBook.h"
#import "BSIBookViewController.h"
#import "BSILibrary.h"
#import "BSILibraryTableViewController.h"
#import "Settings.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Generamos el modelo
    BSILibrary *model = [self configureFirstAppear];

    // Detectamos el tipo de pantalla
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // Tipo tableta
        [self configureForPadWithModel:model];
    }else{
        // Tipo teléfono
        [self configureForPhoneWithModel:model];
        
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - utils
-(void)configureForPadWithModel:(BSILibrary *)aModel{
    
    BSILibraryTableViewController *lVC = [[BSILibraryTableViewController alloc] initWithModel:aModel
                                                                                        style:UITableViewStylePlain];
    BSIBookViewController *bVC = [[BSIBookViewController alloc]initWithModel:[aModel.books objectAtIndex:0]];
    UINavigationController *navlVC = [[UINavigationController alloc]initWithRootViewController:lVC];
    UINavigationController *navbVC = [[UINavigationController alloc] initWithRootViewController:bVC];
    UISplitViewController *split = [[UISplitViewController alloc] init];
    split.viewControllers = @[navlVC, navbVC];
    split.delegate = bVC;
    lVC.delegate = bVC;
    self.window.rootViewController =split;
    
}

-(void)configureForPhoneWithModel:(BSILibrary *)aModel{
    
    BSILibraryTableViewController *lVC = [[BSILibraryTableViewController alloc] initWithModel:aModel
                                                                                        style:UITableViewStylePlain];
    UINavigationController *navlVC = [[UINavigationController alloc]initWithRootViewController:lVC];
    lVC.delegate = lVC;
    self.window.rootViewController = navlVC;
    
}

-(BSILibrary *)configureFirstAppear{
    
    //Comprobamos si tenemos guardado el JSON
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:DOWNLOAD_FINISH]) {
        //Creo la request
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"]];
        //Creo la response y el error para la conexión
        NSURLResponse *response= [[NSURLResponse alloc]init];
        NSError *error;
        //Procedo a realizar la conexión
        NSData *someData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];
        
        //compruebo si data es nil para ver si hay error
        if (someData != nil) {
            //lo guardo
            NSFileManager *manager = [NSFileManager defaultManager];
            NSArray *urls = [manager URLsForDirectory:NSDocumentDirectory
                                            inDomains:NSUserDomainMask];
            NSURL *url = [urls lastObject];
            url = [url URLByAppendingPathComponent:@"JSON.txt"];
            BOOL rc = [someData writeToURL:url
                                atomically:YES];
            if (rc) {
                [ud setObject:@YES
                       forKey:DOWNLOAD_FINISH];
                [ud synchronize];
            }
            //genero el modelo
            return [[BSILibrary alloc] initWithData:someData];
            
        }else{
            
            NSLog(@"error al descargar los datos del servidor: %@", error.localizedDescription);
            return nil;
            
        }
    }else{
        //si lo tengo guardado, busco en la carpeta Documents
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *urls = [manager URLsForDirectory:NSDocumentDirectory
                                        inDomains:NSUserDomainMask];
        NSURL *url = [urls lastObject];
        url = [url URLByAppendingPathComponent:@"JSON.txt"];
        NSData *someData = [NSData dataWithContentsOfURL:url];
        if (someData) {
            return [[BSILibrary alloc]initWithData:someData];
        }else{
            NSLog(@"error al leer los datos");
            return nil;
        }
        
    }
    

}

@end
