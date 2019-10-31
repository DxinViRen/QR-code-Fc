//
//  Dx_qrNavigetionVC.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/27.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "Dx_qrNavigetionVC.h"

@interface Dx_qrNavigetionVC ()

@end

@implementation Dx_qrNavigetionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar navBarBackGroundColor:[UIColor colorWithHexString:@"#1296db"] image:nil isOpaque:YES];
    [self.navigationBar navBarBottomLineHidden:YES];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 15)];
            [btn setBackgroundImage:[UIImage imageNamed:@"navi_back_btn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = backItem;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)backAction:(UIButton *)btn {
    [self popViewControllerAnimated:YES];
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
