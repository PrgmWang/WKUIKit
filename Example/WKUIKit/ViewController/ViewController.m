//
//  ViewController.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/8/23.
//

#import "ViewController.h"
#import "WKButtonViewController.h"
#import "WKUIInputViewController.h"
#import "WKUIImageViewController.h"
#import "WKUISafeViewController.h"
#import "WKUIColorViewController.h"

@interface TitleCollectionCell : UICollectionViewCell
//titleLb
@property (nonatomic, strong) WKUILabel *titleLb;
@end

@implementation TitleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.contentView.backgroundColor = UIColor.lightGrayColor;
    self.titleLb = [WKUILabel wkui_labelWithFrame:CGRectZero text:@"" font:[UIFont systemFontOfSize:15] textColor:UIColor.whiteColor textAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.titleLb];
  
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLb.frame = self.contentView.bounds;
}
@end


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//
@property (nonatomic, strong) UICollectionView *mainCollectView;
//数据
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    self.title = @"WKUIKit";
    [self.view addSubview:self.mainCollectView];
    
}

#pragma mark ---------------- Delegate ----------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLb.text = self.titleArr[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[WKButtonViewController new] animated:YES];
    }else if (indexPath.row == 4 ||indexPath.row == 5 ){
        [self.navigationController pushViewController:[WKUIInputViewController new] animated:YES];
    }else if (indexPath.row == 3){
        [self.navigationController pushViewController:[WKUIImageViewController new] animated:YES];
    }else if (indexPath.row == 6){
        [self.navigationController pushViewController:[WKUISafeViewController new] animated:YES];
    }else if (indexPath.row == 7){
        [self.navigationController pushViewController:[WKUIColorViewController new] animated:YES];
    }
    
    
}

#pragma mark ---------------- lazyLoading ----------------
- (UICollectionView *)mainCollectView{
    if (!_mainCollectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((self.view.wkui_width - 5)/3, 80);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        _mainCollectView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _mainCollectView.backgroundColor = UIColor.whiteColor;
        _mainCollectView.delegate = self;
        _mainCollectView.dataSource = self;
        [_mainCollectView registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _mainCollectView;
}
- (NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"NSString",@"WKUILabel",@"WKUIButton",@"WKUIImage",@"WKUITextField",@"WKUITextView",@"防越界",@"UIColor"];
    }
    return _titleArr;
}

@end
