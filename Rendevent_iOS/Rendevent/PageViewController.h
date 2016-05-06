//
//  PageViewController.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberListView.h"
#import "Event.h"

@interface PageViewController : UITableViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UITableViewCell *eventInfoCell;

@property (weak, nonatomic) IBOutlet MemberListView *memberCollection;
@property (weak, nonatomic) IBOutlet UITableViewCell *PhotoCellView;
@property (weak, nonatomic) IBOutlet UIImageView *eventImgview;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *atendNum;
@property (weak, nonatomic) IBOutlet UILabel *capacityNum;
@property (nonatomic,weak) Event *curEvent;
@property (nonatomic,weak) UIImage *eventImg;
@property (nonatomic,weak) UIImage *hostImg;
@end
