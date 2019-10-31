//
//  TextConInputCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "TextConInputCell.h"

@interface TextConInputCell ()<UITextViewDelegate>
@property (nonatomic,strong)UITextView *textview;
@property (nonatomic,strong)UIButton *turnBtn;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *inputView;
@property (nonatomic,strong)YYLabel *placeLabel;
@property (nonatomic,strong)UIView *qrImageView;
@end



@implementation TextConInputCell

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
    [self.bgView addSubview:self.textview];
    [self.contentView addSubview:self.turnBtn];
   // self.contentView.backgroundColor = [UIColor redColor];
    [self.textview addSubview:self.placeLabel];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.contentView).inset(10);
        make.height.mas_equalTo(200);
    }];
    
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView).inset(5);
    }];
    
    [self.turnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView.mas_bottom).offset(40);
        make.bottom.equalTo(self.contentView).inset(10);
    }];
    
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textview).inset(5);
        make.top.equalTo(self.textview).inset(5);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.textview);
    }];;
    
    // [self.textview becomeFirstResponder];
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderColor = MainColor.CGColor;
        _bgView.layer.borderWidth = 0.8;
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}

- (UIButton *)turnBtn{
    if(!_turnBtn){
        _turnBtn = [[UIButton alloc]init];
        [_turnBtn setTitleColor:MainColor forState:UIControlStateNormal];
        _turnBtn.layer.cornerRadius = 10;
        _turnBtn.layer.borderWidth = 0.8;
        _turnBtn.layer.borderColor = MainColor.CGColor;
        _turnBtn.clipsToBounds = YES;
        [_turnBtn setTitle:@"Generate QR code" forState:UIControlStateNormal];
        [_turnBtn setTitleColor:MainColor forState:UIControlStateNormal];
        _turnBtn.backgroundColor = [UIColor whiteColor];
        _turnBtn.layer.borderWidth  = 0.8;
        _turnBtn.layer.borderColor = MainColor.CGColor;
        [_turnBtn addTarget:self action:@selector(turnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnBtn;
}

- (UIView *)qrImageView{
    if(!_qrImageView){
        _qrImageView = [[UIView alloc]init];
        
        _qrImageView.backgroundColor = [UIColor whiteColor];
        _qrImageView.layer.cornerRadius = 10;
        _qrImageView.layer.borderWidth = 0.8;
    }
    return _qrImageView;
}

- (UITextView *)textview{
    if(!_textview){
     
        _textview = [[UITextView alloc]init];
        _textview.delegate = self;
        _textview.textColor = MainColor;
        
    }
    return _textview;
}

- (void)turnAction:(UIButton *)btn{
   
    if(self.turnBlock){
        self.turnBlock(self.textview.text);
    }
}

- (YYLabel *)placeLabel{
    if(!_placeLabel){
        _placeLabel = [[YYLabel alloc]init];
        _placeLabel.userInteractionEnabled = YES;
        _placeLabel.text = @"Please enter the text";
        _placeLabel.font = [UIFont systemFontOfSize:15];
        _placeLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
       // _placeLabel.backgroundColor = [UIColor redColor];
        _placeLabel.numberOfLines = 0;
        _placeLabel.lineBreakMode = NSLineBreakByCharWrapping;
      
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
        [_placeLabel sizeToFit];
    }
    return _placeLabel;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.placeLabel.hidden = textView.text.length > 0;
}

@end
