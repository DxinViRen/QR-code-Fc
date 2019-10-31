//
//  QrShowImgVC.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QrShowImgVC.h"
#import "QRShowQImageCell.h"
@interface QrShowImgVC ()

@end

@implementation QrShowImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self configData];
    self.navigationItem.title  = @"Your QR code";
    [self.adapter reloadDataWithCompletion:nil];
}

- (void)configData{
    HomeMainModel *imgeModel = [[HomeMainModel alloc]init];
    //[QRFacManager shareInstance].data = self.data;
    imgeModel.cellName = NSStringFromClass([QRShowQImageCell class]);
    
    UIImage *image = [[QRFacManager shareInstance]getQrImageWithsize:150];
    if(image == nil){
        [QRFacManager shareInstance].data = [@"有bug,但是没时间了" dataUsingEncoding:NSUTF8StringEncoding];
        
    }
    imgeModel.extra = [@{@"img":[[QRFacManager shareInstance]getQrImageWithsize:150]} mutableCopy];
    imgeModel.cellHeight = 400;
    
    SectionSeporModel *secmodel = [[SectionSeporModel alloc]initWithArray: [@[imgeModel] mutableCopy]];
    
    self.dataArray = [[NSMutableArray alloc]initWithObjects:secmodel, nil];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    Dx_RubSectionController *dxrub = [[Dx_RubSectionController alloc]init];
    
    dxrub.cellDidClickBlock = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index) {
        
    };
    
    dxrub.configCellBlocck = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index, MainCollectionViewCell * _Nonnull cell) {
        if([cell isKindOfClass:[QRShowQImageCell class]]){
            QRShowQImageCell *qcell = (QRShowQImageCell *)cell;
            qcell.qrblock = ^{
                [self loadImageFinished:model.extra[@"img"]];
            };
           
        }
    };
    
    return dxrub;
}


- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
 
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error == nil){
        UIAlertController *alet = [UIAlertController alertControllerWithTitle:@"Reminder" message:@"Save successfully" preferredStyle:UIAlertControllerStyleAlert];
                           UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                           }];
                           [alet addAction:action];
                           [self presentViewController:alet animated:YES completion:nil];
    }else{
        
        UIAlertController *alet = [UIAlertController alertControllerWithTitle:@"Reminder" message:@"Save field" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alet addAction:action];
        [self presentViewController:alet animated:YES completion:nil];
        
    }
}
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.dataArray;
}





@end
