//
//  ViewController.m
//  类似京东分类的效果
//
//  Created by user on 16/5/19.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//




/// 屏幕的宽度/// 屏幕高度
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define Nav_H 64



#import "PresentViewController.h"
#import "CollectionViewCell.h"
#import "collectionViewFlowLayout.h"
#import "YXBJFCollectionViewFlowLayout.h"
#import "DetailViewController.h"
#import "TranslationAnimation.h"
#import "SwipGestureTranslaiton.h"


@interface PresentViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate>


@property (strong, nonatomic) UITableView *selectTableView;

@property (strong, nonatomic) UICollectionView *GoodCollectView;
//@property (strong, nonatomic) collectionViewFlowLayout *layout;

@property (strong, nonatomic) YXBJFCollectionViewFlowLayout *layout;

@property (strong, nonatomic) SwipGestureTranslaiton *translaiton;

@end

    static NSString *cellGoodID = @"goodcollectCell";
    static NSString *cellSelectID = @"selectedCell";

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   //    [self setSelectTableView:self.selectTableView];
    
   
    // Do any additional setup after loading the view, typically from a nib.
    [self setUp];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.delegate = self;
}
- (void)setUp{
    
    self.translaiton = [[SwipGestureTranslaiton alloc] init];
    self.selectTableView.backgroundColor = [UIColor clearColor];
    self.GoodCollectView.backgroundColor = [UIColor clearColor];
}

- (UITableView *)selectTableView{
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,WIDTH/4, HEIGHT) style:UITableViewStylePlain];
        _selectTableView.bounces = YES;
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        [self.view addSubview:_selectTableView];
    }
    return _selectTableView;
}
#pragma mark ——UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellSelectID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSelectID];
    }
//    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = [NSString stringWithFormat:@"按钮%ld",indexPath.row];

    return cell;
}
#pragma mark ——UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_GoodCollectView reloadData];
}






- (UICollectionView *)GoodCollectView{
    if (!_GoodCollectView) {
        _layout = [[YXBJFCollectionViewFlowLayout alloc] init];
//        _layout = [[collectionViewFlowLayout alloc] init];
        [_layout setScrollDirection: UICollectionViewScrollDirectionVertical];
////        _layout.itemSize = CGSizeMake(WIDTH, 30);
//        _layout.minimumLineSpacing = 10;
//        _layout.minimumInteritemSpacing = 0;
        
        
        _GoodCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(WIDTH/4, Nav_H, WIDTH*3/4 - 10, HEIGHT - Nav_H) collectionViewLayout:_layout];
        _GoodCollectView.showsVerticalScrollIndicator = NO;
        
        _GoodCollectView.delegate = self;
        _GoodCollectView.dataSource = self;
        //注册cell
        [_GoodCollectView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellGoodID];
//        [_GoodCollectView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellGoodID];
        [self.view addSubview:_GoodCollectView];
    }
    return _GoodCollectView;
}

#pragma mark ——UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arc4random()%10 + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellGoodID forIndexPath:indexPath];
    if (!cell) {

    }
//    cell.introduce.hidden = YES;
//    cell.image.hidden = YES;
    cell.introduce.font = [UIFont systemFontOfSize:10];
    cell.introduce.textAlignment = NSTextAlignmentCenter;
    cell.introduce.text = [NSString stringWithFormat:@"商品00"];
    
  
    
 
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%100 + 200)/365.0 green:(arc4random()%100 + 200)/365.0 blue:(arc4random()%100 + 200)/365.0 alpha:0.8];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.transitioningDelegate = self;
    detail.tag = 1;
    [self.translaiton addGestureWithViewController:detail];
    detail.Sucess_back = ^(NSString *nick){
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.translaiton.GestureSwip) {
                
            }
        }];
    };
    [self presentViewController:detail animated:YES completion:nil];
    
    //0x00007f86a2d1a720   0x00007f86a2d1a720
}
#pragma mark -- present dismiss 转场动画

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [TranslationAnimation AnimatedWithTransitionType:0];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [TranslationAnimation AnimatedWithTransitionType:1];
}



- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.translaiton.GestureSwip?self.translaiton:nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
