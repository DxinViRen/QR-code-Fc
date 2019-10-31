//
//  hoemMainOptionCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "HoemMainOptionCell.h"
#import "QRHomeOpItemView.h"
@interface HoemMainOptionCell ()
@property (nonatomic,strong)UIView *bgview;

@property (nonatomic,strong)UIView *hlineView;
@property (nonatomic,strong)UIView *vlineView;


@end


@implementation HoemMainOptionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgview.backgroundColor = [UIColor whiteColor];
        [self dx_layoutSubView];
    
    }
    return self;
}

- (void)dx_layoutSubView{
    
    [self.contentView addSubview:self.bgview];
    [self.bgview addSubview:self.hlineView];
    [self.bgview addSubview:self.vlineView];
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).inset(15);
    }];
    
    [self.vlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgview);
       
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.width.mas_equalTo(0.8);
    }];
    
    [self.hlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgview);
        make.centerY.equalTo(self.bgview).offset(-6);
        //make.left.equalTo(self.bgview).inset(40);
         make.size.mas_equalTo(CGSizeMake(140, 100));
       // make.right.equalTo(self.bgview).inset(30);
        make.height.mas_equalTo(0.8);
    }];
    CGFloat w = 80;
    CGFloat y = 80;
    NSArray *imgArr = @[@"qr_home_text48",@"qr_home_netad",@"qr_home_mingpianItem",@"qr_new_home_pic"];
    NSArray *titlArr = @[@"Text",@"Website",@"nameC",@"picture"];
    CGFloat space = (Scr_w -280-20)/2.0;
    for (int i = 0; i <imgArr.count; i ++) {
        CGFloat row = i/2;
        CGFloat cl  = i%2;\
        QRHomeOpItemView *itemView = [[QRHomeOpItemView alloc]init];
        itemView.layer.borderWidth = 0.8;
        itemView.layer.borderColor = MainColor.CGColor;
        itemView.layer.cornerRadius = 5;
        itemView.iconImgview.image = [UIImage imageNamed:imgArr[i]];
        itemView.tag = (i + 1) * 100;
        itemView.title.text =titlArr[i];
        itemView.frame = CGRectMake(space + cl *(w + 120),20 + row * (y + 20), w, y);
        [self.bgview addSubview:itemView];
    }
}

- (UIView *)bgview{
    if(!_bgview){
        
        _bgview= [[UIView alloc]init];
        _bgview.layer.cornerRadius = 10;
        _bgview.layer.borderWidth = 0.8;
        _bgview.layer.borderColor = MainColor.CGColor;
    }
    return _bgview;
}

- (UIView *)hlineView{
    if(!_hlineView){
        
        _hlineView = [[UIView alloc]init];
        _hlineView.backgroundColor  =MainColor;
    }
    return _hlineView;
}

- (UIView *)vlineView{
    if(!_vlineView){
        
        _vlineView = [[UIView alloc]init];
        _vlineView.backgroundColor = MainColor;
    }
    return _vlineView;
}
@end

