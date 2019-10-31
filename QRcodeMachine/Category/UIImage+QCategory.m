//
//  UIImage+QCategory.m
//  Pods
//
//  Created by ChangTian on 2017/4/25.
//
//

#import "UIImage+QCategory.h"
#import "UIColor+QCategory.h"

@import Photos;


@implementation UIImage (QCategory)

+ (void)saveImage:(UIImage *)image completionHandler:(void (^)(void))completionHandler
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        if (@available(iOS 9.0, *)) {
            NSData *data = UIImageJPEGRepresentation(image, 1);
            PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
            options.shouldMoveFile = YES;
            PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
            [request addResourceWithType:PHAssetResourceTypePhoto data:data options:options];
            request.creationDate = [NSDate date];
        } else {
            PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            request.creationDate = [NSDate date];
        }
    } completionHandler:^(BOOL success, NSError *_Nullable error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (success) {
                completionHandler ? completionHandler() : nil;
            } else {
                if (error) {
                    NSLog(@"保存图片出错: %@", error.localizedDescription);
                }
            }
        });
    }];
}

+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle
{
    UIImage *image = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];

    if (image) {
        return image;
    }

    return [UIImage imageNamed:name];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor
{
    return [UIImage imageWithColor:aColor frame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor frame:(CGRect)aFrame
{
    if ([aColor isEqualToColor:[UIColor clearColor]]) {
        return [[UIImage alloc] init];
    }

    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColors:(NSArray *)colors frame:(CGRect)aFrame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    NSMutableArray *array = [NSMutableArray array];

    for (UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }

    UIGraphicsBeginImageContextWithOptions(aFrame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)array, NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)aColor text:(NSString *)text
{
    CGSize size = CGSizeMake(200, 200);
    CGFloat w = size.width * 2;
    CGFloat h = size.height * 2;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, 1);
    CGContextSetRGBFillColor(context, aColor.red, aColor.green, aColor.blue, aColor.alpha);

    // 绘制圆角矩形
    CGFloat radius = (w / 2 + h / 2) * 0.06;
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    // 绘制第1条线和第1个1/4圆弧，右上圆弧
    CGContextAddLineToPoint(context, w - radius, 0);
    CGContextAddArc(context, w - radius, radius, radius, -0.5 * M_PI, 0, 0);
    // 绘制第2条线和第2个1/4圆弧，右下圆弧
    CGContextAddLineToPoint(context, w, h - radius);
    CGContextAddArc(context, w - radius, h - radius, radius, 0, 0.5 * M_PI, 0);
    // 绘制第3条线和第3个1/4圆弧，左下圆弧
    CGContextAddLineToPoint(context, radius, h);
    CGContextAddArc(context, radius, h - radius, radius, 0.5 * M_PI, M_PI, 0);
    // 绘制第4条线和第4个1/4圆弧，左上圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    // 闭合路径
    CGContextClosePath(context);
    // 绘制填充
    CGContextDrawPath(context, kCGPathFill);

    // 写文字
    UIGraphicsPushContext(context);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont boldSystemFontOfSize:h / 3];
    NSDictionary *attributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : style};
    [text drawInRect:CGRectMake(0, (h - font.pointSize) / 2, w, w) withAttributes:attributes];
    UIGraphicsPopContext();

    CGImageRef cgimg = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    UIImage *img = [UIImage imageWithCGImage:cgimg scale:2.0 orientation:UIImageOrientationDownMirrored];
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)drawArrowImage:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] setFill];
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, size.width, size.height));

    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, (size.width / 2.0f), 0.0f);
    CGPathAddLineToPoint(arrowPath, NULL, size.width, size.height);
    CGPathAddLineToPoint(arrowPath, NULL, 0.0f, size.height);
    CGPathCloseSubpath(arrowPath);
    CGContextAddPath(context, arrowPath);
    CGPathRelease(arrowPath);

    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFill);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)captureScreenshotFromView:(UIView *)view rect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGImageRef imageRef = image.CGImage;
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale));
    UIImage *ansImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);

    return ansImage;
}

+ (void)captureScreenshotFromView:(UIView *)view rect:(CGRect)rect finished:(void (^)(UIImage *))finished
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *ansImage = [UIImage captureScreenshotFromView:view rect:rect];
        dispatch_async(dispatch_get_main_queue(), ^{
            finished(ansImage);
        });
    });
}

+ (UIImage *)createImageWithContent:(NSString *)content logo:(UIImage *)logo
{
    CGSize size = CGSizeMake(200, 200);
    CGSize logoSize = CGSizeMake(40, 40);

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];

    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];

    CIImage *image = [filter outputImage];

    UIGraphicsBeginImageContext(size);

    UIImage *newImage = [UIImage createNonInterpolatedUIImageFormCIImage:image withSize:size];
    [newImage drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage *newlogo = [UIImage generateRoundedCornersWithImage:logo size:logo.size radius:10.0];
    [newlogo drawInRect:CGRectMake((size.width - logoSize.width) / 2, (size.height - logoSize.height) / 2, logoSize.width, logoSize.height)];

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return finalImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.height / CGRectGetHeight(extent));

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

+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius
{
    if (!image) {
        return nil;
    }

    const CGFloat width = size.width;
    const CGFloat height = size.height;

    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];

    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);

    return img;
}

void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    float width = CGRectGetWidth(rect);
    float height = CGRectGetHeight(rect);

    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIGraphicsBeginImageContext(targetSize);

    CGRect scaledRect = CGRectZero;
    scaledRect.origin = CGPointZero;
    scaledRect.size.width = targetSize.width;
    scaledRect.size.height = targetSize.height;
    [self drawInRect:scaledRect];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    if (newImage == nil) {
        NSLog(@"could not scale image");
    }

    return newImage;
}

- (UIImage *)fixOrientation
{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;

        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
