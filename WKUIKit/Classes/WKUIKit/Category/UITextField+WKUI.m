//
//  UITextField+WKUI.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/3/23.
//

#import "UITextField+WKUI.h"

@implementation UITextField (WKUI)

 
- (NSRange)wkui_selectedRange {
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    return NSMakeRange(location, length);
}
 
- (NSRange)wkui_convertNSRangeFromUITextRange:(UITextRange *)textRange {
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:textRange.start];
    NSInteger length = [self offsetFromPosition:textRange.start toPosition:textRange.end];
    return NSMakeRange(location, length);
}

- (UITextRange *)wkui_convertUITextRangeFromNSRange:(NSRange)range {
    if (range.location == NSNotFound || NSMaxRange(range) > self.text.length) {
        return nil;
    }
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    return [self textRangeFromPosition:startPosition toPosition:endPosition];
}
 
@end
