//
//  WKUITextFieldView.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/25.
//

#import "WKUIInputViewController.h"

@interface WKUIInputViewController ()<WKUITextViewDelegate>

@end

@implementation WKUIInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"WKUITextField & WKUITextView";
    
    WKUITextField *inputTF = [[WKUITextField alloc] initWithFrame:CGRectMake(20, 150,200, 40)];
    inputTF.backgroundColor = UIColor.lightGrayColor;
    //输入框支持最大输入长度
    inputTF.maximumTextLength = 4;
    //在使用 maximumTextLength 功能的时候，是否应该把文字长度按照ASII计算
    inputTF.shouldCountingNonASCIICharacterAsTwo = NO;
    inputTF.placeholder = @"搜索";
    //输入框占位字符串的颜色
    inputTF.placeholderColor = UIColor.whiteColor;
    inputTF.textColor = UIColor.redColor;
    [self.view addSubview:inputTF];
    
    
    WKUITextView *inputTV = [[WKUITextView alloc] initWithFrame:CGRectMake(20, 200,self.view.wkui_width - 40, 100)];
    inputTV.backgroundColor = UIColor.lightGrayColor;
    inputTV.maximumTextLength = 400;
    inputTV.placeholder = @"请输入内容";
    inputTV.placeholderColor = UIColor.purpleColor;
    inputTV.textColor = UIColor.redColor;
    inputTV.delegate = self;
    [self.view addSubview:inputTV];
    WKUILabel *countLb = [WKUILabel wkui_labelWithFrame:CGRectMake(inputTV.wkui_right - 120, inputTV.wkui_bottom, 100, 20) text:@"0/400" font:[UIFont systemFontOfSize:14] textColor:UIColor.darkGrayColor textAlignment:NSTextAlignmentRight];
    countLb.tag = 100;
    [self.view addSubview:countLb];
}
-(void)textViewDidChange:(UITextView *)textView{
    WKUILabel *lb = (WKUILabel *)[self.view viewWithTag:100];
    lb.text = [NSString stringWithFormat:@"%ld/400",textView.text.length];
}
@end
