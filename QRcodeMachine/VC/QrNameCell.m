//
//  QrNameCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QrNameCell.h"

@interface QrNameCell ()<UITextFieldDelegate>
@property (nonatomic,strong)UILabel *tiLAbel;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *bgview;
@property (nonatomic,strong)UITextField *maintextfiled;
@end

@implementation QrNameCell

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
   // self.contentView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.tiLAbel];
    [self.contentView addSubview:self.maintextfiled];
    
    [self.tiLAbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).inset(5);
        make.width.mas_equalTo(80);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView).inset(5);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.8);
    }];
    
    [self.maintextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.tiLAbel.mas_right).offset(10);
        make.top.equalTo(self.contentView).inset(10);
        make.right.equalTo(self.contentView).inset(20);
    }];
    
}

- (void)setModel:(id<MainCellModeProtocol>)model{
    [super setModel:model];
    self.tiLAbel.text = model.extra[@"title"];
    self.maintextfiled.placeholder = model.extra[@"plc"];
}
- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"dbdbdb"];
    }
    return _lineView;
}

- (UILabel *)tiLAbel{
    if(!_tiLAbel){
        _tiLAbel = [[UILabel alloc]init];
        //_tiLAbel.backgroundColor = [UIColor redColor];
        _tiLAbel.font = [UIFont systemFontOfSize:15];
        _tiLAbel.textColor = MainColor;
        _tiLAbel.textAlignment = NSTextAlignmentLeft;
        [_tiLAbel sizeToFit];
    }
    return _tiLAbel;
}

- (UITextField *)maintextfiled{
    if(!_maintextfiled){
        _maintextfiled = [[UITextField alloc]init];
        _maintextfiled.delegate = self;
        [_maintextfiled addTarget:self  action:@selector(textInpuActio:) forControlEvents:UIControlEventEditingChanged];
        _maintextfiled.font = [UIFont systemFontOfSize:15];
        _maintextfiled.textAlignment = NSTextAlignmentLeft;
    }
    return _maintextfiled;
}

- (void)textInpuActio:(UITextField *)tf{
    
    [self.model.extra setObject:tf.text forKey:@"text"];
}
@end
