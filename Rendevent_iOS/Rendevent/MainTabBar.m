//
//  MainTabBar.m
//  Rendevent
//
//  Created by LiaoYangguang on 5/5/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "MainTabBar.h"

@implementation MainTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 60;
    for(UITabBarItem *item in self.items)
    {
        item.titlePositionAdjustment = UIOffsetMake(0.0, -5.0);
    }
    
    return sizeThatFits;
}
@end
