//
//  YXBJFCollectionViewFlowLayout.m
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/22.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//
#define SpringFactor 10.0
#define horizonallyPadding 10
#define verticallyPadding 10

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define cellWidth screenWidth - 2 * horizonallyPadding
#define cellHeight 110
#import "YXBJFCollectionViewFlowLayout.h"

@implementation YXBJFCollectionViewFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(cellWidth, cellHeight);
        self.headerReferenceSize = CGSizeMake(screenWidth, verticallyPadding);
        
      
    }
    return self;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
};

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
        CGFloat offsetY = self.collectionView.contentOffset.y;
        CGFloat collectionViewFrameHeight = self.collectionView.bounds.size.height;
        CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
        NSArray *attArray = [super layoutAttributesForElementsInRect:rect];
        CGFloat scrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
        CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - scrollViewContentInsetBottom;
        NSInteger numSection = [self.collectionView numberOfItemsInSection:0];
    
    
        for (UICollectionViewLayoutAttributes *att in attArray) {
            if (att.representedElementCategory == UICollectionElementCategoryCell) {
                CGRect cellRect = att.frame;
                if (offsetY <= 0) {
                    
                    CGFloat distance = fabs(offsetY)/ SpringFactor;
                    cellRect.origin.y += offsetY + distance *(att.indexPath.row + 1);
    
                }else if (bottomOffset >= 0){
                    CGFloat distance = bottomOffset/ SpringFactor;
                    cellRect.origin.y += bottomOffset - distance * (numSection - att.indexPath.row);
                }
                att.frame = cellRect;
               // if (att == [attArray firstObject]) {
                 // NSLog(@"----%.1f",att.frame.origin.y);
                //}
               
                
            }
        }
        return attArray;
    
}
@end
