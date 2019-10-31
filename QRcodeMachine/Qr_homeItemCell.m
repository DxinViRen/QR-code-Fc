//
//  Qr_homeItemCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "Qr_homeItemCell.h"

@interface Qr_homeItemCell ()
@property(nonatomic,strong)UIImageView  *historyIcon;
@property(nonatomic,strong)UILabel *historyLabel;
@property(nonatomic,strong)UILabel *happenLabel;
@property(nonatomic,strong)UILabel *numHappenLabel;
@property(nonatomic,strong)UILabel *scanLabel;
@property(nonatomic,strong)UILabel *numScanLabel;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UIImageView *lineImageView;
@end

@implementation Qr_homeItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dx_layoutSubview];
    }
    return self;
}

- (void)dx_layoutSubview{
    [self.bgview addSubview:self.happenLabel];
    [self.bgview addSubview:self.numScanLabel];
    [self.bgview addSubview:self.numHappenLabel];
    [self.bgview addSubview:self.historyIcon];
    [self.bgview addSubview:self.historyLabel];
    [self.bgview addSubview:self.scanLabel];
    [self.bgview addSubview:self.lineImageView];
    [self.contentView addSubview:self.bgview];
     CGFloat space = (Scr_w -280-20)/2.0;
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).inset(15);
    }];
    
    [self.historyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview).inset(space);
        make.top.equalTo(self.bgview).inset(10);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [self.historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.historyIcon);
        make.top.equalTo(self.historyIcon.mas_bottom).offset(6);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgview);
        make.left.equalTo(self.historyIcon.mas_right).offset(10);
        make.width.mas_equalTo(32);
        make.top.equalTo(self.bgview).inset(20);
    }];
    
    
    [self.numHappenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.lineImageView.mas_right).offset(20);
    make.bottom.equalTo(self.happenLabel.mas_top).offset(-15);
        
    }];
    
    
    [self.happenLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineImageView.mas_right).offset(8);
        make.centerY.equalTo(self.historyLabel);
        make.centerX.equalTo(self.numHappenLabel).offset(3);
    }];
    
    [self.numScanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgview).inset(50);
        make.centerY.equalTo(self.numHappenLabel);
    }];
    
    [self.scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.numScanLabel);
        make.centerY.equalTo(self.happenLabel);
    }];
}

- (void)setModel:(id<MainCellModeProtocol>)model{
    [super setModel:model];
    NSString *gnum = model.extra[@"gnum"];
    NSString *snum = model.extra[@"snum"];
    if(!gnum)gnum =@"0";
    if(!snum)snum = @"0";
    self.numHappenLabel.text = gnum;
    self.numScanLabel.text = snum;
}

- (UILabel *)happenLabel{
    if(!_happenLabel){
        
        _happenLabel = [[UILabel alloc]init];
        _happenLabel.textColor = MainColor;
        _happenLabel.text = @"Generated";
        _happenLabel.font = [UIFont systemFontOfSize:13];
        _happenLabel.textAlignment = NSTextAlignmentCenter;
        //_happenLabel.backgroundColor = [UIColor yellowColor];
        [_happenLabel sizeToFit];
    }
    return _happenLabel;
}

- (UILabel *)historyLabel{
    if(!_historyLabel){
        _historyLabel = [[UILabel alloc]init];
        _historyLabel.textColor = MainColor;
        _historyLabel.textAlignment = NSTextAlignmentCenter;
        _historyLabel.font = [UIFont systemFontOfSize:13];
        _historyLabel.text = @"Historical";
        [_historyLabel sizeToFit];
    }
    return _historyLabel;
}

- (UILabel *)scanLabel{
    if(!_scanLabel){
        
        _scanLabel = [[UILabel alloc]init];
        _scanLabel.textColor  =MainColor;
        _scanLabel.textAlignment = NSTextAlignmentCenter;
        _scanLabel.font = [UIFont systemFontOfSize:13];
        _scanLabel.text = @"Scan";
        [_scanLabel sizeToFit];
    }
    return _scanLabel;
}

- (UILabel *)numScanLabel{
    if(!_numScanLabel){
        _numScanLabel = [[UILabel alloc]init];
        _numScanLabel.textColor = MainColor;
        _numScanLabel.text = @"0";
        //_numScanLabel.backgroundColor = [UIColor redColor];
        _numScanLabel.font = [UIFont systemFontOfSize:15];
        [_numScanLabel sizeToFit];
    }
    return _numScanLabel;
}

- (UIImageView *)historyIcon{
    if(!_historyIcon){
        _historyIcon = [[UIImageView alloc]init];
        _historyIcon.image = [UIImage imageNamed:@"qr_home_history"];
    }
    return _historyIcon;
}

- (UILabel *)numHappenLabel{
    if(!_numHappenLabel){
        _numHappenLabel = [[UILabel alloc]init];
        _numHappenLabel.textColor = MainColor;
        _numHappenLabel.font = [UIFont systemFontOfSize:15];
        _numHappenLabel.textAlignment = NSTextAlignmentCenter;
        _numHappenLabel.text = @"0";
       // _numHappenLabel.backgroundColor = [UIColor redColor];
        [_numHappenLabel sizeToFit];
    }
    return _numHappenLabel;
}

- (UIView *)bgview{
    if(!_bgview){
        
        _bgview = [[UIView alloc]init];
        _bgview.backgroundColor = [UIColor whiteColor];
        _bgview.layer.cornerRadius = 10;
        _bgview.layer.borderColor = MainColor.CGColor;
        _bgview.layer.borderWidth = 0.8;
    }
    return _bgview;
}


- (UIImageView *)lineImageView{
    if(!_lineImageView){
        _lineImageView = [[UIImageView alloc]init];
       // _lineImageView.backgroundColor =[UIColor redColor];
        _lineImageView.image = [UIImage imageNamed:@"qr_home_xuxina"];
    }
    return _lineImageView;
}
@end
