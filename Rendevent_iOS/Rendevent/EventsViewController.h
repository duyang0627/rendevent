//
//  EventsViewController.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLPopViewController.h"
#import "XLPopMenuViewModel.h"
#import "XLPopMenuViewSingleton.h"

@interface EventsViewController : UIViewController<UIPopoverPresentationControllerDelegate>

@property(strong, nonatomic) UISearchController *searchController;
@property (nonatomic,strong) CLPopViewController *itemPopVC;
@property (nonatomic,strong) NSMutableArray *popupItemarr;

@end
