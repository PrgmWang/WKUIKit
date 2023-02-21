//
//  WKUIColorViewController.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/9/2.
//

#import "WKUIColorViewController.h"

@interface WKUIColorViewController ()

@end

@implementation WKUIColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
   self.title = @"颜色拓展Demo";
    
    WKUILabel *randomLb = [[WKUILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20) text:@"随机颜色" font:kNormalFont(14) textColor:UIColor.wkui_randomColor textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:randomLb];
    
    
}

@end
