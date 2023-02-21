//
//  UIView+WKUI.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/8.
//

#import "UIView+WKUI.h"
#import "WKUICommonDefine.h"

@implementation UIView (WKUI)

- (CGFloat)wkui_top {
    return CGRectGetMinY(self.frame);
}

- (void)setWkui_top:(CGFloat)top {
    self.frame = CGRectSetY(self.frame, top);
}

- (CGFloat)wkui_left {
    return CGRectGetMinX(self.frame);
}

- (void)setWkui_left:(CGFloat)left {
    self.frame = CGRectSetX(self.frame, left);
}

- (CGFloat)wkui_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setWkui_bottom:(CGFloat)bottom {
    self.frame = CGRectSetY(self.frame, bottom - CGRectGetHeight(self.frame));
}

- (CGFloat)wkui_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setWkui_right:(CGFloat)right {
    self.frame = CGRectSetX(self.frame, right - CGRectGetWidth(self.frame));
}

- (CGFloat)wkui_width {
    return CGRectGetWidth(self.frame);
}

- (void)setWkui_width:(CGFloat)width {
    self.frame = CGRectSetWidth(self.frame, width);
}

- (CGFloat)wkui_height {
    return CGRectGetHeight(self.frame);
}

- (void)setWkui_height:(CGFloat)height {
    self.frame = CGRectSetHeight(self.frame, height);
}

- (CGFloat)wkui_extendToTop {
    return self.wkui_top;
}

- (void)setWkui_extendToTop:(CGFloat)wkui_extendToTop {
    self.wkui_height = self.wkui_bottom - wkui_extendToTop;
    self.wkui_top = wkui_extendToTop;
}

- (CGFloat)wkui_extendToLeft {
    return self.wkui_left;
}

- (void)setWkui_extendToLeft:(CGFloat)wkui_extendToLeft {
    self.wkui_width = self.wkui_right - wkui_extendToLeft;
    self.wkui_left = wkui_extendToLeft;
}

- (CGFloat)wkui_extendToBottom {
    return self.wkui_bottom;
}

- (void)setWkui_extendToBottom:(CGFloat)wkui_extendToBottom {
    self.wkui_height = wkui_extendToBottom - self.wkui_top;
    self.wkui_bottom = wkui_extendToBottom;
}

- (CGFloat)wkui_extendToRight {
    return self.wkui_right;
}

- (void)setWkui_extendToRight:(CGFloat)wkui_extendToRight {
    self.wkui_width = wkui_extendToRight - self.wkui_left;
    self.wkui_right = wkui_extendToRight;
}

@end
