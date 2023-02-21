//
//  UIView+WKUI.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  对 view.frame 操作的简便封装，注意 view 与 view 之间互相计算时，需要保证处于同一个坐标系内。
 */
@interface UIView (WKUI)

/// 等价于 CGRectGetMinY(frame)
@property(nonatomic, assign) CGFloat wkui_top;

/// 等价于 CGRectGetMinX(frame)
@property(nonatomic, assign) CGFloat wkui_left;

/// 等价于 CGRectGetMaxY(frame)
@property(nonatomic, assign) CGFloat wkui_bottom;

/// 等价于 CGRectGetMaxX(frame)
@property(nonatomic, assign) CGFloat wkui_right;

/// 等价于 CGRectGetWidth(frame)
@property(nonatomic, assign) CGFloat wkui_width;

/// 等价于 CGRectGetHeight(frame)
@property(nonatomic, assign) CGFloat wkui_height;

/// 保持其他三个边缘的位置不变的情况下，将顶边缘拓展到某个指定的位置，注意高度会跟随变化。
@property(nonatomic, assign) CGFloat wkui_extendToTop;

/// 保持其他三个边缘的位置不变的情况下，将左边缘拓展到某个指定的位置，注意宽度会跟随变化。
@property(nonatomic, assign) CGFloat wkui_extendToLeft;

/// 保持其他三个边缘的位置不变的情况下，将底边缘拓展到某个指定的位置，注意高度会跟随变化。
@property(nonatomic, assign) CGFloat wkui_extendToBottom;

/// 保持其他三个边缘的位置不变的情况下，将右边缘拓展到某个指定的位置，注意宽度会跟随变化。
@property(nonatomic, assign) CGFloat wkui_extendToRight;
@end

NS_ASSUME_NONNULL_END
