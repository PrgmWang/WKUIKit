//
//  UIImage+WKUI.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/12.
//

#import <UIKit/UIKit.h>
 

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WKUI)

/// 当前图片是否是可拉伸/平铺的，也即通过 resizableImageWithCapInsets: 处理过的图片
@property(nonatomic, assign, readonly) BOOL wkui_resizable;

/// 获取当前图片的像素大小，如果是多倍图，会被放大到一倍来算
@property(nonatomic, assign, readonly) CGSize wkui_sizeInPixel;

/**
 *  判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。
 */
- (BOOL)wkui_opaque;
/**
 *  获取当前图片的均色，原理是将图片绘制到1px*1px的矩形内，再从当前区域取色，得到图片的均色。
 *  @return 代表图片平均颜色的UIColor对象
 */
- (UIColor *)wkui_averageColor;

/**
 *  置灰当前图片
 *  @return 已经置灰的图片
 */
- (nullable UIImage *)wkui_grayImage;
 
/**
 用于绘制一张图并以 UIImage 的形式返回

 @param size 要绘制的图片的 size，宽或高均不能为 0
 @param opaque 图片是否不透明，YES 表示不透明，NO 表示半透明
 @param scale 图片的倍数，0 表示取当前屏幕的倍数
 @param actionBlock 实际的图片绘制操作，在这里只管绘制就行，不用手动生成 image
 @return 返回绘制完的图片
 */
+ (nullable UIImage *)wkui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock;
/**
 * 创建一个纯色图片
 */
+ (UIImage *)wkui_imageWithColor:(UIColor *)color ;
/**
 对传进来的 `UIView` 截图，生成一个 `UIImage` 并返回。注意这里使用的是 view.layer 来渲染图片内容。

 @param view 要截图的 `UIView`

 @return `UIView` 的截图
 
 @warning UIView 的 transform 并不会在截图里生效
 */
+ (nullable UIImage *)wkui_imageWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
