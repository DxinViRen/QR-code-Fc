//
//  UIImage+QCategory.h
//  Pods
//
//  Created by ChangTian on 2017/4/25.
//
//

#import <UIKit/UIKit.h>


@interface UIImage (QCategory)

+ (void)saveImage:(UIImage *)image completionHandler:(void (^)(void))completionHandler;

+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;

+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor frame:(CGRect)aFrame;
+ (UIImage *)imageWithColors:(NSArray *)colors frame:(CGRect)aFrame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
+ (UIImage *)imageWithColor:(UIColor *)aColor text:(NSString *)text;

+ (UIImage *)drawArrowImage:(CGSize)size color:(UIColor *)color;

+ (UIImage *)captureScreenshotFromView:(UIView *)view rect:(CGRect)rect;
+ (void)captureScreenshotFromView:(UIView *)view rect:(CGRect)rect finished:(void (^)(UIImage *image))finished;

+ (UIImage *)createImageWithContent:(NSString *)content logo:(UIImage *)logo;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)fixOrientation;

@end
