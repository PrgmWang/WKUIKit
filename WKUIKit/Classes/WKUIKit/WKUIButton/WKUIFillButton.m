//
//  WKUIFillButton.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/30.
//

#import "WKUIFillButton.h"

@implementation WKUIFillButton

- (instancetype)init {
    return [self initWithFillType:WKUIFillButtonColorBlue];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFillType:WKUIFillButtonColorBlue frame:frame];
}

- (instancetype)initWithFillType:(WKUIFillButtonColor)fillType {
    return [self initWithFillType:fillType frame:CGRectZero];
}

- (instancetype)initWithFillType:(WKUIFillButtonColor)fillType frame:(CGRect)frame {
    UIColor *fillColor = nil;
    UIColor *textColor = UIColor.whiteColor;
    switch (fillType) {
        case WKUIFillButtonColorBlue:
            fillColor = UIColor.blueColor;
            break;
        case WKUIFillButtonColorRed:
            fillColor = UIColor.redColor;
            break;
        case WKUIFillButtonColorGreen:
            fillColor = UIColor.greenColor;
            break;
        case WKUIFillButtonColorGray:
            fillColor = UIColor.grayColor;
            break;
        case WKUIFillButtonColorWhite:
            fillColor = UIColor.whiteColor;
            textColor = UIColor.blueColor;
        default:
            break;
    }
    return [self initWithFillColor:fillColor titleTextColor:textColor frame:frame];
}

- (instancetype)initWithFillColor:(UIColor *)fillColor titleTextColor:(UIColor *)textColor {
    return [self initWithFillColor:fillColor titleTextColor:textColor frame:CGRectZero];
}

- (instancetype)initWithFillColor:(UIColor *)fillColor titleTextColor:(UIColor *)textColor frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.fillColor = fillColor;
        self.titleTextColor = textColor;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.fillColor = UIColor.blueColor;
        self.titleTextColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setAdjustsImageWithTitleTextColor:(BOOL)adjustsImageWithTitleTextColor {
    _adjustsImageWithTitleTextColor = adjustsImageWithTitleTextColor;
    if (adjustsImageWithTitleTextColor) {
        [self updateImageColor];
    }
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.backgroundColor = fillColor;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    [self setTitleColor:titleTextColor forState:UIControlStateNormal];
    if (self.adjustsImageWithTitleTextColor) {
        [self updateImageColor];
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (self.adjustsImageWithTitleTextColor) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [super setImage:image forState:state];
}

- (void)updateImageColor {
    self.imageView.tintColor = self.adjustsImageWithTitleTextColor ? self.titleTextColor : nil;
    if (self.currentImage) {
        NSArray<NSNumber *> *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled)];
        for (NSNumber *number in states) {
            UIImage *image = [self imageForState:[number unsignedIntegerValue]];
            if (!image) {
                continue;
            }
            if (self.adjustsImageWithTitleTextColor) {
                // 这里的image不用做renderingMode的处理，而是放到重写的setImage:forState里去做
                [self setImage:image forState:[number unsignedIntegerValue]];
            } else {
                // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:[number unsignedIntegerValue]];
            }
        }
    }
}

@end

@implementation WKUIFillButton (UIAppearance)

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setDefaultAppearance];
    });
}

+ (void)setDefaultAppearance {
    WKUIFillButton *appearance = [WKUIFillButton appearance];
    appearance.cornerRadius = WKUIButtonCornerRadiusAdjustsBounds;
    appearance.adjustsImageWithTitleTextColor = NO;
}


@end
