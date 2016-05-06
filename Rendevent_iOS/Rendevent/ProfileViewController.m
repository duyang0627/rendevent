//
//  ProfileViewController.m
//  Rendevent
//
//  Created by LiaoYangguang on 5/3/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "ProfileViewController.h"
#import "LayoutColor.h"

@implementation ProfileViewController

-(void)viewDidLoad {
    [self style];
}

- (void)style {
    
    UIColor* color = [LayoutColor mainColor];
    //    self.navigationItem.titleView = self.searc
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    UIImage* myImage = [UIImage imageNamed:@"dahuangmao-4.png"];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:myImage];
    CGFloat Height = self.navigationController.navigationBar.frame.size.height;
    [imgView setFrame:CGRectMake(134.0f, imgView.frame.origin.y, Height, Height)];
    [self.navigationController.navigationBar addSubview:imgView];
}

@end
