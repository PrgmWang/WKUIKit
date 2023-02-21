//
//  WKUIGhostButton.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/30.
//

#import "WKUIGhostButton.h"

@implementation WKUIGhostButton

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithGhostType:WKUIGhostButtonColorBlue frame:frame];
}

- (instancetype)initWithGhostType:(WKUIGhostButtonColor)ghostType {
    return [self initWithGhostType:ghostType frame:CGRectZero];
}

- (instancetype)initWithGhostType:(WKUIGhostButtonColor)ghostType frame:(CGRect)frame {
    UIColor *ghostColor = nil;
    switch (ghostType) {
        case WKUIGhostButtonColorBlue:
            ghostColor = UIColor.blueColor;
            break;
        case WKUIGhostButtonColorRed:
            ghostColor = UIColor.redColor;
            break;
        case WKUIGhostButtonColorGreen:
            ghostColor = UIColor.greenColor;
            break;
        case WKUIGhostButtonColorGray:
            ghostColor = UIColor.grayColor;
            break;
        case WKUIGhostButtonColorWhite:
            ghostColor = UIColor.whiteColor;
            break;
        default:
            break;
    }
    return [self initWithGhostColor:ghostColor frame:frame];
}

- (instancetype)initWithGhostColor:(UIColor *)ghostColor {
    return [self initWithGhostColor:ghostColor frame:CGRectZero];
}

- (instancetype)initWithGhostColor:(UIColor *)ghostColor frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeWithGhostColor:ghostColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeWithGhostColor:UIColor.blueColor];
    }
    return self;
}

- (void)initializeWithGhostColor:(UIColor *)ghostColor {
    self.ghostColor = ghostColor;
}

- (void)setGhostColor:(UIColor *)ghostColor {
    _ghostColor = ghostColor;
    [self setTitleColor:_ghostColor forState:UIControlStateNormal];
    self.layer.borderColor = _ghostColor.CGColor;
    if (self.adjustsImageWithGhostColor) {
        [self updateImageColor];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setAdjustsImageWithGhostColor:(BOOL)adjustsImageWithGhostColor {
    _adjustsImageWithGhostColor = adjustsImageWithGhostColor;
    [self updateImageColor];
}

- (void)updateImageColor {
    self.imageView.tintColor = self.adjustsImageWithGhostColor ? self.ghostColor : nil;
    if (self.currentImage) {
        NSArray<NSNumber *> *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled)];
        for (NSNumber *number in states) {
            UIImage *image = [self imageForState:[number unsignedIntegerValue]];
            if (!image) {
                continue;
            }
            if (self.adjustsImageWithGhostColor) {
                // 这里的image不用做renderingMode的处理，而是放到重写的setImage:forState里去做
                [self setImage:image forState:[number unsignedIntegerValue]];
            } else {
                // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:[number unsignedIntegerValue]];
            }
        }
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (self.adjustsImageWithGhostColor) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [super setImage:image forState:state];
}

@end

@implementation WKUIGhostButton (UIAppearance)

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setDefaultAppearance];
    });
}

+ (void)setDefaultAppearance {
    WKUIGhostButton *appearance = [WKUIGhostButton appearance];
    appearance.borderWidth = 1;
    appearance.cornerRadius = WKUIButtonCornerRadiusAdjustsBounds;
    appearance.adjustsImageWithGhostColor = NO;
}

@end
