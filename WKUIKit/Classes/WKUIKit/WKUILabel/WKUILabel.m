//
//  WKUILabel.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/6.
//

#import "WKUILabel.h"

@implementation WKUILabel

+ (instancetype)wkui_labelWithFrame:(CGRect)frame
                               text:(NSString *)text
                               font:(UIFont *)font
                          textColor:(UIColor *)textColor
                      textAlignment:(NSTextAlignment )textAlignment{
    WKUILabel *label = [[super alloc] initWithFrame:frame];
    if (label) {
        if (text) {
            label.text = text;
        }else{
            label.text = @"";
        }
        if (font) {
            label.font = font;
        }else{
            label.font = [UIFont systemFontOfSize:14];
        }
        if (textColor) {
            label.textColor = textColor;
        }else{
            label.textColor = UIColor.darkGrayColor;
        }
        if (textAlignment) {
            label.textAlignment = textAlignment;
        }else{
            label.textAlignment = NSTextAlignmentLeft;
        }
    }
    return label;
}
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment )textAlignment{
    self = [super initWithFrame:frame];
    if (self) {
        if (text) {
            self.text = text;
        }else{
            self.text = @"";
        }
        if (font) {
            self.font = font;
        }else{
            self.font = [UIFont systemFontOfSize:14];
        }
        if (textColor) {
            self.textColor = textColor;
        }else{
            self.textColor = UIColor.darkGrayColor;
        }
        if (textAlignment) {
            self.textAlignment = textAlignment;
        }else{
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
    return self;
}
@end
