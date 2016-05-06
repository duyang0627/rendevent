//
//  MyEventsViewController.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/26/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "MyEventsViewController.h"
#import "CarbonKit.h"
#import "MyEventsListTableViewController.h"
#import "Event.h"

@interface MyEventsViewController () <CarbonTabSwipeNavigationDelegate>
{
    NSArray *items;
    MyEventsListTableViewController *eventTableView;
    NSInteger sectionNum; //All = 0, Sports = 1 ,Entertaimnet = 0, ...
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
    NSMutableArray *eventsList;
    NSMutableArray *cureventsList;
}

@end

@implementation MyEventsViewController

- (void)loadView {
    [super loadView];
//    eventTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyEventsListTableView"]; //?bug
    
    sectionNum = 0;
    
    //Initialize data
//    eventsList = [NSMutableArray arrayWithCapacity:10];
//    Event *basketball = [Event initWithName:@"PlayBasketBall" WithCategory:1 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
//    [eventsList addObject:basketball];
//    Event *ktv = [Event initWithName:@"KTV" WithCategory:2 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
//    [eventsList addObject:ktv];
//    Event *hunan = [Event initWithName:@"Hunan" WithCategory:3 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
//    [eventsList addObject:hunan];
//    Event *hike = [Event initWithName:@"Hiking!" WithCategory:4 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
//    [eventsList addObject:hike];
//    Event *football = [Event initWithName:@"PlayFootball" WithCategory:1 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
//    [eventsList addObject:football];
    
    //unarchieve data
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"EventList.ldata"];
    eventsList = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    
//    cureventsList = [self filteringEventList:eventsList withCategory:currentCategoryIndex];
    
    cureventsList = [self filteringEventList:eventsList withCategory:sectionNum];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MyEvents";
    
    items = @[@"ALL", @"Sports", @"Entertainment", @"Food", @"Outdoor", @"Study", @"Other"];
    
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    
    [self style];
}

-(NSMutableArray *)filteringEventList:(NSMutableArray*)eventList withCategory:(int)caIndex
{
    NSMutableArray *newList = [NSMutableArray arrayWithCapacity:10];
    for (Event* e in eventsList) {
        if(e.categorye == caIndex || caIndex == 0)
            [newList addObject:e];
    }
    return newList;
}

- (void)style {
    
    UIColor *color = [UIColor colorWithRed:24.0/255 green:75.0/255 blue:152.0/255 alpha:1];
    //    self.navigationItem.titleView = self.searc
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setIndicatorColor:color];
    [carbonTabSwipeNavigation setTabExtraWidth:30];
    CGRect rect = [[UIScreen mainScreen] bounds];
    for (int i = 0; i<[items count]; i++) {
        [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:120 forSegmentAtIndex:i];
    }
    
    // Custimize segmented control
    [carbonTabSwipeNavigation setNormalColor:[color colorWithAlphaComponent:0.6]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:color
                                          font:[UIFont boldSystemFontOfSize:14]];
}

# pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    sectionNum = index;
    eventTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyEventsListTableView"];
    return eventTableView;
}

// optional
- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                 willMoveAtIndex:(NSUInteger)index {
//    self.title = items[index];
    NSLog(@"Will move at index: %ld", index);
    cureventsList = [self filteringEventList:eventsList withCategory:index];
    if(eventTableView){
      [eventTableView setCategoryIndex:index];
    [eventTableView setTableCellList:cureventsList];
    }
    
}

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    NSLog(@"Did move at index: %ld", index);
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}

@end
