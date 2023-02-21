//
//  UIButton+WKUI.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/3/22.
//

#import "UIButton+WKUI.h"
#import <objc/runtime.h>


#define defaultInterval 0.01  //默认时间间隔,不能太长，以免影响系统拍照等功能
static const char * kHitEdgeInsets = "hitEdgeInsets";
static const char * kHitScale      = "hitScale";
static const char * kHitWidthScale      = "hitWidthScale";
static const char * kHitHeightScale      = "hitHeightScale";

typedef void(^ButtonTargetBlock)(UIButton * button);
static void * buttonEventsBlockKey = &buttonEventsBlockKey;


@interface UIButton ()
/** 事件回调的block */
@property (nonatomic, copy) ButtonTargetBlock buttonTargetBlock;
/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (WKUI)
 
static const char *UIControl_eventTimeInterval   = "UIControl_eventTimeInterval";
static const char *UIControl_enventIsIgnoreEvent = "UIControl_enventIsIgnoreEvent";

+ (void)load {
    // Method Swizzling
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //根据selector查找Method
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(new_sendAction:to:forEvent:);
        Method methodA = class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        //添加自定义方法
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        
        if (isAdd) {//添加成功->替换
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{//添加不成功->交换
            //添加失败了 说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

#pragma mark --------------------- 自定义按钮响应区 ---------------------
-(void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets{
    NSValue *value = [NSValue value:&hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self,kHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setHitScale:(CGFloat)hitScale{
    CGFloat width = self.bounds.size.width * hitScale;
    CGFloat height = self.bounds.size.height * hitScale;
    self.hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitScale, @(hitScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)setHitWidthScale:(CGFloat)hitWidthScale{
    CGFloat width = self.bounds.size.width * hitWidthScale;
    CGFloat height = self.bounds.size.height ;
    self.hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitWidthScale, @(hitWidthScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(void)setHitHeightScale:(CGFloat)hitHeightScale{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * hitHeightScale ;
    self.hitEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
    objc_setAssociatedObject(self, kHitHeightScale, @(hitHeightScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - get Method
-(UIEdgeInsets)hitEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, kHitEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets:UIEdgeInsetsZero;
}

-(CGFloat)hitScale{
    return [objc_getAssociatedObject(self, kHitScale) floatValue];
}

-(CGFloat)hitWidthScale{
    return [objc_getAssociatedObject(self, kHitWidthScale) floatValue];
}

-(CGFloat)hitHeightScale{
    return [objc_getAssociatedObject(self, kHitHeightScale) floatValue];
}
 
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //如果 button 边界值无变化  失效 隐藏 或者透明 直接返回
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden || self.alpha == 0 ) {
        return [super pointInside:point withEvent:event];
    }else{
        CGRect relativeFrame = self.bounds;
        CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitEdgeInsets);
        return CGRectContainsPoint(hitFrame, point);
    }
}

#pragma mark --------------------- 按钮点击事件 ---------------------

-(ButtonTargetBlock)buttonTargetBlock
{
    return objc_getAssociatedObject(self, &buttonEventsBlockKey);
}
-(void)setButtonTargetBlock:(ButtonTargetBlock)buttonTargetBlock
{
    objc_setAssociatedObject(self, &buttonEventsBlockKey, buttonTargetBlock, OBJC_ASSOCIATION_COPY);
}
/**
 按钮添加回调block
 */
- (void)wkui_addTargetEventForControlEvents:(UIControlEvents)controlEvents block:(void (^)(UIButton * button))block
{
    self.buttonTargetBlock = block;
    [self addTarget:self action:@selector(blcokButtonClicked:) forControlEvents:controlEvents];
}
/**
 按钮点击事件
 */
- (void)blcokButtonClicked:(UIButton *)sender
{
    if (self.buttonTargetBlock)
    {
        self.buttonTargetBlock(sender);
    }
}

- (void)new_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    self.eventTimeInterval = self.eventTimeInterval == 0 ? defaultInterval : self.eventTimeInterval;
    if (self.isIgnoreEvent){//默认可以响应点击事件
        return;
    }else if (self.eventTimeInterval > 0){//第一次点击，设定eventTimeInterval后，可以响应点击事件
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsIgnoreEvent:NO];
        });
    }
    
    self.isIgnoreEvent = YES;//设置不可以响应点击事件
    // 这里看上去会陷入递归调用死循环，但在运行期此方法是和sendAction:to:forEvent:互换的，
    // 相当于执行sendAction:to:forEvent:方法，所以并不会陷入死循环。
    [self new_sendAction:action to:target forEvent:event];
}

// runtime 动态绑定 属性
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, UIControl_enventIsIgnoreEvent) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, UIControl_enventIsIgnoreEvent, @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)eventTimeInterval {
    return [objc_getAssociatedObject(self, UIControl_eventTimeInterval) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval {
    objc_setAssociatedObject(self, UIControl_eventTimeInterval, @(eventTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
