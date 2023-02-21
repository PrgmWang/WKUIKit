//
//  UITextField+WKUI.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (WKUI)

/// UITextField只有selectedTextRange属性（在<UITextInput>协议里定义），这里拓展了一个方法可以将UITextRange类型的selectedTextRange转换为NSRange类型的selectedRange
@property(nonatomic, assign, readonly) NSRange wkui_selectedRange;
  
/**
 *  convert UITextRange to NSRange, for example, [self wkui_convertNSRangeFromUITextRange:self.markedTextRange]
 */
- (NSRange)wkui_convertNSRangeFromUITextRange:(UITextRange *)textRange;

/**
 *  convert NSRange to UITextRange
 *  @return return nil if range is invalidate.
 */
- (nullable UITextRange *)wkui_convertUITextRangeFromNSRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
