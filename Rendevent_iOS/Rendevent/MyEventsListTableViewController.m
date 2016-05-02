//
//  MyEventsListTableViewController.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/26/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "MyEventsListTableViewController.h"
#import "MyEventsCell.h"
#import "Event.h"

@implementation MyEventsListTableViewController

-(void)setCategoryIndex:(int)index{
    currentCategoryIndex = index;
}

-(void)setTableCellList:(NSMutableArray *)curList
{
    currentList = curList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _eventTable.backgroundColor = [UIColor grayColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [currentList count];
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    //    [dateFormatter release];
    return destDateString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyEventsCell *cell = (MyEventsCell * )[tableView dequeueReusableCellWithIdentifier:@"MyEventCell"];
    Event *event = [currentList objectAtIndex:indexPath.row];
    cell.eventTitle.text = event.name;
    cell.startTime.text = [self stringFromDate:event.startTime];
    cell.endTime.text = [self stringFromDate:event.endTime];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did select %ld", indexPath.row);
}

@end
