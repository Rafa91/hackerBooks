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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self trastear];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //generamos un librillo askeroso
    
//    BSIBook *book1 = [[BSIBook alloc]initWithAuthor:@[@"Author1"]
//                                           imageURL:nil
//                                             pdfURL:nil
//                                               tags:@[@"tag1"]
//                                          titleBook:@"title1"];
//    BSIBookViewController *bookVC = [[BSIBookViewController alloc] initWithModel:book1];
//    self.window.rootViewController = bookVC;
    
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

-(void) trastear{
    
    NSDictionary *aDic = @{@"authors" : @"author1",
                           @"image_url" : @"http://www.google.es",
                           @"pdf_url" : @"http://www.google.es",
                           @"tags" : @"tag1",
                           @"title" : @"title1"
                           };
    NSLog(@"object: %@", [aDic objectForKey:@"title"]);
    BSIBook *aBook = [[BSIBook alloc]initWithAuthor:nil
                                           imageURL:[NSURL URLWithString:[ aDic objectForKey:@"image_url"]]
                                             pdfURL:[NSURL URLWithString:[ aDic objectForKey:@"pdf_url"]]
                                               tags:nil
                                          titleBook:[aDic objectForKey:@"title"]];
    NSLog(@"object: %@", [aDic objectForKey:@"title"]);

}

@end
