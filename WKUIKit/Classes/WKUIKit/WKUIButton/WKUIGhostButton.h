//
//  WKUIGhostButton.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/30.
//

#import "WKUIButton.h"

NS_ASSUME_NONNULL_BEGIN
 

typedef NS_ENUM(NSUInteger, WKUIGhostButtonColor) {
    WKUIGhostButtonColorBlue,
    WKUIGhostButtonColorRed,
    WKUIGhostButtonColorGreen,
    WKUIGhostButtonColorGray,
    WKUIGhostButtonColorWhite,
};

/**
 *  “幽灵”按钮，也即背景透明、带圆角边框的按钮
 *
 *  可通过 `WKUIGhostButtonColor` 设置几种预设的颜色，也可以用 `ghostColor` 设置自定义颜色。
 *
 *  圆角自动保持为按钮高度的一半，可通过 WKUIButton.cornerRadius 属性修改。
 *
 *  @warning 默认情况下，`ghostColor` 只会修改文字和边框的颜色，如果需要让 image 也跟随 `ghostColor` 的颜色，则可将 `adjustsImageWithGhostColor` 设为 `YES`
 */
@interface WKUIGhostButton : WKUIButton

@property(nonatomic, strong, nullable) IBInspectable UIColor *ghostColor;    // 默认为 GhostButtonColorBlue
@property(nonatomic, assign) IBInspectable CGFloat borderWidth UI_APPEARANCE_SELECTOR;    // 默认为 1pt

/**
 *  控制按钮里面的图片是否也要跟随 `ghostColor` 一起变化，默认为 `NO`
 */
@property(nonatomic, assign) IBInspectable BOOL adjustsImageWithGhostColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithGhostType:(WKUIGhostButtonColor)ghostType;
- (instancetype)initWithGhostColor:(nullable UIColor *)ghostColor;

@end

NS_ASSUME_NONNULL_END
