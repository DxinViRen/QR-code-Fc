//
//  UIColor+QCategory.h
//  Pods
//
//  Created by ChangTian on 2017/4/13.
//
//

#import <UIKit/UIKit.h>

#define UIColorFromR(R) [UIColor colorWithRed:R / 255.0f green:R / 255.0f blue:R / 255.0f alpha:1.0f]
#define UIColorFromRGB(R, G, B) [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:1.0f]
#define UIColorFromRGBA(R, G, B, A) [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:A]

#define CuteRandomColor UIColorFromRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface UIColor (QCategory)

@property (nonatomic, readonly, assign) CGFloat red, green, blue, alpha;

+ (UIColor *)fromHexValue:(NSUInteger)hex;
+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex;
+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)string;                      // {#RGB|#RRGGBB|0xRRGGBB|0xAARRGGBB}
+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha; // {#RGB|#RRGGBB|0xRRGGBB}

- (BOOL)isEqualToColor:(UIColor *)aColor;

@end
