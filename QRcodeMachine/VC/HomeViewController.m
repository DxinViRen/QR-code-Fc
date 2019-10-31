//
//  HomeViewController.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/27.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeOptionCell.h"
#import "HoemMainOptionCell.h"
#import "Qr_homeItemCell.h"
#import "QRHometopCell.h"
#import "QRScanViewController.h"
#import "TextGeneVC.h"
#import "QRWebAdressViewController.h"
#import "QrNameViewController.h"
#import "QrShowImgVC.h"
@interface HomeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end 

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title  =  @"QR code factory";
    
    UIButton *bnn = [[UIButton alloc]init];
    bnn.frame = CGRectMake(0, 0, 32, 32);
    [bnn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [bnn setImage:[UIImage imageNamed:@"qr_home_saomiaoicon32"] forState:UIControlStateNormal];
  
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:bnn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self configData];
    [self.adapter reloadDataWithCompletion:nil];
    
    // [[NSNotificationCenter defaultCenter]postNotificationName:@"tapItem" object:nil userInfo:@{@"view":self}];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(itemAction:) name:@"tapItem" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.dataArray.count >0){
       SectionSeporModel *secMo = self.dataArray[0];
        HomeMainModel *iMo = secMo.dataArray.lastObject;
        iMo.extra = [@{@"gnum":[NSString stringWithFormat:@"%.f",[[QRFacManager shareInstance] getCurrentGerQrNum]],@"snum":[NSString stringWithFormat:@"%.f",[[QRFacManager shareInstance] getCurrentScannum]]} mutableCopy];
        [self.adapter reloadDataWithCompletion:nil];
    }
}


- (void)itemAction:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    UIView *view = dic[@"view"];
    switch (view.tag) {
        case 100:
        {
            //普通文本转换
            TextGeneVC *tg = [[TextGeneVC alloc]init];
            [self.navigationController pushViewController:tg animated:YES];
        }
            break;
        case 200:
        {
            //网址转换
            QRWebAdressViewController *web = [[QRWebAdressViewController alloc]init];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
            
        case 300:
        {
            //名片转换
            QrNameViewController *qrnam = [[QrNameViewController alloc]init];
            [self.navigationController pushViewController:qrnam animated:YES];
        }
            break;
       
        case 400:
        {
            //图片转换
            [self showActionSheet];
            
        }
        break;
            
        default:
            break;
    }
}
- (void)scanAction:(UIButton*)sender{
    QRScanViewController *qrs = [[QRScanViewController alloc]init];
    [self.navigationController pushViewController:qrs animated:YES];
}

- (void)configData{
    HomeMainModel *modle = [[HomeMainModel alloc]init];
    modle.cellHeight = 260;
    modle.cellName = NSStringFromClass([HoemMainOptionCell class]);
    
     
    HomeMainModel *iteModle = [[HomeMainModel alloc]init];
    iteModle.cellHeight = 110;
    iteModle.cellName = NSStringFromClass([Qr_homeItemCell class]);
    
        
    HomeMainModel *topModle = [[HomeMainModel alloc]init];
       topModle.cellHeight = 60;
       topModle.cellName = NSStringFromClass([QRHometopCell class]);
       
           
    
    SectionSeporModel *secmodeld = [[SectionSeporModel alloc]initWithArray:[@[topModle,modle,iteModle] mutableCopy]];
    self.dataArray = [[NSMutableArray alloc]initWithObjects:secmodeld, nil];
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.dataArray;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    Dx_RubSectionController *dxse  =[[Dx_RubSectionController alloc]init];
    dxse.cellDidClickBlock = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index) {
        
    };
    dxse.configCellBlocck = ^(id<MainCellModeProtocol>  _Nonnull model, NSInteger index, MainCollectionViewCell * _Nonnull cell) {
        
    };
    return dxse;
}

-(void)showActionSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            //            mAlertView(@"", @"请在'设置'中打开相机权限")
            return;
        }
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //            mAlertView(@"", @"照相机不可用")
            return;
        }
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
     [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
     UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
       // [self.senderBtn setBackgroundImage:image forState:UIControlStateNormal];
        //图片在这里压缩一下
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    [picker dismissViewControllerAnimated:YES completion:^{
        QrShowImgVC *qrshow = [[QrShowImgVC alloc]init];
        [QRFacManager shareInstance].data = [encodedImageStr dataUsingEncoding:NSUTF8StringEncoding];
        [self.navigationController pushViewController:qrshow animated:YES];
        [[QRFacManager shareInstance] generCreateNum];
    }];
}



@end
