//
//  QrNameViewController.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QrNameViewController.h"
#import "QrNameCell.h"
#import "QrNameBtnCell.h"
#import "QrShowImgVC.h"
@interface QrNameViewController ()

@end

@implementation QrNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"business card";
    [self configdata];
    [self.adapter reloadDataWithCompletion:nil];
}

- (void)configdata{
    HomeMainModel *nameModel = [[HomeMainModel alloc]init];
    nameModel.cellName = NSStringFromClass([QrNameCell class]);
    nameModel.cellHeight = 50;
    nameModel.extra = [@{@"title":@"name",
                         @"plc":@"Please enter  name"
                         } mutableCopy];
    
    HomeMainModel *phoneModel = [[HomeMainModel alloc]init];
    phoneModel.cellName = NSStringFromClass([QrNameCell class]);
    phoneModel.cellHeight = 50;
    phoneModel.extra = [@{@"title":@"phone",
                          @"plc":@"Please enter phone"
                         } mutableCopy];
    
    HomeMainModel *comModel = [[HomeMainModel alloc]init];
    comModel.cellName = NSStringFromClass([QrNameCell class]);
    comModel.cellHeight = 50;
    comModel.extra = [@{@"title":@"company",
                        @"plc":@"Please enter company name"
                         } mutableCopy];
    
    HomeMainModel *posiModel = [[HomeMainModel alloc]init];
    posiModel.cellName = NSStringFromClass([QrNameCell class]);
    posiModel.cellHeight = 50;
    posiModel.extra = [@{@"title":@"position",
                         @"plc":@"Please enter position"
                         } mutableCopy];
    
    HomeMainModel *EmaModel = [[HomeMainModel alloc]init];
      EmaModel.cellName = NSStringFromClass([QrNameCell class]);
      EmaModel.cellHeight = 50;
      EmaModel.extra = [@{@"title":@"Email",
                          @"plc":@"Please enter Email"
                           } mutableCopy];
    
    HomeMainModel *btnModel = [[HomeMainModel alloc]init];
         btnModel.cellName = NSStringFromClass([QrNameBtnCell class]);
         btnModel.cellHeight = 100;
         //EmaModel.extra = [@{@"title":@"Email",
//                             @"plc":@"Please enter Email"
//                              } mutableCopy];
    
    SectionSeporModel *secmodel = [[SectionSeporModel alloc]initWithArray: [@[nameModel,phoneModel,comModel,posiModel,EmaModel,btnModel] mutableCopy]];
    self.dataArray =[[NSMutableArray alloc]initWithObjects:secmodel, nil];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    Dx_RubSectionController *dxrub  =[[Dx_RubSectionController alloc]init];
    dxrub.configCellBlocck = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index, MainCollectionViewCell * _Nonnull cell) {
        if([cell isKindOfClass:[QrNameBtnCell class]]){
            QrNameBtnCell *btncell = (QrNameBtnCell *)cell;
            btncell.turnBlock = ^{
                //将text传递
                SectionSeporModel *secmodel  =self.dataArray[0];
                
               __block  NSString *tarText = @"";
                [secmodel.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if(idx<secmodel.dataArray.count-1){
                        HomeMainModel *hmodel = (HomeMainModel *)obj;
                        tarText = [NSString stringWithFormat:@"%@%@",tarText,hmodel.extra[@"text"]];
                    }
                }];
                
                QrShowImgVC *qrshow = [[QrShowImgVC alloc]init];
                                                 [QRFacManager shareInstance].data = [tarText dataUsingEncoding:NSUTF8StringEncoding];
                                                  [self.navigationController pushViewController:qrshow animated:YES];
                                   [[QRFacManager shareInstance] generCreateNum];
            };
        }
        
    };
    dxrub.cellDidClickBlock = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index) {
        
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
