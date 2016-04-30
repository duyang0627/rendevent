//
//  EventCellDetail.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCellDetail : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImg;
@property (weak, nonatomic) IBOutlet UIImageView *hostImg;

@end
