//
//  UIColor+QCategory.m
//  Pods
//
//  Created by ChangTian on 2017/4/13.
//
//

#import "UIColor+QCategory.h"


@implementation UIColor (QCategory)

- (CGFloat)red
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return red;
}

- (CGFloat)green
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return green;
}

- (CGFloat)blue
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return blue;
}

- (CGFloat)alpha
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return alpha;
}

+ (UIColor *)fromHexValue:(NSUInteger)hex
{
    NSUInteger a = ((hex >> 24) & 0x000000FF);
    float fa = ((0 == a) ? 0.0f : (a * 1.0f) / 255.0f);

    return [UIColor fromHexValue:hex alpha:fa];
}

+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger r = ((hex >> 16) & 0x000000FF);
    NSUInteger g = ((hex >> 8) & 0x000000FF);
    NSUInteger b = ((hex >> 0) & 0x000000FF);

    float fr = (r * 1.0f) / 255.0f;
    float fg = (g * 1.0f) / 255.0f;
    float fb = (b * 1.0f) / 255.0f;

    if (alpha == 0) {
        return [UIColor clearColor];
    }

    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex
{
    return [UIColor fromShortHexValue:hex alpha:1.0f];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger r = ((hex >> 8) & 0x0000000F);
    NSUInteger g = ((hex >> 4) & 0x0000000F);
    NSUInteger b = ((hex >> 0) & 0x0000000F);

    float fr = (r * 1.0f) / 15.0f;
    float fg = (g * 1.0f) / 15.0f;
    float fb = (b * 1.0f) / 15.0f;

    if (alpha == 0) {
        return [UIColor clearColor];
    }

    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
        NSString *string = [hexString substringFromIndex:2];
        if (string.length == 8) { // 0xAARRGGBB
            // 32位字长的机器（比如iphone5)，strtol会溢出，故用strtoll
            NSUInteger hexRGB = strtoll(string.UTF8String, nil, 16);
            return [UIColor fromHexValue:hexRGB];
        }
    }

    return [self colorWithHexString:hexString alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];

        if (hexString.length == 3) { // #RGB
            NSUInteger hexRGB = strtol(hexString.UTF8String, nil, 16);
            return [UIColor fromShortHexValue:hexRGB alpha:alpha];
        }

        if (hexString.length == 6) { // #RRGGBB
            NSUInteger hexRGB = strtol(hexString.UTF8String, nil, 16);
            return [UIColor fromHexValue:hexRGB alpha:alpha];
        }
    }

    if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
        hexString = [hexString substringFromIndex:2];

        if (hexString.length == 6) { //0xRRGGBB
            NSUInteger hexRGB = strtol(hexString.UTF8String, nil, 16);
            return [UIColor fromHexValue:hexRGB alpha:alpha];
        }
    }

    return nil;
}

- (BOOL)isEqualToColor:(UIColor *)aColor
{
    return CGColorEqualToColor(self.CGColor, aColor.CGColor);
}

@end
