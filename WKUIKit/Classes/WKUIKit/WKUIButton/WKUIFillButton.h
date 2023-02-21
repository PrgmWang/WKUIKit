//
//  WKUIFillButton.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/30.
//

#import "WKUIButton.h"

NS_ASSUME_NONNULL_BEGIN
 

typedef NS_ENUM(NSUInteger, WKUIFillButtonColor) {
    WKUIFillButtonColorBlue,
    WKUIFillButtonColorRed,
    WKUIFillButtonColorGreen,
    WKUIFillButtonColorGray,
    WKUIFillButtonColorWhite,
};

/**
 *  WKUIFillButton
 *  实心填充颜色的按钮，支持预定义的几个色值
 *  圆角自动保持为按钮高度的一半，可通过 WKUIButton.cornerRadius 属性修改
 */
@interface WKUIFillButton : WKUIButton

@property(nonatomic, strong, nullable) IBInspectable UIColor *fillColor; // 默认为 FillButtonColorBlue
@property(nonatomic, strong, nullable) IBInspectable UIColor *titleTextColor; // 默认为 UIColorWhite

/**
 *  控制按钮里面的图片是否也要跟随 `titleTextColor` 一起变化，默认为 `NO`
 */
@property(nonatomic, assign) BOOL adjustsImageWithTitleTextColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithFillType:(WKUIFillButtonColor)fillType;
- (instancetype)initWithFillType:(WKUIFillButtonColor)fillType frame:(CGRect)frame;
- (instancetype)initWithFillColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor;
- (instancetype)initWithFillColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
