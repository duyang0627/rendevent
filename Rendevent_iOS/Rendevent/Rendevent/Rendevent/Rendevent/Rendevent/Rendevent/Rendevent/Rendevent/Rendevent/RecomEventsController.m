//
//  RecomEventsController.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "RecomEventsController.h"
#import "CarbonKit.h"

@interface RecomEventsController ()
{
    CarbonSwipeRefresh *refresh;
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)didSegmentChanged:(id)sender {
    
}

- (void)refresh:(id)sender {
    [refresh endRefreshing];
}

@end
