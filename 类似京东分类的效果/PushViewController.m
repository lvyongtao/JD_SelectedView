//
//  PushViewController.m
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/24.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "PushViewController.h"
#import "DetailViewController.h"
#import "TranslationAnimation.h"

@interface PushViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) TranslationAnimation *translation;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [self tableView];
    // Do any additional setup after loading the view.
}
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.delegate = self;
//   
//}

- (IBAction)click:(id)sender {
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.tag = 2;
    detail.Sucess_back = ^(NSString *nick){
        self.navigationController.delegate = self;
    };
    
    [self.navigationController pushViewController:detail animated:YES];
}
/**
 *  手势动画的处理
 *
 *  @param navigationController <#navigationController description#>
 *  @param animationController  <#animationController description#>
 *
 *  @return
 */
//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
//    
//    
//}
/**
 *  转场动画的处理
 *
 *  @param navigationController <#navigationController description#>
 *  @param operation            <#operation description#>
 *  @param fromVC               <#fromVC description#>
 *  @param toVC                 <#toVC description#>
 *
 *  @return
 */
//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC{
//    return [TranslationAnimation AnimatedWithTransitionType:operation == UINavigationControllerOperationPush ? AnimatedTransitioningTypePush : AnimatedTransitioningTypePop];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
