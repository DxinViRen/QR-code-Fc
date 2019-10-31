//
//  QRHomeOpItemView.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QRHomeOpItemView.h"

@interface QRHomeOpItemView ()

@end

@implementation QRHomeOpItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImgview];
        [self addSubview:self.title];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCtoon:)];
        [self addGestureRecognizer:tap];
        [self dx_layoutSubview];
    }
    return self;
}

- (void)tapCtoon:(UITapGestureRecognizer *)tap{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tapItem" object:nil userInfo:@{@"view":self}];
}




- (void)dx_layoutSubview{
    [self.iconImgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.top.equalTo(self).inset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self.title.mas_top).offset(-3);
        
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self);
        make.top.equalTo(self.iconImgview.mas_bottom).offset(3);
    }];
}


- (UIImageView *)iconImgview{
    if(!_iconImgview){
        
        _iconImgview = [[UIImageView alloc]init];
        _iconImgview.contentMode  =
        UIViewContentModeScaleAspectFit;
        _iconImgview.userInteractionEnabled = YES;
    }
    return _iconImgview;
}

- (UILabel *)title{
    if(!_title){
        _title = [[UILabel alloc]init];
        _title.font  = [UIFont systemFontOfSize:15];
        _title.textColor = MainColor;
        _title.userInteractionEnabled = YES;
        _title.textAlignment = NSTextAlignmentCenter;
        [_title sizeToFit];
    }
    return _title;
}


@end
