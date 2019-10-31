//
//  ScanURlReopVC.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/29.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "ScanURlReopVC.h"
#import "SearchUReTopCell.h"
#import "ScanResultViewController.h"
@interface ScanURlReopVC ()

@end

@implementation ScanURlReopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    self.navigationItem.title = @"Scan Result";
    [self.adapter reloadDataWithCompletion:nil];
}

- (void)configData{
    HomeMainModel *topModel = [[HomeMainModel alloc]init];
    topModel.cellName =NSStringFromClass([SearchUReTopCell class]);
    topModel.cellHeight = 200;
    topModel.extra = [@{@"link":self.linestr} mutableCopy];
    
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
        if([cell isKindOfClass:[SearchUReTopCell class]]){
            SearchUReTopCell *topcell = (SearchUReTopCell *)cell;
            topcell.visLineBlock = ^(NSString * _Nonnull adress) {
                ScanResultViewController *scaUr= [[ScanResultViewController alloc]initWithAdress:adress];
                
                [self.navigationController pushViewController:scaUr animated:YES];
            };
        }
    };
    return dxru;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
