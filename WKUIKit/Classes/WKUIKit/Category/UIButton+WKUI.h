//
//  UIButton+WKUI.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (WKUI)

/**
 自定义响应边界 UIEdgeInsetsMake(-3, -4, -5, -6). 表示扩大
 例如： self.btn.hitEdgeInsets = UIEdgeInsetsMake(-3, -4, -5, -6);
 */
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/**
 自定义响应边界 自定义的边界的范围 范围扩大3.0
 例如：self.btn.hitScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitScale;

/*
 自定义响应边界 自定义的宽度的范围 范围扩大3.0
 例如：self.btn.hitWidthScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitWidthScale;

/*
 自定义响应边界 自定义的高度的范围 范围扩大3.0
 例如：self.btn.hitHeightScale = 3.0;
 */
@property(nonatomic, assign) CGFloat hitHeightScale;

/*
  按钮点击事件 block
 */
- (void)wkui_addTargetEventForControlEvents:(UIControlEvents)controlEvents block:(void (^)(UIButton * button))block;


//设置相应时间间隔，防抖。 默认 0.01s
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end

NS_ASSUME_NONNULL_END
