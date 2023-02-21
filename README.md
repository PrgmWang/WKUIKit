# WKUIKit

[![CI Status](https://img.shields.io/travis/PrgmWang/WKUIKit.svg?style=flat)](https://travis-ci.org/PrgmWang/WKUIKit)
[![Version](https://img.shields.io/cocoapods/v/WKUIKit.svg?style=flat)](https://cocoapods.org/pods/WKUIKit)
[![License](https://img.shields.io/cocoapods/l/WKUIKit.svg?style=flat)](https://cocoapods.org/pods/WKUIKit)
[![Platform](https://img.shields.io/cocoapods/p/WKUIKit.svg?style=flat)](https://cocoapods.org/pods/WKUIKit)
 
# 一款基于OC语言的UI框架 目前包含6个控件，14个扩展类，持续更新中...

## WKUIButton & UIButton+WKUI （按钮 以及 按钮的常用扩展方法） 
* 新增的特性包括： 
* 1. WKUIButton 开放两个初始化方法，可以一行代码实现控件初始化，并设置各项参数，参数已经进行非空校验，无需设置的属性可以设置为nil。
* 2. WKUIButton  除了兼容系统控件UIButton属性之外，还包含多个非系统属性如：设置事件间隔。
* 3. UIButton+WKUI 作为WKUIButton补充可以扩大按钮的相应区域，以block方式实现按钮的点击事件。 
```objective-c
    WKUIButton *btn = [[WKUIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)
                                                  title:@"title"
                                              titleFont:[UIFont systemFontOfSize:13]
                                       normalTitleColor:UIColor.whiteColor
                                     selectedTitleColor:UIColor.blackColor
                                            normalImage:@"shop_map_me"
                                          selectedImage:@"shop_map_me”];
    //设置图片在标题的下方
    btn.imagePosition = WKUIButtonImagePositionBottom;
    //设置图片和标题的距离
    btn.spacingBetweenImageAndTitle = 10;
    //设置正常状态的背景颜色
    btn.normalBackgroundColor = UIColor.redColor;
    //设置选中状态的背景颜色
    btn.selectedBackgroundColor = UIColor.orangeColor;
    //设置选中状态的文字颜色
    btn.selectedTitleFont = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:btn];
    //添加点击事件 ，无需创建 selector 方法
    [btn wkui_addTargetEventForControlEvents:UIControlEventTouchUpInside block:^(UIButton * _Nonnull button) {
        NSLog(@"===点击");
        //只修改按钮的选中状态即可修改按钮的背景颜色，无需手动重设
        button.selected = !button.selected;
    }];
    //WKUIButtonCornerRadiusAdjustsBounds  默认是高度的一半，
    btn.cornerRadius = 50.0;
    //按钮的相应区域 向4个方向扩大50 。
    btn.hitEdgeInsets = UIEdgeInsetsMake(-50, -50, -50, -50);
    //按钮 相应间隔 防止误触/重复点击
    btn.eventTimeInterval = 2;
    //按钮自定义边界范围扩大3.0
    //btn.hitScale = 3.0
    //按钮自定义边界宽度范围扩大3.0
    //btn.hitWidthScale = 3.0
    //按钮自定义高度范围扩大3.0
    //btn.hitHeightScale = 3.0
     
```
## WKUIFillButton 继承自WKUIButton。
 
 *  实心填充颜色的按钮，支持预定义的几个色值
 *  圆角自动保持为按钮高度的一半，可通过 WKUIButton.cornerRadius 属性修改
 
```objective-c

@interface WKUIFillButton : WKUIButton

@property(nonatomic, strong, nullable) IBInspectable UIColor *fillColor; // 默认为 FillButtonColorBlue
@property(nonatomic, strong, nullable) IBInspectable UIColor *titleTextColor; // 默认为 UIColorWhite 

```

## WKUIGhostButton 继承自WKUIButton。
 
 *  “幽灵”按钮，也即背景透明、带圆角边框的按钮
 *  可通过 `WKUIGhostButtonColor` 设置几种预设的颜色，也可以用 `ghostColor` 设置自定义颜色。
 *  圆角自动保持为按钮高度的一半，可通过 WKUIButton.cornerRadius 属性修改。
 *  @warning 默认情况下，`ghostColor` 只会修改文字和边框的颜色，如果需要让 image 也跟随 `ghostColor` 的颜色，则可将 `adjustsImageWithGhostColor` 设为 `YES`
 
```objective-c

@property(nonatomic, strong, nullable) IBInspectable UIColor *ghostColor;    // 默认为 GhostButtonColorBlue
@property(nonatomic, assign) IBInspectable CGFloat borderWidth UI_APPEARANCE_SELECTOR;    // 默认为 1pt
 
```

## WKUITextField （输入框） 
*  新增的特性包括： 
*  1. 自定义 placeholderColor。
*  2. 自定义 UITextField 的文字 padding。
*  3. 支持限制输入的文字的长度。 
```objective-c
    WKUITextField *inputTF = [[WKUITextField alloc] initWithFrame:CGRectMake(20, 100,200, 40)]; 
    //输入框支持最大输入长度
    inputTF.maximumTextLength =  4;
    //在使用 maximumTextLength 功能的时候，是否应该把文字长度按照ASII计算
    inputTF.shouldCountingNonASCIICharacterAsTwo = YES;
    inputTF.placeholder = @"搜索";
    //输入框占位字符串的颜色
    inputTF.placeholderColor = UIColor.whiteColor; 
```

## WKUITextView （多行输入框）
*  自定义 UITextView，提供的特性如下： 
*  1. 支持 placeholder 并支持更改 placeholderColor；若使用了富文本文字，则 placeholder 的样式也会跟随文字的样式（除了 placeholder 颜色）
*  2. 支持在文字发生变化时计算内容高度并通知 delegate。
*  3. 支持限制输入框最大高度，一般配合第 2 点使用。
*  4. 支持限制输入的文本的最大长度，默认不限制。 
```objective-c
    WKUITextView *tv = [[WKUITextView alloc] initWithFrame:CGRectMake(100, 300, 200, 50)]; 
    //最大输入长度
    tv.maximumTextLength = 100;
    //可以直接设置placeholder
    tv.placeholder = @"请输入内容";
    //直接修改placeholder颜色
    tv.placeholderColor = UIColor.purpleColor; 
```

## UIImage+WKUI （图片扩展方法）
```
//当前图片是否是可拉伸/平铺的，也即通过 resizableImageWithCapInsets: 处理过的图片
@property(nonatomic, assign, readonly) BOOL wkui_resizable;
//获取当前图片的像素大小，如果是多倍图，会被放大到一倍来算
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
``` 

## Installation

```ruby 
pod 'WKUIKit', :git => 'https://github.com/PrgmWang/WKUIKit.git'
```

## Author

PrgmWang, 41496789@qq.com ,wx:PrgmWang
 
## 持续更新中，敬请期待！！！
