//
//  MyEventsListTableViewController.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/26/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface MyEventsListTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    int currentCategoryIndex;
    NSMutableArray *currentList;
}
@property (weak, nonatomic) IBOutlet UITableView *eventTable;

- (void)setCategoryIndex:(int)index;
- (void)setTableCellList:(NSMutableArray *) curList;
@end
