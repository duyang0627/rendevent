//
//  RecomEventsController.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "RecomEventsController.h"
#import "CarbonKit.h"
#import "Event.h"
#import "EventCell.h"

@interface RecomEventsController ()
{
    CarbonSwipeRefresh *refresh;
    NSMutableArray *eventsList;
    NSMutableArray *cureventsList;
    int currentCategoryIndex;
}
@end

@implementation RecomEventsController

@synthesize CatigoriesSegs;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.tableView];
    [refresh setColors:@[
                         [UIColor blueColor],
                         [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor greenColor]]
     ]; // default tintColor
    
    // If your ViewController extends to UIViewController
    // else see below
    [self.view addSubview:refresh];
    
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableHeaderView = CatigoriesSegs;
    
    //initialize data modal
    currentCategoryIndex = 0;
    
    eventsList = [NSMutableArray arrayWithCapacity:10];
    Event *basketball = [Event initWithName:@"PlayBasketBall" WithCategory:1 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    [eventsList addObject:basketball];
    Event *ktv = [Event initWithName:@"KTV" WithCategory:2 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    [eventsList addObject:ktv];
    Event *hunan = [Event initWithName:@"Hunan" WithCategory:3 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    [eventsList addObject:hunan];
    Event *hike = [Event initWithName:@"Hiking!" WithCategory:4 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    [eventsList addObject:hike];
    Event *football = [Event initWithName:@"PlayFootball" WithCategory:1 WithDes:@"" WithStartTime:[NSDate date] WithEndTime:[NSDate date]];
    [eventsList addObject:football];
    
    cureventsList = [self filteringEventList:eventsList withCategory:currentCategoryIndex];
}

-(NSMutableArray *)filteringEventList:(NSMutableArray*)eventList withCategory:(int)caIndex
{
    NSMutableArray *newList = [NSMutableArray arrayWithCapacity:10];
    for (Event* e in eventsList) {
        if(e.category == caIndex || caIndex == 0)
            [newList addObject:e];
    }
    return newList;
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
//    [dateFormatter release];
    return destDateString;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    return [cureventsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = (EventCell * )[tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    Event *event = [cureventsList objectAtIndex:indexPath.row];
    cell.titleLabel.text = event.name;
    cell.startLabel.text = [self stringFromDate:event.startTime];
    cell.endLabel.text = [self stringFromDate:event.endTime];
    
    return cell;
}

- (IBAction)didSegmentChanged:(id)sender {
    currentCategoryIndex = [sender selectedSegmentIndex];
    cureventsList = [self filteringEventList:eventsList withCategory:currentCategoryIndex];
    [self.tableView reloadData];
}

- (void)refresh:(id)sender {
    [refresh endRefreshing];
}

@end
