//
//  QRFacManager.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/28.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "QRFacManager.h"
#import <CoreImage/CoreImage.h>
@implementation QRFacManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
+ (instancetype)shareInstance{
    static QRFacManager *_qrManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _qrManager = [QRFacManager allocWithZone:NULL];
    });
    return _qrManager;
}

-(UIImage *)getQrImageWithsize:(CGFloat)size{
   return  [self createNonInterpolatedUIImageFormCIImage:[self getCiImageWithdata:self.data] withSize:size];
}
- (CIImage *)getCiImageWithdata:(NSData *)data{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            
           // 2.过滤器恢复默认设置
    [filter setDefaults];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
           
          // 4.获取输出的二维码
     CIImage *outputImage = [filter outputImage];
    
    return outputImage;
}

/** 根据CIImage生成指定大小的UIImage */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
     
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
     
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//获取当前生成的次数
- (CGFloat)getCurrentGerQrNum
{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"create"]){
        return 0;
    }
    else{
        CGFloat num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"create"] floatValue];
        return num;
    }
}
//管理生成
- (void)generCreateNum{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"create"]){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"create"];
    }
    else{
        CGFloat num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"create"] floatValue];
        num ++;
        [[NSUserDefaults standardUserDefaults]setObject: [NSString stringWithFormat:@"%f",num] forKey:@"create"];
    }
}

//管理扫描
- (void)generScaNum{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"scanNum"]){
           [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"scanNum"];
       }
       else{
           CGFloat num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"scanNum"] floatValue];
           num ++;
           [[NSUserDefaults standardUserDefaults]setObject: [NSString stringWithFormat:@"%f",num] forKey:@"scanNum"];
       }
}

//获取当前扫描的次数
- (CGFloat)getCurrentScannum{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"scanNum"]){
        return 0;
    }
    else{
        CGFloat num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"scanNum"] floatValue];
        return num;
    }
}





@end
