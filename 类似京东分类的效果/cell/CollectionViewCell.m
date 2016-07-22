//
//  CollectionViewCell.m
//  类似京东分类的效果
//
//  Created by user on 16/5/19.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
    // Initialization code
//    [self.contentView addSubview:self.image];
//    [self.contentView addSubview:self.introduce];
}


@end
