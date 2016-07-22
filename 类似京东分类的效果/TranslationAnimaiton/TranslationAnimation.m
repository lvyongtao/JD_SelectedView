//
//  TranslationAnimation.m
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/22.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//
/// 屏幕的宽度/// 屏幕高度
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "TranslationAnimation.h"
#import "SwipGestureTranslaiton.h"

@implementation TranslationAnimation

+ (instancetype)AnimatedWithTransitionType:(AnimatedTransitioningType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(AnimatedTransitioningType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

/**
 *    执行动画类型type
 *
 *
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case AnimatedTransitioningTypePresent:
            [self PresentAnimaiton:transitionContext];
            break;
        case AnimatedTransitioningTypeDismiss:
            [self DismissAnimation:transitionContext];
            break;
        case AnimatedTransitioningTypePush:
            [self PushAnimaiton:transitionContext];
            break;
        case AnimatedTransitioningTypePop:
            [self PopAnimation:transitionContext];
            break;
        default:
            break;
    }
}
/**  Present type
 *
 *
 *  @param transitionContext
 */
- (void)PresentAnimaiton:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    toVC.view.frame = CGRectOffset(finalFrame,WIDTH,HEIGHT);
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    
    
    UIView *containView = [transitionContext containerView];
    [containView addSubview:tempView];
    [containView addSubview:toVC.view];
    
    
    NSTimeInterval duration =[self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration animations:^{
//        toVC.view.frame = finalFrame;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalFrame;
                         toVC.view.center = CGPointMake(WIDTH/2, HEIGHT/2);
//                         toVC.view.transform = CGAffineTransformMakeScale(0.7, 0.7);
                         toVC.view.frame = CGRectMake(0,HEIGHT/3, WIDTH, HEIGHT);
                         tempView.frame = CGRectMake(0, - HEIGHT/3, WIDTH, HEIGHT);
//                         tempView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    //准备切出的VC
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    //准备切入的VC
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    //对切出VC的View截图保存
//    UIView *tempView =[fromVC.view snapshotViewAfterScreenUpdates:YES];
//    //设置frame
//    tempView.frame = fromVC.view.frame;
    //  VC切换view的容器
//    UIView *containView =[transitionContext containerView];
//    
//    [containView addSubview:toVC.view];
//    [containView addSubview:tempView];
    
//    fromVC.view.hidden = YES;
    //将切出的VC显示在最顶层
//    [containView insertSubview:toVC.view atIndex:0];
    
//    CATransform3D transfrom3d = CATransform3DIdentity;
//    transfrom3d.m34 = - 0.002;
//    
//    containView.layer.sublayerTransform = transfrom3d;
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//        
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        if ([transitionContext transitionWasCancelled]) {
//            [tempView removeFromSuperview];
//            fromVC.view.hidden = NO;
//        }
//    }];
    
}
/**
 *  Dismiss type
 *
 *  @param transitionContext
 */
- (void)DismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
  
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = toVC.view.frame;

    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame,WIDTH/2, HEIGHT/2);
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVC.view];
    [containView sendSubviewToBack:toVC.view];
//    tempView.hidden = YES;
    NSTimeInterval duration =[self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVC.view.frame = finalFrame;
                         tempView.hidden = YES;
                         toVC.view.hidden = NO;
//                         tempView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:^(BOOL finished) {
                         
                        
                         NSLog(@"back sucess");
                           [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}

/**
 *  Push type
 *
 *  @param transitionContext
 */
- (void)PushAnimaiton:(id <UIViewControllerContextTransitioning>)transitionContext{
    
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    tempView.frame = [transitionContext initialFrameForViewController:fromVC];
    
    
    
}
/**
 *  Pop type
 *
 *  @param transitionContext
 */
- (void)PopAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
}

@end
