
//
//  MainViewController.m
//  好鲜商城
//
//  Created by D.xin on 2019/6/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
     self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
   
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self setupUI];
}

- (void)setupUI
{
    self.adapter.collectionView = self.mainCollectionView;
    self.adapter.dataSource = self;
    self.adapter.scrollViewDelegate = self;
    [self.view addSubview:self.mainCollectionView];
}


- (void)viewDidLayoutSubviews
{
    self.mainCollectionView.frame = [self collectionViewFrame];
}

- (CGRect)collectionViewFrame
{
    return self.view.bounds;
}

#pragma  mark - IGListAdapterDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter
{
    return nil;
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object
{
    return nil;
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter
{
    return nil;
}
#pragma mark - DZNEmptyDataSource
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark - getter
- (UICollectionView *)mainCollectionView
{
    if(!_mainCollectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds
                                                collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        _mainCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _mainCollectionView;
}

- (IGListAdapter *)adapter
{
    if(!_adapter)
    {
        _adapter = [[IGListAdapter alloc]initWithUpdater:[[IGListAdapterUpdater alloc]init] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
