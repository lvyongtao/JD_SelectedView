//
//  SwipGestureTranslaiton.h
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/24.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PanGestureRecognizerDirection) {
    PanGestureRecognizerDirectionUp = 0,
    PanGestureRecognizerDirectionLeft,
    PanGestureRecognizerDirectionDown,
    PanGestureRecognizerDirectionRight
};
@interface SwipGestureTranslaiton : UIPercentDrivenInteractiveTransition


//判断是否手势触发返回操作
@property (assign, nonatomic) BOOL GestureSwip;


@property (assign, nonatomic) BOOL isCancle;

- (void)addGestureWithViewController:(UIViewController *)viewController;


@end
