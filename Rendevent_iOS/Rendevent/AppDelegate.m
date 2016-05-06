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
    
    //sport
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
    foottball.host_Id = 1;
    foottball.message_group_Id = 1;
    foottball.status = ParticipantNeeded;
    [eventsList addObject:foottball];
    
    //entertainment
    Event *clubbing = [Event initWithName:@"DanceClub" WithCategory:2 WithDes:@"KetMoRee" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    clubbing.minimum = 2;
    clubbing.maximum = 2;
    clubbing.mini_age = 21;
    clubbing.max_age = 25;
    clubbing.host_Id = 2;
    clubbing.message_group_Id = 2;
    clubbing.status = ParticipantNeeded;
    [eventsList addObject:clubbing];
    
    //entertainment
    Event *bowling = [Event initWithName:@"Bowling" WithCategory:2 WithDes:@"Memorial Union UC Davis" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    bowling.minimum = 6;
    bowling.maximum = 12;
    bowling.mini_age = 0;
    bowling.max_age = 0;
    bowling.host_Id = 3;
    bowling.message_group_Id = 3;
    bowling.status = ParticipantNeeded;
    [eventsList addObject:bowling];
    
    //food
    Event *dining = [Event initWithName:@"Dining Together" WithCategory:3 WithDes:@"Seasons" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    dining.minimum = 2;
    dining.maximum = 4;
    dining.mini_age = 18;
    dining.max_age = 23;
    dining.host_Id = 0;
    dining.message_group_Id = 4;
    dining.status = ParticipantNeeded;
    [eventsList addObject:dining];
    
    //outdoor
    Event *biking = [Event initWithName:@"Spring time! Biking near Lake Beryessa" WithCategory:4 WithDes:@"Lake Beryessa" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    biking.minimum = 6;
    biking.maximum = 0;
    biking.mini_age = 0;
    biking.max_age = 0;
    biking.host_Id = 4;
    biking.message_group_Id = 5;
    biking.status = ParticipantNeeded;
    [eventsList addObject:biking];
    
    
    Event *hiking = [Event initWithName:@"Spring Break Yosemite Hiking" WithCategory:4 WithDes:@"Yosemite National Park" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    hiking.minimum = 6;
    hiking.maximum = 12;
    hiking.mini_age = 17;
    hiking.max_age = 30;
    hiking.host_Id = 3;
    hiking.message_group_Id = 6;
    hiking.status = ParticipantNeeded;
    [eventsList addObject:hiking];
    
    //study
    Event *studying = [Event initWithName:@"ECS 150 Final Review" WithCategory:5 WithDes:@"Kemper Hall" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    studying.minimum = 2;
    studying.maximum = 10;
    studying.mini_age = 0;
    studying.max_age = 0;
    studying.host_Id = 5;
    studying.message_group_Id = 7;
    studying.status = ParticipantNeeded;
    [eventsList addObject:studying];
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"EventList.ldata"];
    
//    NSMutableArray *myObject=[NSMutableArray array];
//    [myObject addObject:self.settings];
    
    BOOL res = [NSKeyedArchiver archiveRootObject:eventsList toFile:appFile];
    
//    NSMutableArray* myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
}

@end
