//
//  EventsViewController.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "EventsViewController.h"
#import "RecomEventsController.h"
#import "CarbonKit.h"
#import "MySearchResultController.h"


@interface EventsViewController () <CarbonTabSwipeNavigationDelegate>
{
    NSArray *items;
    NSArray *popupMenuItem;
    NSArray *popupMenuImg;
    UISearchBar *searchBar;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
    MySearchResultController *resultController;
}

@end

@implementation EventsViewController

@synthesize searchController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Events";
    
    searchBar = [[UISearchBar alloc] init];
    searchBar.showsCancelButton = YES;
    searchBar.showsSearchResultsButton = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
//    resultController = [[MySearchResultController alloc] init];
//    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.dimsBackgroundDuringPresentation = false;
    // Install the search bar as the table header.
//    self.navigationItem.titleView = searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarAction)];
    // It is usually good to set the presentation context.
    self.definesPresentationContext = YES;
    
    items = @[@"Recommendation", @"Nearby", @"Soon"];
    popupMenuItem = @[@"New Event", @"Login", @"Search"];
    popupMenuImg = @[@"plus_2x", @"house_2x", @"glass_2x"];
    
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    
    [self style];
}

- (void) dismissKeyboard
{
    // add self
    [self->searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBarAction
{
    if (!_popupItemarr)
    {
        _popupItemarr = [[NSMutableArray alloc] init];
        for (int i = 0; i < popupMenuItem.count; i++) {
            XLPopMenuViewModel *model = [[XLPopMenuViewModel alloc] init];
            model.image = popupMenuImg  [i]; //添加图片
            model.title = popupMenuItem[i];
            [_popupItemarr addObject:model];
        }
    }
    // 弹出框的宽度
    CGFloat menuViewWidth = 150;
    // 弹出框的左上角起点坐标
    CGPoint startPoint = CGPointMake([UIScreen mainScreen].bounds.size.width - menuViewWidth - 10, 64 + 12);
    
    [[XLPopMenuViewSingleton shareManager] creatPopMenuWithFrame:startPoint popMenuWidth:menuViewWidth popMenuItems:_popupItemarr action:^(NSInteger index) {
        NSLog(@"index= %ld",(long)index);
        
    }];
    
}

- (void)style {
    
    UIColor *color = [UIColor colorWithRed:24.0/255 green:75.0/255 blue:152.0/255 alpha:1];
//    self.navigationItem.titleView = self.searc
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    UIImage* myImage = [UIImage imageNamed:@"dahuangmao-10.png"];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:myImage];
    CGFloat Height = self.navigationController.navigationBar.frame.size.height;
    [imgView setFrame:CGRectMake(114.0f, imgView.frame.origin.y, Height, Height)];
    [self.navigationController.navigationBar addSubview:imgView];
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setIndicatorColor:color];
    [carbonTabSwipeNavigation setTabExtraWidth:30];
    CGRect rect = [[UIScreen mainScreen] bounds];
    NSUInteger width = rect.size.width/3;
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width forSegmentAtIndex:1];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width forSegmentAtIndex:2];
    
    // Custimize segmented control
    [carbonTabSwipeNavigation setNormalColor:[color colorWithAlphaComponent:0.6]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:color
                                          font:[UIFont boldSystemFontOfSize:14]];
}

# pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"RecomEventView"];
            
        case 1:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"RecomEventView"];
            
        default:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"RecomEventView"];
    }
}

// optional
- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                 willMoveAtIndex:(NSUInteger)index {
//    self.title = items[index];
    NSLog(@"Will move at index: %ld", index);
}

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    NSLog(@"Did move at index: %ld", index);
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}

@end
