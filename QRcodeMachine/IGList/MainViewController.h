//
//  MainViewController.h
//  好鲜商城
//
//  Created by D.xin on 2019/6/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController<IGListAdapterDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

NS_ASSUME_NONNULL_END
