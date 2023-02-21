//
//  UIView+WKUI.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/8.
//


#import "UIColor+wkui.h" 
#import "WKUICommonDefine.h"
#import "NSString+WKUI.h"
#import "NSArray+Safe.h"

@implementation UIColor (WKUI)

 
+ (UIColor *)wkui_colorWithHexString:(NSString *)hexString {
    if (hexString.length <= 0) return nil;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default: {
           
            return nil;
        }
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (NSString *)wkui_hexString {
    NSInteger alpha = self.wkui_alpha * 255;
    NSInteger red = self.wkui_red * 255;
    NSInteger green = self.wkui_green * 255;
    NSInteger blue = self.wkui_blue * 255;
    return [[NSString stringWithFormat:@"#%@%@%@%@",
            [self alignColorHexStringLength:[NSString wkui_hexStringWithInteger:alpha]],
            [self alignColorHexStringLength:[NSString wkui_hexStringWithInteger:red]],
            [self alignColorHexStringLength:[NSString wkui_hexStringWithInteger:green]],
            [self alignColorHexStringLength:[NSString wkui_hexStringWithInteger:blue]]] lowercaseString];
}

+ (UIColor *)wkui_colorWithRGBAString:(NSString *)rgbaString {
    NSArray<NSString *> *arr = nil;
    NSCharacterSet *characterSet = nil;
    if ([rgbaString containsString:@","]) {
        characterSet = [NSCharacterSet characterSetWithCharactersInString:@","];
    } else {
        characterSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
    }
    arr = [rgbaString componentsSeparatedByCharactersInSet:characterSet];
    if (arr.count < 3 || arr.count > 4) return nil;
    return kRGBA(arr[0].integerValue, arr[1].integerValue, arr[2].integerValue, (arr.count == 4 ? arr[3].floatValue : 1.0));
    
}

- (NSString *)wkui_RGBAString {
    return [NSString stringWithFormat:@"%.0f,%.0f,%.0f,%.2f",
            round(self.wkui_red * 255),
            round(self.wkui_green * 255),
            round(self.wkui_blue * 255),
            self.wkui_alpha];
}

// 对于色值只有单位数的，在前面补一个0，例如“F”会补齐为“0F”
- (NSString *)alignColorHexStringLength:(NSString *)hexString {
    return hexString.length < 2 ? [@"0" stringByAppendingString:hexString] : hexString;
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (CGFloat)wkui_red {
    CGFloat r;
    if ([self getRed:&r green:0 blue:0 alpha:0]) {
        return r;
    }
    return 0;
}

- (CGFloat)wkui_green {
    CGFloat g;
    if ([self getRed:0 green:&g blue:0 alpha:0]) {
        return g;
    }
    return 0;
}

- (CGFloat)wkui_blue {
    CGFloat b;
    if ([self getRed:0 green:0 blue:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (CGFloat)wkui_alpha {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0;
}

- (CGFloat)wkui_hue {
    CGFloat h;
    if ([self getHue:&h saturation:0 brightness:0 alpha:0]) {
        return h;
    }
    return 0;
}

- (CGFloat)wkui_saturation {
    CGFloat s;
    if ([self getHue:0 saturation:&s brightness:0 alpha:0]) {
        return s;
    }
    return 0;
}

- (CGFloat)wkui_brightness {
    CGFloat b;
    if ([self getHue:0 saturation:0 brightness:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (UIColor *)wkui_colorWithoutAlpha {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    if ([self getRed:&r green:&g blue:&b alpha:0]) {
        return [UIColor colorWithRed:r green:g blue:b alpha:1];
    } else {
        return nil;
    }
}

- (UIColor *)wkui_colorWithAlpha:(CGFloat)alpha backgroundColor:(UIColor *)backgroundColor {
    return [UIColor wkui_colorWithBackendColor:backgroundColor frontColor:[self colorWithAlphaComponent:alpha]];
    
}

- (UIColor *)wkui_colorWithAlphaAddedToWhite:(CGFloat)alpha {
    return [self wkui_colorWithAlpha:alpha backgroundColor:UIColor.whiteColor];
}

- (UIColor *)wkui_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress {
    return [UIColor wkui_colorFromColor:self toColor:toColor progress:progress];
}

- (BOOL)wkui_colorIsDark {
    CGFloat red = 0.0, green = 0.0, blue = 0.0;
    if ([self getRed:&red green:&green blue:&blue alpha:0]) {
        float referenceValue = 0.411;
        float colorDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
        
        return 1.0 - colorDelta > referenceValue;
    }
    return YES;
}

- (UIColor *)wkui_inverseColor {
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
    return newColor;
}

- (BOOL)wkui_isSystemTintColor {
    return [self isEqual:[UIColor wkui_systemTintColor]];
}

- (CGFloat)wkui_distanceBetweenColor:(UIColor *)color {
    if (!color) return CGFLOAT_MAX;
    
    UIColor *color1 = self;
    UIColor *color2 = color;
    CGFloat R = 100.0;
    CGFloat angle = 30.0;
    CGFloat h = R * cos(angle / 180 * M_PI);
    CGFloat r = R * sin(angle / 180 * M_PI);
    
    CGFloat hue1 = color1.wkui_hue * 360;
    CGFloat saturation1 = color1.wkui_saturation;
    CGFloat brightness1 = color1.wkui_brightness;
    CGFloat hue2 = color2.wkui_hue * 360;
    CGFloat saturation2 = color2.wkui_saturation;
    CGFloat brightness2 = color2.wkui_brightness;
    
    CGFloat x1 = r * brightness1 * saturation1 * cos(hue1 / 180 * M_PI);
    CGFloat y1 = r * brightness1 * saturation1 * sin(hue1 / 180 * M_PI);
    CGFloat z1 = h * (1 - brightness1);
    CGFloat x2 = r * brightness2 * saturation2 * cos(hue2 / 180 * M_PI);
    CGFloat y2 = r * brightness2 * saturation2 * sin(hue2 / 180 * M_PI);
    CGFloat z2 = h * (1 - brightness2);
    CGFloat dx = x1 - x2;
    CGFloat dy = y1 - y2;
    CGFloat dz = z1 - z2;
    return sqrt(dx * dx + dy * dy + dz * dz);
}

+ (UIColor *)wkui_systemTintColor {
    static UIColor *systemTintColor = nil;
    if (!systemTintColor) {
        UIView *view = [[UIView alloc] init];
        systemTintColor = view.tintColor;
    }
    return systemTintColor;
}

+ (UIColor *)wkui_colorWithBackendColor:(UIColor *)backendColor frontColor:(UIColor *)frontColor {
    CGFloat bgAlpha = [backendColor wkui_alpha];
    CGFloat bgRed = [backendColor wkui_red];
    CGFloat bgGreen = [backendColor wkui_green];
    CGFloat bgBlue = [backendColor wkui_blue];
    
    CGFloat frAlpha = [frontColor wkui_alpha];
    CGFloat frRed = [frontColor wkui_red];
    CGFloat frGreen = [frontColor wkui_green];
    CGFloat frBlue = [frontColor wkui_blue];
    
    CGFloat resultAlpha = frAlpha + bgAlpha * (1 - frAlpha);
    CGFloat resultRed = (frRed * frAlpha + bgRed * bgAlpha * (1 - frAlpha)) / resultAlpha;
    CGFloat resultGreen = (frGreen * frAlpha + bgGreen * bgAlpha * (1 - frAlpha)) / resultAlpha;
    CGFloat resultBlue = (frBlue * frAlpha + bgBlue * bgAlpha * (1 - frAlpha)) / resultAlpha;
    return [UIColor colorWithRed:resultRed green:resultGreen blue:resultBlue alpha:resultAlpha];
}

+ (UIColor *)wkui_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    progress = MIN(progress, 1.0f);
    CGFloat fromRed = fromColor.wkui_red;
    CGFloat fromGreen = fromColor.wkui_green;
    CGFloat fromBlue = fromColor.wkui_blue;
    CGFloat fromAlpha = fromColor.wkui_alpha;
    
    CGFloat toRed = toColor.wkui_red;
    CGFloat toGreen = toColor.wkui_green;
    CGFloat toBlue = toColor.wkui_blue;
    CGFloat toAlpha = toColor.wkui_alpha;
    
    CGFloat finalRed = fromRed + (toRed - fromRed) * progress;
    CGFloat finalGreen = fromGreen + (toGreen - fromGreen) * progress;
    CGFloat finalBlue = fromBlue + (toBlue - fromBlue) * progress;
    CGFloat finalAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    
    return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:finalAlpha];
}

+ (UIColor *)wkui_randomColor {
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end

 
