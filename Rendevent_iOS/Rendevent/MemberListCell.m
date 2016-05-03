//
//  MemberListCell.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "MemberListCell.h"

@implementation MemberListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setImageForCellWithIndexPath:(NSString *)imageName {
    self.memberImg.image = [UIImage imageNamed:imageName];
}

@end
