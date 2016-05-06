//
//  AppDelegate.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "AppDelegate.h"
#import "Event.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initialModalData];
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

- (void)initialModalData {
    NSMutableArray *eventsList = [NSMutableArray arrayWithCapacity:10];
    
    Event *basketball = [Event initWithName:@"PlayBasketBall" WithCategory:1 WithDes:@"ARC Full court" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    basketball.minimum = 5;
    basketball.maximum = 15;
    basketball.mini_age = 18;
    basketball.max_age = 45;
    basketball.host_Id = 0;
    basketball.message_group_Id = 0;
    basketball.status = ParticipantNeeded;
    [eventsList addObject:basketball];
    
    Event *foottball = [Event initWithName:@"PlayFootBall" WithCategory:1 WithDes:@"Pavilion Full court" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    foottball.minimum = 6;
    foottball.maximum = 22;
    foottball.mini_age = 22;
    foottball.max_age = 33;
    foottball.host_Id = 0;
    foottball.message_group_Id = 0;
    foottball.status = ParticipantNeeded;
    [eventsList addObject:foottball];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"EventList.ldata"];
    
//    NSMutableArray *myObject=[NSMutableArray array];
//    [myObject addObject:self.settings];
    
    BOOL res = [NSKeyedArchiver archiveRootObject:eventsList toFile:appFile];
    
//    NSMutableArray* myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
}

@end
