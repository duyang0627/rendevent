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

-(void)loadView {
    [super loadView];
}

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
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    //    [dateFormatter release];
    return destDateString;
}

- (NSString *)getTypeName:(int)category {
    switch (category) {
        case 1:
            return @"SPORT";
            break;
        case 2:
            return @"ENTERTAIMNET";
            break;
        case 3:
            return @"FOOD";
            break;
        case 4:
            return @"OUTDOOR";
            break;
        case 5:
            return @"STUDY";
            break;
        case 6:
            return @"OTHER";
            break;
        default:
            break;
    }
    return @"wrong type";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyEventsCell *cell = (MyEventsCell * )[tableView dequeueReusableCellWithIdentifier:@"MyEventCell"];
    Event *event = [currentList objectAtIndex:indexPath.row];
    cell.eventTitle.text = event.name;
    cell.startTime.text = [self stringFromDate:event.startTime];
    cell.endTime.text = [self stringFromDate:event.endTime];
    cell.typeLabel.text = [self getTypeName:event.categorye];
    cell.attendNum.text = [NSString stringWithFormat: @"%ld", (long)event.minimum];
    cell.capacityNum = [NSString stringWithFormat: @"%ld", (long)event.maximum];
    int index = arc4random()%17 + 1;
    NSString *str=[NSString stringWithFormat:@"eventpic%d", index];
    UIImage* img = [UIImage imageNamed:str];
    cell.eventImg.image = img;
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"did select %ld", indexPath.row);
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"goEventFromMyList"])
    {
        MyEventsCell * cell = (MyEventsCell *)sender;
//        UITableView* tableview = (UITableView*)cell.superview;
        NSIndexPath * path = [_eventTable indexPathForCell:cell];
        Event *event = [currentList objectAtIndex:path.row];
        id theSegue = segue.destinationViewController;
        [theSegue setValue:event forKey:@"curEvent"];
        [theSegue setValue:cell.eventImg.image forKey:@"eventImg"];
        [theSegue setValue:cell.hostImg.image forKey:@"hostImg"];
    }
}

@end
