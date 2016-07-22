//
//  SwipGestureTranslaiton.m
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/24.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//
/// 屏幕的宽度/// 屏幕高度
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


#define completePercent 0.5
#import "SwipGestureTranslaiton.h"

@interface SwipGestureTranslaiton ()

@property (assign, nonatomic) BOOL isComplete;

@property (strong, nonatomic) UIViewController *viewController;

@property (assign, nonatomic) PanGestureRecognizerDirection direction;

@end

@implementation SwipGestureTranslaiton



- (void)addGestureWithViewController:(UIViewController *)viewController{
    self.viewController = viewController;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
}

-(CGFloat)completionSpeed{
    
    return 1 - self.percentComplete;
}

- (UIViewAnimationCurve )completionCurve{
    
    return UIViewAnimationCurveEaseOut;
}
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    
    
    
    
    
    CGPoint tapPoint = [panGesture translationInView:panGesture.view.superview];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.GestureSwip = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            
            break;
        case UIGestureRecognizerStateChanged:
            
            [self setPercentValueWithPoint:tapPoint];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            self.GestureSwip = NO;
            if (!self.isComplete || panGesture.state == UIGestureRecognizerStateCancelled) {
                NSLog(@"---->cancle");
                _isCancle = YES;
                [self cancelInteractiveTransition];
            }else{
                _isCancle = NO;
                [self finishInteractiveTransition];
                NSLog(@"---->sucess");
            }
            break;
            
        default:
            break;
    }
    
    
}

- (void)setPercentValueWithPoint:(CGPoint)tapPoint{
    
    //由用户名的选择性控制
    CGFloat percentX = tapPoint.x / 50.0;
    
    percentX = fminf(fmaxf(percentX, 0.0), 1.0);
    
    CGFloat percent = tapPoint.y / 100.0;
    
    percent = fminf(fmaxf(percent, 0.0), 1.0);
    self.isComplete = percent > completePercent || percentX > completePercent;
    [self updateInteractiveTransition:percent];
    NSLog(@"---------->%f",tapPoint.y);
    NSLog(@"----->%f",percent);
    
}

@end
