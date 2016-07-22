//
//  TranslationAnimation.h
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/22.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimatedTransitioningType){
    AnimatedTransitioningTypePresent = 0,
    AnimatedTransitioningTypeDismiss,
    AnimatedTransitioningTypePush,
    AnimatedTransitioningTypePop
};

@interface TranslationAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)AnimatedWithTransitionType:(AnimatedTransitioningType)type;
- (instancetype)initWithTransitionType:(AnimatedTransitioningType)type;

@property (assign , nonatomic) AnimatedTransitioningType type;


@end
