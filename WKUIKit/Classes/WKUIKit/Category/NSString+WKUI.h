//
//  NSString+WKUI.h
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/3/23.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WKUI)

/// 去掉头尾的空白字符
@property(readonly, copy) NSString *wkui_trim;
/// 去掉整段文字内的所有空白字符（包括换行符）
@property(readonly, copy) NSString *wkui_trimAllWhiteSpace;
/// 将文字中的换行符替换为空格
@property(readonly, copy) NSString *wkui_trimLineBreakCharacter;
/// 把该字符串转换为对应的 md5
@property(readonly, copy) NSString *wkui_md5;

/**
 *  按照中文 2 个字符、英文 1 个字符的方式来计算文本长度
 */
@property(readonly) NSUInteger wkui_lengthWhenCountingNonASCIICharacterAsTwo;
/**
 *  将字符串从指定的 index 开始裁剪到结尾，裁剪时会避免将 emoji 等 "character sequences" 拆散（一个 emoji 表情占用1-4个长度的字符）。
 *
 *  例如对于字符串“😊😞”，它的长度为4，若调用 [string wkui_substringAvoidBreakingUpCharacterSequencesFromIndex:1]，将返回“😊😞”。
 *  若调用系统的 [string substringFromIndex:1]，将返回“?😞”。（?表示乱码，因为第一个 emoji 表情被从中间裁开了）。
 *
 *  @param index 要从哪个 index 开始裁剪文字，如果 countingNonASCIICharacterAsTwo 为 YES，则 index 也要按 YES 的方式来算
 *  @param lessValue 要按小的长度取，还是按大的长度取
 *  @param countingNonASCIICharacterAsTwo 是否按照 英文 1 个字符长度、中文 2 个字符长度的方式来裁剪
 *  @return 裁剪完的字符
 */
- (NSString *)wkui_substringAvoidBreakingUpCharacterSequencesFromIndex:(NSUInteger)index lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo;

/**
 *  相当于 `wkui_substringAvoidBreakingUpCharacterSequencesFromIndex: lessValue:YES` countingNonASCIICharacterAsTwo:NO
 *  @see wkui_substringAvoidBreakingUpCharacterSequencesFromIndex:lessValue:countingNonASCIICharacterAsTwo:
 */
- (NSString *)wkui_substringAvoidBreakingUpCharacterSequencesFromIndex:(NSUInteger)index;

/**
 *  将字符串从开头裁剪到指定的 index，裁剪时会避免将 emoji 等 "character sequences" 拆散（一个 emoji 表情占用1-4个长度的字符）。
 *
 *  例如对于字符串“😊😞”，它的长度为4，若调用 [string wkui_substringAvoidBreakingUpCharacterSequencesToIndex:1 lessValue:NO countingNonASCIICharacterAsTwo:NO]，将返回“😊”。
 *  若调用系统的 [string substringToIndex:1]，将返回“?”。（?表示乱码，因为第一个 emoji 表情被从中间裁开了）。
 *
 *  @param index 要裁剪到哪个 index 为止（不包含该 index，策略与系统的 substringToIndex: 一致），如果 countingNonASCIICharacterAsTwo 为 YES，则 index 也要按 YES 的方式来算
 *  @param lessValue 裁剪时若遇到“character sequences”，是向下取整还是向上取整。
 *  @param countingNonASCIICharacterAsTwo 是否按照 英文 1 个字符长度、中文 2 个字符长度的方式来裁剪
 *  @return 裁剪完的字符
 */
- (NSString *)wkui_substringAvoidBreakingUpCharacterSequencesToIndex:(NSUInteger)index lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo;

/**
 *  相当于 `wkui_substringAvoidBreakingUpCharacterSequencesToIndex:lessValue:YES` countingNonASCIICharacterAsTwo:NO
 *  @see wkui_substringAvoidBreakingUpCharacterSequencesToIndex:lessValue:countingNonASCIICharacterAsTwo:
 */
- (NSString *)wkui_substringAvoidBreakingUpCharacterSequencesToIndex:(NSUInteger)index;

/**
 *  将字符串里指定 range 的子字符串裁剪出来，会避免将 emoji 等 "character sequences" 拆散（一个 emoji 表情占用1-4个长度的字符）。
 *
 *  例如对于字符串“😊😞”，它的长度为4，在 lessValue 模式下，裁剪 (0, 1) 得到的是空字符串，裁剪 (0, 2) 得到的是“😊”。
 *  在非 lessValue 模式下，裁剪 (0, 1) 或 (0, 2)，得到的都是“😊”。
 *
 *  @param range 要裁剪的文字位置
 *  @param lessValue 裁剪时若遇到“character sequences”，是向下取整还是向上取整。
 *  @param countingNonASCIICharacterAsTwo 是否按照 英文 1 个字符长度、中文 2 个字符长度的方式来裁剪
 *  @return 裁剪完的字符
 */
- (NSString *)wkui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo;

/**
 *  相当于 `wkui_substringAvoidBreakingUpCharacterSequencesWithRange:lessValue:YES` countingNonASCIICharacterAsTwo:NO
 *  @see wkui_substringAvoidBreakingUpCharacterSequencesWithRange:lessValue:countingNonASCIICharacterAsTwo:
 */
- (NSString *)wkui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range;
/*
 * 字符串是否可用/ null @"" nil都不可用，
 */
+ (BOOL)wkui_isValidString:(NSString *)string;
/// 把某个十进制数字转换成十六进制的数字的字符串，例如“10”->“A”
+ (NSString *)wkui_hexStringWithInteger:(NSInteger)integer;
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)wkui_firstCharactor:(NSString *)aString;
// 邮箱验证
+(BOOL)wkui_isValidateEmail:(NSString *)email;
/**
 * 功能:验证身份证是否合法
 * IDCard:输入的身份证号
 */
+(BOOL)wkui_isValidateIdCard:(NSString *)IDCard;


@end

NS_ASSUME_NONNULL_END
