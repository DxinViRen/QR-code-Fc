//
//  SearchUreVCtopCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/29.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "SearchUreVCtopCell.h"

@interface SearchUreVCtopCell ()
@property (nonatomic,strong)UIView *bgview;
@property (nonatomic,strong)YYLabel *topAdressLabel;
@property (nonatomic,strong)UIButton *makeSureBtn;
@property (nonatomic,strong)UILabel *tLabel;
@end
@implementation SearchUreVCtopCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dx_layoutSubview];
    }
    return self;
}


- (void)dx_layoutSubview{
    [self.contentView addSubview:self.bgview];
    [self.bgview addSubview:self.topAdressLabel];
    [self.contentView addSubview:self.makeSureBtn];
    [self.bgview addSubview:self.tLabel];
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.right.equalTo(self.contentView).inset(10);
        make.height.mas_equalTo(120);
    }];
    
    
    
    [self.topAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgview).inset(10);
        make.left.equalTo(self.bgview).inset(6);
        make.top.equalTo(self.tLabel.mas_bottom).offset(5);
    }];
    
    [self.makeSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview);
        make.top.equalTo(self.bgview.mas_bottom).inset(30);
        make.right.equalTo(self.bgview);
        make.height.mas_equalTo(50);
    }];
    
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.bgview).inset(6);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.bgview).offset(5);
    }];
}

- (void)setModel:(id<MainCellModeProtocol>)model{
    [super setModel:model];
    self.topAdressLabel.text = model.extra[@"link"];
}

- (UIView *)bgview{
    if(!_bgview){
        _bgview = [[UIView alloc]init];
        _bgview.backgroundColor = [UIColor whiteColor];
        _bgview.layer.cornerRadius = 10;
        _bgview.layer.borderWidth = 0.8;
        _bgview.layer.borderColor = MainColor.CGColor;
    }
    return _bgview;
}

- (YYLabel *)topAdressLabel{
    if(!_topAdressLabel){
        _topAdressLabel = [[YYLabel alloc]init];
        _topAdressLabel.textColor = MainColor;
        _topAdressLabel.font = [UIFont systemFontOfSize:13];
        _topAdressLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _topAdressLabel.textAlignment = NSTextAlignmentLeft
        ;
        
    }
    return _topAdressLabel;
}

- (UIButton *)makeSureBtn{
    if(!_makeSureBtn){
        _makeSureBtn  = [[UIButton alloc]init];
        [_makeSureBtn setTitle:@"I have looked" forState:UIControlStateNormal];
        _makeSureBtn.layer.cornerRadius = 5;
        _makeSureBtn.layer.borderWidth = 0.8;
        _makeSureBtn.backgroundColor = [UIColor whiteColor];
        _makeSureBtn.layer.borderColor = MainColor.CGColor;
        [_makeSureBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_makeSureBtn addTarget:self action:@selector(makeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeSureBtn;
}

- (UILabel *)tLabel{
    if(!_tLabel){
     
        _tLabel = [[UILabel alloc]init];
        _tLabel.textAlignment = NSTextAlignmentLeft;
        _tLabel.font = [UIFont systemFontOfSize:15];
        _tLabel.text = @"The data scanned are:";
        _tLabel.textColor = [UIColor whiteColor];
        _tLabel.backgroundColor = MainColor;
    }
    return _tLabel;
}

- (void)makeAction:(UIButton *)sender{
    if(self.visLineBlock){
        self.visLineBlock(@"");
    }
}
@end
