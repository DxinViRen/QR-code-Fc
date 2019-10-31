//
//  QrShowReVC.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/29.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QrShowReVC.h"
#import "SearchUreVCtopCell.h"

@interface QrShowReVC ()

@end

@implementation QrShowReVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    self.navigationItem.title = @"Scan Result";
    [self.adapter reloadDataWithCompletion:nil];
}

- (void)configData{
    HomeMainModel *topModel = [[HomeMainModel alloc]init];
    topModel.cellName =NSStringFromClass([SearchUreVCtopCell class]);
    topModel.cellHeight = 200;
    topModel.extra = [@{@"link":self.data} mutableCopy];
    
    SectionSeporModel *secmodel = [[SectionSeporModel alloc]initWithArray:[@[topModel] mutableCopy]];
    self.dataArray = [[NSMutableArray alloc]initWithObjects:secmodel, nil];
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.dataArray;
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    Dx_RubSectionController *dxru  = [[Dx_RubSectionController alloc]init];
    dxru.cellDidClickBlock = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index) {
        
    };
    dxru.configCellBlocck = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index, MainCollectionViewCell * _Nonnull cell) {
        if([cell isKindOfClass:[SearchUreVCtopCell class]]){
            SearchUreVCtopCell *topcell = (SearchUreVCtopCell *)cell;
            topcell.visLineBlock = ^(NSString * _Nonnull adress) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            };
        }
    };
    return dxru;
}



@end
