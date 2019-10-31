//
//  TextGeneVC.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "TextGeneVC.h"
#import "TextConInputCell.h"
#import "QrShowImgVC.h"

@interface TextGeneVC ()

@end

@implementation TextGeneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"Text conversion";
    [self configData];
 
    [self.adapter reloadDataWithCompletion:nil];
}

- (void)configData{
    HomeMainModel *inputMdoel = [[HomeMainModel alloc]init];
    inputMdoel.cellName = NSStringFromClass([TextConInputCell class]);
    inputMdoel.cellHeight = 320;
    SectionSeporModel *sectionM = [[SectionSeporModel alloc]initWithArray:[@[inputMdoel] mutableCopy]];
    self.dataArray = [[NSMutableArray alloc]initWithObjects:sectionM, nil];
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.dataArray;
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    Dx_RubSectionController *dxru = [[Dx_RubSectionController alloc]init];
    dxru.configCellBlocck = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index, MainCollectionViewCell * _Nonnull cell) {
        if([cell isKindOfClass:[TextConInputCell class]]){
            TextConInputCell *textCell = (TextConInputCell  *)
            cell;
            textCell.turnBlock = ^(NSString * _Nonnull text) {
                //跳转到二维码展示页面
                if(text.length >0){
                    QrShowImgVC *qrshow = [[QrShowImgVC alloc]init];
                                  [QRFacManager shareInstance].data = [text dataUsingEncoding:NSUTF8StringEncoding];
                                   [self.navigationController pushViewController:qrshow animated:YES];
                    [[QRFacManager shareInstance] generCreateNum];
                }
                else{
                    UIAlertController *alet = [UIAlertController alertControllerWithTitle:@"Reminder" message:@"Text message cannot be empty" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alet addAction:action];
                    [self presentViewController:alet animated:YES completion:nil];
                    
                }
            };
        }
    };
    dxru.cellDidClickBlock = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index) {
        
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
