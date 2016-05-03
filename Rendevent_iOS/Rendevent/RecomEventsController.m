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
//    CarbonSwipeRefresh *refresh;
    NSMutableArray *eventsList;
    NSMutableArray *cureventsList;
    int currentCategoryIndex;
    
//    NSMutableArray *cellStatus;
    BOOL isOpen;
    NSIndexPath *selectIndex;
}
@end

@implementation RecomEventsController

@synthesize CatigoriesSegs;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    isOpen = YES;
    
//    refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.tableView];
//    [refresh setColors:@[
//                         [UIColor blueColor],
//                         [UIColor redColor],
//                         [UIColor orangeColor],
//                         [UIColor greenColor]]
//     ]; // default tintColor
    
    // If your ViewController extends to UIViewController
    // else see below
//    [self.view addSubview:refresh];
//    CGRect sizeb = self.tableView.frame;
//    
//    self.tableView.frame = [[UIScreen mainScreen] bounds];
//    self.tableView.backgroundColor = [UIColor greenColor];
    
//    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
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
    
//    //initialize cell extendable statue array
//    cellStatus = [[NSMutableArray alloc] init];
//    for (int i = 0; [cureventsList count]; i++) {
//        [cellStatus addObject:[NSNumber numberWithBool:NO]];
//    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectIndex.row == indexPath.row && selectIndex!=nil) {
        if (isOpen) {
            return 180;
        }
        return 100;
    }
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell;
    Event *event = [cureventsList objectAtIndex:indexPath.row];
    if(selectIndex.row == indexPath.row  && selectIndex != nil){
        if(isOpen){
            cell = (EventCell * )[tableView dequeueReusableCellWithIdentifier:@"EventCellDetail"];
            cell.titleLabel.text = event.name;
            cell.startLabel.text = [self stringFromDate:event.startTime];
            cell.endLabel.text = [self stringFromDate:event.endTime];
        }
        else{
            cell = (EventCell * )[tableView dequeueReusableCellWithIdentifier:@"EventCell"];
            cell.titleLabel.text = event.name;
            cell.startLabel.text = [self stringFromDate:event.startTime];
            cell.endLabel.text = [self stringFromDate:event.endTime];
            cell.hostImg.image = [UIImage imageNamed:@"4"];
        }
    }else{
        cell = (EventCell * )[tableView dequeueReusableCellWithIdentifier:@"EventCell"];
        cell.titleLabel.text = event.name;
        cell.startLabel.text = [self stringFromDate:event.startTime];
        cell.endLabel.text = [self stringFromDate:event.endTime];
        cell.hostImg.image = [UIImage imageNamed:@"4"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //更改选中cell的状态 用以 刷新页面是进行折叠和展开
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
//    NSNumber *nNum = [cellStatus objectAtIndex:indexPath.row];
//    BOOL ifOpen = ![nNum boolValue];
//    nNum = [NSNumber numberWithBool:ifOpen];
//    if (ifOpen) {
//        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
//    }else{
//        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
//    }
    if (selectIndex!=nil &&indexPath.row ==selectIndex.row) {
        isOpen = !isOpen;
    }else if (selectIndex!=nil && indexPath.row!=selectIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath,selectIndex, nil];
        isOpen=YES;
    }
    selectIndex=indexPath;
    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (IBAction)didSegmentChanged:(id)sender {
    currentCategoryIndex = [sender selectedSegmentIndex];
    cureventsList = [self filteringEventList:eventsList withCategory:currentCategoryIndex];
//    cellStatus = [[NSMutableArray alloc] init];
//    for (int i = 0; [cureventsList count]; i++) {
//        [cellStatus addObject:[NSNumber numberWithBool:NO]];
//    }
    
    [self.tableView reloadData];
}

//- (void)refresh:(id)sender {
//    [refresh endRefreshing];
//}

@end
