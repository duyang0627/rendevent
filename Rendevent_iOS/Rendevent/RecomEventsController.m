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
#import "VOSegmentedControl.h"

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
    
//    CatigoriesSegs.tintColor = [UIColor clearColor];
//    CatigoriesSegs.
//    self.tableView.tableHeaderView = CatigoriesSegs;
    
    VOSegmentedControl *segctrl2 = [[VOSegmentedControl alloc] initWithSegments:@[@{@"image": @"sport", @"selectedImage": @"sport"},
                                                                                  @{@"image": @"play", @"selectedImage": @"play"},
                                                                                  @{@"image": @"food", @"selectedImage": @"food"},
                                                                                  @{@"image": @"outdoor", @"selectedImage": @"outdoor"},
                                                                                  @{@"image": @"study", @"selectedImage": @"study"},
                                                                                  @{@"image": @"other", @"selectedImage": @"other"}]];
    segctrl2.contentStyle = VOContentStyleImageAlone;
    segctrl2.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    segctrl2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    segctrl2.allowNoSelection = YES;
    
    segctrl2.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    segctrl2.selectedTextFont = [UIFont systemFontOfSize:30];
    segctrl2.indicatorThickness = 6;
    segctrl2.indicatorCornerRadius = 3;
    segctrl2.tag = 2;
    self.tableView.tableHeaderView = segctrl2;
    [self.view addSubview:segctrl2];
//    [segctrl2 setIndexChangeBlock:^(NSInteger index) {
//        NSLog(@"2: block --> %@", @(index));
//    }];
    [segctrl2 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    
    //initialize data modal
    currentCategoryIndex = 0;

    
    //unarchieve data
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"EventList.ldata"];
    eventsList = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
    
    cureventsList = [self filteringEventList:eventsList withCategory:currentCategoryIndex];
    
//    //initialize cell extendable statue array
//    cellStatus = [[NSMutableArray alloc] init];
//    for (int i = 0; [cureventsList count]; i++) {
//        [cellStatus addObject:[NSNumber numberWithBool:NO]];
//    }
}

- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    currentCategoryIndex = segmentCtrl.selectedSegmentIndex + 1;
    cureventsList = [self filteringEventList:eventsList withCategory:currentCategoryIndex];
    
    [self.tableView reloadData];
}

-(NSMutableArray *)filteringEventList:(NSMutableArray*)eventList withCategory:(int)caIndex
{
    NSMutableArray *newList = [NSMutableArray arrayWithCapacity:10];
    for (Event* e in eventList) {
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
