//
//  QrNameBtnCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QrNameBtnCell.h"

@interface QrNameBtnCell ()
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIView *bgView;
@end
@implementation QrNameBtnCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dx_layoutSubview];
       // self.contentView.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)dx_layoutSubview{
    [self.contentView addSubview:self.btn];
    [self.contentView addSubview:self.bgView];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).inset(20);
    }];
}

- (UIButton *)btn{
    if(!_btn){
        
        _btn  = [[UIButton alloc]init];
        [_btn setTitle:@"Generate QR code" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.cornerRadius = 10;
        _btn.layer.borderColor = MainColor.CGColor;
        _btn.layer.borderWidth = 0.8;
        _btn.backgroundColor = [UIColor whiteColor];
        [_btn setTitleColor:MainColor forState:UIControlStateNormal];
    }
    return _btn;
}

- (void)btnAction:(UIButton *)btn{
    if(self.turnBlock){
        self.turnBlock();
    }
}
@end
