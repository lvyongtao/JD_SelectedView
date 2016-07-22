//
//  CollectionViewCell.h
//  类似京东分类的效果
//
//  Created by user on 16/5/19.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *introduce;

@end
