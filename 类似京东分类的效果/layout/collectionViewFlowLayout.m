//
//  collectionViewFlowLayout.m
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
#import "collectionViewFlowLayout.h"

@implementation collectionViewFlowLayout

- (instancetype)init{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(cellWidth, cellHeight);
        self.headerReferenceSize = CGSizeMake(screenWidth, verticallyPadding);
      
        self.sectionHeadersPinToVisibleBounds = YES;
        self.sectionFootersPinToVisibleBounds = YES;
    }
    return self;
}


- (void)prepareLayout{
    [super prepareLayout];
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *attItems = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *att in attItems) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:att attachedToAnchor:att.center];
            spring.length = 0;
            spring.damping = 0.5;
            spring.frequency = 0.8;
            [_animator addBehavior:spring];
        }
    }
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    //Get the touch point
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in _animator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 500;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[spring.items objectAtIndex:0] ;
        CGPoint center = item.center;
        
        //In case the added value bigger than the scrollDelta, which leads an unreasonable effect
        center.y += (scrollDelta > 0) ? MIN(scrollDelta, scrollDelta * scrollResistance)
        : MAX(scrollDelta, scrollDelta * scrollResistance);
        item.center = center;
        
        [_animator updateItemUsingCurrentState:item];
    }
    return NO;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return [_animator itemsInRect:rect];
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_animator layoutAttributesForCellAtIndexPath:indexPath];
}


@end
