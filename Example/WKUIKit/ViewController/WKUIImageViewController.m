//
//  WKUIImageViewController.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/25.
//

#import "WKUIImageViewController.h"

@interface WKUIImageViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *operaImageView;

@end

@implementation WKUIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}
 
- (void)initUI{
    self.title = @"UIImage+WKUI";
    WKLog(@"=== %@alpha通道",self.mainImageView.image.wkui_opaque ? @"存在":@"不存在");
    
}

- (IBAction)action:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
        case 102:
        {
            self.operaImageView.image = [UIImage wkui_imageWithColor:[self.mainImageView.image wkui_averageColor]];
        }
            
            break;
        case 101:
        {
            self.operaImageView.image = [self.mainImageView.image wkui_grayImage];
        }
            
            break;
        case 103:
        {
            self.operaImageView.image = [UIImage wkui_imageWithView:self.container];
        }
            
            break;
            
        default:
            break;
    }
}

@end
