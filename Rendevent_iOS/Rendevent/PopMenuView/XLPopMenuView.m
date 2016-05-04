//
//  XLPopMenuView.m
//  PopMenu_QQ_Demo
//
//  Created by yuanxiaolong on 16/3/28.
//  Copyright © 2016年 yuanxiaolong. All rights reserved.
//

#import "XLPopMenuView.h"
#import "XLMenuViewCell.h"
#import "XLPopMenuViewModel.h"
#import "XLPopMenuViewSingleton.h"
#import "LoginNaviBaseViewController.h"

#define CELLHEIGHT 40;

@interface XLPopMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) CGFloat menuWidth;
@property (nonatomic,copy) NSArray *menuItems;
@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,copy) void (^action)(NSInteger index);


@end

@implementation XLPopMenuView

- (instancetype)initWithFrame:(CGRect)frame
               menuStartPoint:(CGPoint)startPoint
                    menuWidth:(CGFloat)menuWidth
                    menuItems:(NSArray *)items
                       action:(void (^)(NSInteger index))action
{
    if (self = [super initWithFrame:frame])
    {
        self.menuWidth = menuWidth;
        self.menuItems = items;
        self.startPoint = startPoint;
        self.action = [action copy];
        self.popMenuTableView = [[UITableView alloc] initWithFrame:[self popMenuViewFrame] style:UITableViewStylePlain];
        self.popMenuTableView.delegate = self;
        self.popMenuTableView.dataSource = self;
        self.popMenuTableView.layer.cornerRadius = 10;
        self.popMenuTableView.layer.anchorPoint = CGPointMake(1.0, 0);
        self.popMenuTableView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.popMenuTableView.rowHeight = CELLHEIGHT;
        [self addSubview:self.popMenuTableView];
        
        [self.popMenuTableView registerClass:[XLMenuViewCell class] forCellReuseIdentifier:@"cell"];
        
        if ([self.popMenuTableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [self.popMenuTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self.popMenuTableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [self.popMenuTableView setLayoutMargins:UIEdgeInsetsZero];
        }

        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLMenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.menuItems > 0)
    {
        XLPopMenuViewModel *model = self.menuItems[indexPath.row];
        cell.textLabel.text = model.title;
        cell.imageView.image = [UIImage imageNamed:model.image];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1)
    {
        MMZCViewController *login=[[MMZCViewController alloc]init];
//        LoginNaviBaseViewController *nav=[[UINavigationController alloc]initWithRootViewController:login];
//        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1],NSForegroundColorAttributeName,nil];
//        [nav.navigationBar setTitleTextAttributes:attributes];
//        [self.navigationController presentModalViewController:nav animated:YES];
        UIViewController *curtopviewcontroller = [self topViewController];
//        UIViewController *parentController = [self.superview nextResponder];
        [curtopviewcontroller.navigationController pushViewController:login animated:YES];
    }
    if (self.action)
    {
        self.action(indexPath.row);
    }
}

- (CGRect)popMenuViewFrame
{
    CGFloat menuViewX = 75 + self.startPoint.x;
    CGFloat menuViewY = self.startPoint.y - self.menuItems.count * 20;
    CGFloat menuWidth = self.menuWidth;
    CGFloat menuHeight = self.menuItems.count * CELLHEIGHT;
    
    return CGRectMake(menuViewX, menuViewY, menuWidth, menuHeight);
    
}

#pragma mark - 绘制三角形
- (void)drawRect:(CGRect)rect
{
    // 背景色
    [[UIColor whiteColor] set];
    
    // 获取视图
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // 开始绘制
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, self.startPoint.x + self.menuWidth - 20, self.startPoint.y);
    CGContextAddLineToPoint(contextRef, self.startPoint.x + self.menuWidth - 20 * 2, self.startPoint.y);
    CGContextAddLineToPoint(contextRef, self.startPoint.x + self.menuWidth - 20 * 1.5, self.startPoint.y - 10);
    // 结束绘制
    CGContextClosePath(contextRef);
    // 填充色
    [[UIColor whiteColor] setFill];
    // 边框颜色
    [[UIColor whiteColor] setStroke];
    // 绘制路径
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[XLPopMenuViewSingleton shareManager] menuHide];
}


@end
