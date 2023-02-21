//
//  WKUIButton.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/3/22.
//

#import <UIKit/UIKit.h>
#import "UIButton+WKUI.h"

NS_ASSUME_NONNULL_BEGIN

/// 控制图片在UIButton里的位置，默认为WKUIButtonImagePositionLeft
typedef NS_ENUM(NSUInteger, WKUIButtonImagePosition) {
    WKUIButtonImagePositionTop,             // imageView在titleLabel上面
    WKUIButtonImagePositionLeft,            // imageView在titleLabel左边
    WKUIButtonImagePositionBottom,          // imageView在titleLabel下面
    WKUIButtonImagePositionRight,           // imageView在titleLabel右边
};
/**
 *  用于 `WKUIButton.cornerRadius` 属性，当 `cornerRadius` 为 `WKUIButtonCornerRadiusAdjustsBounds` 时，`WKUIButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
extern const CGFloat WKUIButtonCornerRadiusAdjustsBounds;

@interface WKUIButton : UIButton
/**
 * 类方法
 */
+ (instancetype)wkui_buttonWithType:(UIButtonType)buttonType
                              title:(nullable NSString *)title
                          titleFont:(nullable UIFont *)titleFont
                   normalTitleColor:(nullable UIColor *)normalTitleColor
                 selectedTitleColor:(nullable UIColor *)selectedTitleColor
                        normalImage:(nullable NSString *)normalImage
                      selectedImage:(nullable NSString *)selectedImage;
/**
 * 实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame
                        title:(nullable NSString *)title
                    titleFont:(nullable UIFont *)titleFont
             normalTitleColor:(nullable UIColor *)normalTitleColor
           selectedTitleColor:(nullable UIColor *)selectedTitleColor
                  normalImage:(nullable NSString *)normalImage
                selectedImage:(nullable NSString *)selectedImage;

/**
 *  子类继承时重写的方法，一般不建议重写 initWithXxx
 */
- (void)didInitialize NS_REQUIRES_SUPER;

/**
 * 设置按钮里图标和文字的相对位置，默认为WKUIButtonImagePositionLeft<br/>
 * 可配合imageEdgeInsets、titleEdgeInsets、contentHorizontalAlignment、contentVerticalAlignment使用
 */
@property(nonatomic, assign) WKUIButtonImagePosition imagePosition;

/**
 * 设置按钮里图标和文字之间的间隔，会自动响应 imagePosition 的变化而变化，默认为0。<br/>
 * 系统默认实现需要同时设置 titleEdgeInsets 和 imageEdgeInsets，同`时还需考虑 contentEdgeInsets 的增加（否则不会影响布局，可能会让图标或文字溢出或挤压），使用该属性可以避免以上情况。<br/>
 * @warning 会与 imageEdgeInsets、 titleEdgeInsets、 contentEdgeInsets 共同作用。
 */
@property(nonatomic, assign) IBInspectable CGFloat spacingBetweenImageAndTitle;
/**
 * 设置按钮标题
 */
@property(nonatomic, strong) NSString *normalTitle;
/**
 * 设置按钮选中标题 
 */
@property(nonatomic, strong) NSString *selectedTitle;
/**
 * 设置按钮标题字号，等同于 self.titleLabel.font
 */
@property(nonatomic, strong) IBInspectable UIFont *normalTitleFont;
/**
 * 设置按钮 选中标题字号，等同于 self.titleLabel.font
 */
@property(nonatomic, strong) IBInspectable UIFont *selectedTitleFont;

/**
 * 设置按钮 normal状态下背景颜色
 */
@property(nonatomic, assign) IBInspectable UIColor *normalBackgroundColor;
/**
 * 设置按钮 选中状态背景颜色 <br/>
 * 要配合 normalBackgroundColor 使用
 */
@property(nonatomic, assign) IBInspectable UIColor *selectedBackgroundColor;

/**
 默认为 0。将其设置为 WKUIButtonCornerRadiusAdjustsBounds 可自动保持圆角为按钮高度的一半。
 */
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
 
@end

NS_ASSUME_NONNULL_END
