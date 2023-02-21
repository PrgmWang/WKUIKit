//
//  WKUISafeViewController.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/9/1.
//

#import "WKUISafeViewController.h"

@interface WKUISafeViewController ()

@end

@implementation WKUISafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
   self.title = @"防越界Demo";
   
    [self test];
}
-(void)test{
//    NSArray *normalArr = @[@"",@"",@""];
//    WKLog(@"%@", normalArr[3]);
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    //正常情况下使用会崩溃
    WKLog(@"%@", mutArr[3]);
    
    NSMutableString *mutStr = [NSMutableString stringWithString:@"123"];
    //正常情况下使用会崩溃 
    WKLog(@"%@", [mutStr substringToIndex:4]);
}

@end
