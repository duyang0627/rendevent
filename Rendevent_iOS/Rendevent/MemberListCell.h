//
//  MemberListCell.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *memberImg;

- (void)setImageForCellWithIndexPath:(NSString*)imageName;

@end
