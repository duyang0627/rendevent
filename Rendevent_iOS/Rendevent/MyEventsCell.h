//
//  MyEventsCell.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/26/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEventsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eventImg;
@property (weak, nonatomic) IBOutlet UIImageView *hostImg;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *attendNum;
@property (weak, nonatomic) IBOutlet UILabel *capacityNum;

@end
