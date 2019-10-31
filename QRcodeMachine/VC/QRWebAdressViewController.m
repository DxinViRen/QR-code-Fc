//
//  QRWebAdressViewController.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QRWebAdressViewController.h"
#import "QRWebInputCell.h"
#import "QrShowImgVC.h"
@interface QRWebAdressViewController ()

@end

@implementation QRWebAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configDataSource];
    self.navigationItem.title = @"Website";
    [self.adapter reloadDataWithCompletion:nil];
}

- (void)configDataSource{
    HomeMainModel *mianModel = [[HomeMainModel alloc]init];
    mianModel.cellName = NSStringFromClass([QRWebInputCell class]);
    mianModel.cellHeight = 320;
    SectionSeporModel *secmo = [[SectionSeporModel alloc]initWithArray:[@[mianModel] mutableCopy]];
    self.dataArray = [[NSMutableArray alloc]initWithObjects:secmo, nil];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    Dx_RubSectionController *dxrub = [[Dx_RubSectionController alloc]init];
    dxrub.cellDidClickBlock = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index) {
        
    };
    
    dxrub.configCellBlocck = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index, MainCollectionViewCell * _Nonnull cell) {
        if([cell isKindOfClass:[QRWebInputCell class]]){
            QRWebInputCell *qecell = (QRWebInputCell *)cell;
            qecell.turnBlock = ^(NSString * _Nonnull text) {
                QrShowImgVC *qrshow = [[QrShowImgVC alloc]init];
                [QRFacManager shareInstance].data = [text dataUsingEncoding:NSUTF8StringEncoding];
                [self.navigationController pushViewController:qrshow animated:YES];
                [[QRFacManager shareInstance] generCreateNum];
            };
        }
    };
    return dxrub;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.dataArray;
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
