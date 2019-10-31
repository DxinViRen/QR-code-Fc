//
//  QRHometopCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QRHometopCell.h"

@interface QRHometopCell ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titLabel;
@end


@implementation QRHometopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dx_layoutSubview];
    }
    return self;
}

- (void)dx_layoutSubview{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titLabel];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).inset(10);
        make.top.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
        
    }];
}

- (UIView *)bgView{
    if(!_bgView){
        
        _bgView = [[UIView alloc]init];
        _bgView.layer.borderColor = MainColor.CGColor;
        _bgView.backgroundColor = MainColor;
        _bgView.layer.borderWidth = 0.8;
    }
    return _bgView;
}

- (UILabel *)titLabel{
    if(!_titLabel){
        _titLabel  = [[UILabel alloc]init];
        _titLabel.textColor = [UIColor whiteColor];
        _titLabel.font = [UIFont systemFontOfSize:20];
        _titLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titLabel.numberOfLines =  0;
        _titLabel.textAlignment = NSTextAlignmentLeft;
        _titLabel.text = @"Select a data generation QR code";
        [_titLabel sizeToFit];
    }
    return _titLabel;
}
@end
