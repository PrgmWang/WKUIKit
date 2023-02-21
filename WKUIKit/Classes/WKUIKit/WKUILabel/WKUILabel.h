//
//  WKUILabel.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKUILabel : UILabel
/**
 * 类方法
 */
+ (instancetype)wkui_labelWithFrame:(CGRect)frame
                               text:(nullable NSString *)text
                               font:(nullable UIFont *)font
                          textColor:(nullable UIColor *)textColor
                    textAlignment:( NSTextAlignment )textAlignment;
/**
 * 实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame
                         text:(nullable NSString *)text
                         font:(nullable UIFont *)font
                    textColor:(nullable UIColor *)textColor
              textAlignment:( NSTextAlignment )textAlignment;


@end

NS_ASSUME_NONNULL_END
