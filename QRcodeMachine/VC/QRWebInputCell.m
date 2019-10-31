//
//  CollectionViewCell.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QRWebInputCell.h"

@interface QRWebInputCell ()<UITextViewDelegate>
@property (nonatomic,strong)UITextView *textview;
@property (nonatomic,strong)UIButton *createbtn;
@property (nonatomic,strong)UIView *bgview;
@property (nonatomic,strong)YYLabel *placeLabel;
@property (nonatomic,strong)UIView *midView;
@end


@implementation QRWebInputCell
 
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

-(void)dx_layoutSubview{
    [self.contentView addSubview:self.bgview];
    [self.bgview addSubview:self.textview];
    [self.textview addSubview:self.placeLabel];
    [self.contentView addSubview:self.createbtn];
    [self.contentView addSubview:self.midView];
    
    
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.contentView).inset(10);
        make.height.mas_equalTo(150);
    }];
    
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgview).inset(5);
    }];
    
    [self.createbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.bgview);
        make.top.equalTo(self.midView.mas_bottom);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(60);
    }];
    
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textview).inset(5);
        make.top.equalTo(self.textview).inset(5);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.textview);
    }];;
    
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(self.bgview);
        make.top.equalTo(self.bgview.mas_bottom);
        make.bottom.equalTo(self.createbtn.mas_top);
    }];
    
}

- (UIView *)bgview{
    if(!_bgview){
        _bgview = [[UIView alloc]init];
        _bgview.layer.cornerRadius = 10;
        _bgview.layer.borderWidth = 0.8;
        _bgview.layer.borderColor = MainColor.CGColor;
    }
    return _bgview;
}

- (UIButton *)createbtn{
    if(!_createbtn){
        _createbtn = [[UIButton alloc]init];
        [_createbtn setTitleColor:MainColor forState:UIControlStateNormal];
        _createbtn.layer.cornerRadius = 10;
        _createbtn.layer.borderWidth = 0.8;
        _createbtn.layer.borderColor = MainColor.CGColor;
        _createbtn.clipsToBounds = YES;
        [_createbtn setTitle:@"Generate QR code" forState:UIControlStateNormal];
        [_createbtn setTitleColor:MainColor forState:UIControlStateNormal];
        _createbtn.backgroundColor = [UIColor whiteColor];
        _createbtn.layer.borderWidth  = 0.8;
        _createbtn.layer.borderColor = MainColor.CGColor;
        [_createbtn addTarget:self action:@selector(turnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createbtn;
}

- (void)turnAction:(UIButton *)btn{
    if(self.turnBlock){
          self.turnBlock(self.textview.text);
      }
}

- (UITextView *)textview{
    if(!_textview){
     
        _textview = [[UITextView alloc]init];
        _textview.delegate = self;
        _textview.textColor = MainColor;
        
    }
    return _textview;
}

- (YYLabel *)placeLabel{
    if(!_placeLabel){
        _placeLabel = [[YYLabel alloc]init];
        _placeLabel.userInteractionEnabled = YES;
        _placeLabel.text = @"Please enter your web address";
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

- (UIView *)midView
{
    if(!_midView){
        
        _midView  = [[UIView alloc]init];
        
        //横向排列，如果排不开就换行
        CGFloat xInset = 10;
        CGFloat yInset = 8;
        CGFloat xSpace = 10;
        CGFloat ySpace = 8;
        CGFloat countLen = Scr_w - 20;
        CGFloat row = 0;
        CGFloat h = 30;
        NSArray *tiArr = @[@"http://",@"https://",@"www.",@".com",@".cn"];
        CGFloat lenAll = xInset;
        for (int i = 0 ; i < tiArr.count; i++) {
            CGFloat currentW = [self getCurrentItemW:tiArr[i]];
            CGFloat w = currentW;
            CGFloat num = 0;
            CGFloat currLen ;
            if(i == 0){
              currLen = lenAll + currentW;
                num
                = 0;
            }else{
              currLen = lenAll +xSpace + currentW;
                num = 1;
            }
            if(currLen > countLen){
                //换行
                row ++;
                lenAll = xInset;
            }else{
                lenAll = lenAll + num *xSpace;
            }
    
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(lenAll, yInset +row * (h + ySpace), w, h)];
            [btn setTitle:tiArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius = 3;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = MainColor;
            btn.titleLabel.font  = [UIFont systemFontOfSize:12];
            [_midView addSubview:btn];
            
            lenAll += currentW;
        }
        _midView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    }
    return _midView;
}

-(void)btnAction:(UIButton *)btn{
    [self.textview becomeFirstResponder];
    
    NSString *text = [NSString stringWithFormat:@"%@%@",self.textview.text,btn.titleLabel.text];
    self.textview.text = text;
    self.placeLabel.hidden = self.textview.text.length > 0;
    
}
- (CGFloat)getCurrentItemW:(NSString *)str{
     CGFloat le = (str.length + 4)  * 6;
     return le;
}
- (void)textViewDidChange:(UITextView *)textView{
    self.placeLabel.hidden = textView.text.length > 0;
}


@end
