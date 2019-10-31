//
//  QRFacManager.h
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRFacManager : NSObject
@property(nonatomic,strong)NSData *data;
+ (instancetype)shareInstance;
-(UIImage *)getQrImageWithsize:(CGFloat)size;

//获取当前生成的次数
- (CGFloat)getCurrentGerQrNum;

//管理生成
- (void)generCreateNum;

//管理扫描
- (void)generScaNum;

//获取当前扫描的次数
- (CGFloat)getCurrentScannum;
@end

NS_ASSUME_NONNULL_END
