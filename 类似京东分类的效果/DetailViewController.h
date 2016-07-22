//
//  DetailViewController.h
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/22.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (copy,nonatomic)void(^Sucess_back)(NSString *nick);


@property (assign, nonatomic) NSInteger tag;

@end
