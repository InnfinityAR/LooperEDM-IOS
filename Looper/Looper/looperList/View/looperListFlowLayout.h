//
//  looperListFlowLayout.h
//  Looper
//
//  Created by lujiawei on 21/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class looperListFlowLayout;
@protocol WaterFlowLayoutDelegate<NSObject>
//关键方法，此方法的作用是返回每一个item的size大小
//数据中原始图片大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(looperListFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(looperListFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//得到 item之间的间隙大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(looperListFlowLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(looperListFlowLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
@end
@interface looperListFlowLayout : UICollectionViewFlowLayout
//瀑布流一共多少列
@property (nonatomic, assign) NSUInteger numberOfColumn;

@property (nonatomic, assign) id<WaterFlowLayoutDelegate>delegate;
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//
//
//
//}
//
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
//
//
//
//
//
//}
//
//
//
//- (CGSize)collectionViewContentSize{
//
//
//
//
//
//}

@end
