//
//  WKButtonViewController.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/25.
//

#import "WKButtonViewController.h"

@interface WKButtonViewController ()

@end

@implementation WKButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"WKUIButton";
    WKUIButton *btn = [[WKUIButton alloc] initWithFrame:CGRectMake(self.view.wkui_width/2 - 50, 150, 100, 100)
                                                  title:@"title"
                                              titleFont:[UIFont systemFontOfSize:13]
                                       normalTitleColor:UIColor.whiteColor
                                     selectedTitleColor:UIColor.blackColor
                                            normalImage:@"tabbar_mine_unselected"
                                          selectedImage:@"tabbar_mine_selected"];
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
        WKLog(@"===点击");
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
    [self.view addSubview:btn];
    
    
    WKUIFillButton *fillBtn = [[WKUIFillButton alloc] initWithFillType:WKUIFillButtonColorGray frame:CGRectMake(kScreenWidth/2 - 100, 300, 200, 50)];
    fillBtn.normalTitle = @"填充按钮";
    [self.view addSubview:fillBtn];
    
    
    WKUIGhostButton *ghostButton = [[WKUIGhostButton alloc] initWithGhostColor:UIColor.redColor];
    ghostButton.frame = CGRectMake(kScreenWidth/2 - 100, 400, 200, 50);
    ghostButton.normalTitle = @"幽灵按钮";
    [self.view addSubview:ghostButton];
}
 
@end
