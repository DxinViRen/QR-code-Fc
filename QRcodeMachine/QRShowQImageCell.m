//
//  QRShowQImageCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QRShowQImageCell.h"


@interface QRShowQImageCell ()
@property (nonatomic,strong)UILabel *tLabel;
@property (nonatomic,strong)UIImageView *mainImageview;
@property (nonatomic,strong)UIView *bgView;

@end
@implementation QRShowQImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self
         dx_layoutSubview];
    }
    return self;
}

- (void)dx_layoutSubview{
    [self.contentView addSubview:self. bgView];
    [self.bgView addSubview:self.mainImageview];
    [self.bgView addSubview:self.tLabel];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).inset(40);
        make.left.and.right.and.bottom.equalTo(self.contentView).inset(10);
    }];
    
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mainImageview.mas_top).offset(-20);
        make.left.equalTo(self.bgView).inset(20);
        
    }];
    
    [self.mainImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
}


- (void)setModel:(id<MainCellModeProtocol>)model{
    [super setModel:model];
    self.mainImageview.image = model.extra[@"img"];
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc]init];
        _bgView.layer.borderWidth = 0.8;
        _bgView.layer.borderColor = MainColor.CGColor;
        _bgView.layer.cornerRadius = 10;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}


- (UILabel *)tLabel{
    if(!_tLabel){
        
        _tLabel = [[UILabel alloc]init];
        _tLabel.font = [UIFont systemFontOfSize:15];
        _tLabel.textColor = MainColor;
        _tLabel.text = @"Long press to save QR code to album";
        _tLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tLabel;
}

- (UIImageView *)mainImageview{
    if(!_mainImageview){
        
        _mainImageview = [[UIImageView alloc]init];
        _mainImageview.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *lon = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPreAction:)];
        [_mainImageview addGestureRecognizer:lon];
        _mainImageview.backgroundColor = [UIColor orangeColor];
    }
    return _mainImageview;
}

- (void)longPreAction:(UILongPressGestureRecognizer *)lopre{
    if(self.qrblock){
        self.qrblock();
    }
}
@end
