//
//  PageViewController.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/30/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "PageViewController.h"
#import "EventInfoCellTableViewCell.h"
#import "MemberListCell.h"
#import "MemberListView.h"
#import "SDCycleScrollView.h"

#define SCREEN_WIDTH self.view.bounds.size.width

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self.storyboard instantiateViewControllerWithIdentifier:@"EventPageInfoView"];
//    [self.view addSubview:self.collectionView];
    
//    [self.memberCollection registerClass:[MemberListCell class] forCellWithReuseIdentifier:@"memberCell"];
    [self.memberCollection registerNib:[UINib nibWithNibName:@"MemberListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"memberCell"];
//    _memberCollection.backgroundColor = [UIColor clearColor];
    
    //TableView style
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //PhotoCell style
    _PhotoCellView.backgroundColor = [UIColor greenColor];
    [self initCycleScrollView];
    
}

- (void)initCycleScrollView{
    
    UIImage *image1 = [UIImage imageNamed:@"first1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"first2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"first3.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"first4.jpg"];
    NSArray *array = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170) imagesGroup:array];
    cycleScrollView.autoScrollTimeInterval = 2.0;
    cycleScrollView.delegate = self;
    cycleScrollView.dotColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [_PhotoCellView.contentView addSubview:cycleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UICollectionView*)collectionView{
//    
//    if (!_collectionView) {
//        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
//        flowLayout.itemSize = CGSizeMake(30, 30);
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) collectionViewLayout:flowLayout];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.backgroundColor = [UIColor greenColor];
//        [_collectionView registerNib:[UINib nibWithNibName:@"MemberListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"memberCell"];
//        
//    }
//    return _collectionView;
//}

//#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
//
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MemberListCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"memberCell" forIndexPath:indexPath];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"5Stars" ofType:@"png"];
//    cell.memberImg.image = [UIImage imageWithContentsOfFile:path];
    [cell setImageForCellWithIndexPath:@"44"];
    return cell;
}

//#pragma mark 触摸背景来关闭虚拟键盘
//-(IBAction)backgroundTap:(id)sender
//{
//    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
//    self.view.frame = rect;
//    [UIView commitAnimations];
//    
//    [textField1 resignFirstResponder];
//    [textField2 resignFirstResponder];
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ZealerVideoWebViewController *zealerVideoVC = [[ZealerVideoWebViewController alloc] init];
//    zealerVideoVC.index = indexPath.row;
//    zealerVideoVC.type = ScrollViewCollectionRequest;
//    [self.navigationController pushViewController:zealerVideoVC animated:YES];
//}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 5;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    if(section == 0)
//        return 1;
//    return 0;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: @"cell"] ;    //  2
//    }
////    UITableViewCell *cell;
//    // Configure the cell...
//    if (indexPath.section == 0) {
//        cell = (EventInfoCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"EventInfoCell"];
//        if(cell == nil)
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstTableViewCell" owner:self options:nil] objectAtIndex:0];
//        return cell;
//    }
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
