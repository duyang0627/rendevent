//
//  EventInfoCellTableViewCell.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventInfoCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTiltleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

@end
