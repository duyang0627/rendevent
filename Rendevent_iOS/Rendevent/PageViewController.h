//
//  PageViewController.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberListView.h"

@interface PageViewController : UITableViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UITableViewCell *eventInfoCell;

@property (weak, nonatomic) IBOutlet MemberListView *memberCollection;
@property (weak, nonatomic) IBOutlet UITableViewCell *PhotoCellView;
@end
