//
//  UIImage+WKUI.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/12.
//

#import "UIImage+WKUI.h"
#import "WKUICommonDefine.h"

@implementation UIImage (WKUI)

- (BOOL)wkui_opaque {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone;
    return opaque;
}
- (CGSize)wkui_sizeInPixel {
    CGSize size = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    return size;
}
+ (UIImage *)wkui_imageWithColor:(UIColor *)color {
    return [self wkui_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)wkui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock {
    if (!actionBlock || CGSizeIsEmpty(size)) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    actionBlock(context);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}


+ (UIImage *)wkui_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIColor *)wkui_averageColor {
    unsigned char rgba[4] = {};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    if(rgba[3] > 0) {
        return [UIColor colorWithRed:((CGFloat)rgba[0] / rgba[3])
                               green:((CGFloat)rgba[1] / rgba[3])
                                blue:((CGFloat)rgba[2] / rgba[3])
                               alpha:((CGFloat)rgba[3] / 255.0)];
    } else {
        return [UIColor colorWithRed:((CGFloat)rgba[0]) / 255.0
                               green:((CGFloat)rgba[1]) / 255.0
                                blue:((CGFloat)rgba[2]) / 255.0
                               alpha:((CGFloat)rgba[3]) / 255.0];
    }
}

- (UIImage *)wkui_grayImage {
    // CGBitmapContextCreate 是无倍数的，所以要自己换算成1倍
    CGSize size = self.wkui_sizeInPixel;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault); 
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGRect imageRect = CGRectMakeWithSize(size);
    CGContextDrawImage(context, imageRect, self.CGImage);
    
    UIImage *grayImage = nil;
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    if (self.wkui_opaque) {
        grayImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    } else {
        CGContextRef alphaContext = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, nil, kCGImageAlphaOnly);
        CGContextDrawImage(alphaContext, imageRect, self.CGImage);
        CGImageRef mask = CGBitmapContextCreateImage(alphaContext);
        CGImageRef maskedGrayImageRef = CGImageCreateWithMask(imageRef, mask);
        grayImage = [UIImage imageWithCGImage:maskedGrayImageRef scale:self.scale orientation:self.imageOrientation];
        CGImageRelease(mask);
        CGImageRelease(maskedGrayImageRef);
        CGContextRelease(alphaContext);
        
        // 用 CGBitmapContextCreateImage 方式创建出来的图片，CGImageAlphaInfo 总是为 CGImageAlphaInfoNone，导致 wkui_opaque 与原图不一致，所以这里再做多一步
        grayImage = [UIImage wkui_imageWithSize:grayImage.size opaque:NO scale:grayImage.scale actions:^(CGContextRef contextRef) {
            [grayImage drawInRect:CGRectMakeWithSize(grayImage.size)];
        }];
    }
    
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return grayImage;
}
 
+ (UIImage *)wkui_imageWithView:(UIView *)view {
    return [UIImage wkui_imageWithSize:view.bounds.size opaque:NO scale:0 actions:^(CGContextRef contextRef) {
        [view.layer renderInContext:contextRef];
    }];
}

@end
