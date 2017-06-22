//
//  looperListFlowLayout.m
//  Looper
//
//  Created by lujiawei on 21/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperListFlowLayout.h"
@interface looperListFlowLayout ()

//存放每一列的高度
@property (nonatomic, retain) NSMutableArray *columnHeightsArray;

//存放 每一个item的 属性 包含 frame以及下标
@property (nonatomic, retain) NSMutableArray *attributesArray;

@end
@implementation looperListFlowLayout
//获取最小高度的方法
- (CGFloat)minHeight
{
    CGFloat min = 100000;
    for (NSNumber *height in _columnHeightsArray) {
        CGFloat h = [height floatValue];
        if (min > h) {
            min = h;
        }
    }
    return min;
}

//获取最大值
- (CGFloat)maxHeight
{
    CGFloat max = 0;
    for (NSNumber *height in _columnHeightsArray) {
        CGFloat h = [height floatValue];
        if (max < h) {
            max = h;
        }
    }
    return max;
}

//找到最小高的下标
- (NSUInteger)indexOfMinHeight
{
    NSUInteger index = 0;
    for (int i = 0; i < [_columnHeightsArray count]; i ++) {
        CGFloat height = [_columnHeightsArray[i] floatValue];
        if (height == [self minHeight]) {
            index = i;
            return index;
        }
    }
    return index;
}

//重写父类的布局方法
- (void)prepareLayout
{
    [super prepareLayout];
    
    _attributesArray = [[NSMutableArray alloc] init];
    
    _columnHeightsArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfColumn];
    
    //给列高数组里面的对象赋初值
    for (int i = 0; i < self.numberOfColumn; i ++) {
        [_columnHeightsArray addObject:@0.0];
    }
    
    CGFloat totalWidth = self.collectionView.frame.size.width;
    
    //创建 每个item frame中的x、y
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < itemCount; i ++) {
        //得到集合视图中 列间隙的个数
        NSUInteger numberOfSpace = self.numberOfColumn - 1;
        
        //代理对象执行代理方法，得到 item之间的间隙大小
        CGFloat spaceWidth = [_delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:0];
        
        //求每列的宽度，也就是每个item的width
        CGFloat width = (totalWidth - spaceWidth * numberOfSpace) / self.numberOfColumn;
        
        
        //获取每一个itemSize的大小
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //数据中原始图片大小
        CGSize imageSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        //通过 约分公式得到固定宽之后的高度是多少
        CGFloat height = width * imageSize.height / imageSize.width;
        
        
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        //记录每一个item的大小和位置
        attribute.frame = CGRectMake(x, y, width, height);
        
        //数组保存每个item的位置信息
        [_attributesArray addObject:attribute];
        
        NSLog(@"item = %d",i);
        NSLog(@"x = %.2f y = %.2f width = %.2f height = %.2f",x,y,width,height);
        
        //求列高最小的那一列的下标
        NSUInteger minHeightIndex = [self indexOfMinHeight];
        
        //求出最小列的高度
        CGFloat minHeight = [_columnHeightsArray[minHeightIndex] floatValue];
        
        //求出行高
        CGFloat lineHeight = [_delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:0];
        
        //上一次总的列高 加上 行高 加上新加上的item的height，才是现在这一列的总高度
        //minHeight为最小列现在的高度
        //lineHeight为行间距
        //height为新加的item的高
        _columnHeightsArray[minHeightIndex] = [NSNumber numberWithFloat:minHeight + lineHeight + height];
        
        //重新算最小列高的下标
        minHeightIndex = [self indexOfMinHeight];
        
        //算下一次新加的item的x和y值
        x = (spaceWidth + width) * minHeightIndex;
        
        y = [self minHeight];
    }
}

//重写这个方法，可以返回集合视图的总高度
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, [self maxHeight]);
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributesArray;
}
@end
