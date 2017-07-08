
#import "LFWaterfallLayout.h"

static const NSInteger LFDefaultColumnCount = 2;//默认的列数
static const CGFloat LFDefaultColumnMargin = 10;//每一列之间的间距
static const CGFloat LFDefaultRowMargin = 10;//每一行之间的间距
static const UIEdgeInsets LFDefaultEdgeInsets = {5,5,5,5};//边缘间距

@interface LFWaterfallLayout (){
    
    bool isHead ;
    
};
/**
 * 存放所有cell的布局属性
 */
@property (nonatomic , strong) NSMutableArray *attrsArray;
/**
 * 存放所有列的当前高度
 */
@property (nonatomic , strong) NSMutableArray *columnHeights;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)endgeInsets;

@end

@implementation LFWaterfallLayout

#pragma mark -- 数据处理 --
- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    }else{
        return LFDefaultRowMargin;
    }
}

- (CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    }else{
        return LFDefaultColumnMargin;
    }
}

- (NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    }else{
        return LFDefaultColumnCount;
    }
}

- (UIEdgeInsets)endgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    }else{
        return LFDefaultEdgeInsets;
    }
    
}

- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

/**
 * 初始化
 */
- (void)prepareLayout{
    [super prepareLayout];
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.endgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0 ;i < count;i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 获取indexPath位置对应cell的属性
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        //头部视图
        UICollectionViewLayoutAttributes * layoutHeader = [UICollectionViewLayoutAttributes   layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
        layoutHeader.frame =CGRectMake(0,0, 320*DEF_Adaptation_Font_x*0.5, 240*DEF_Adaptation_Font*0.5);
        [self.attrsArray addObject:layoutHeader];
        [self.attrsArray addObject:attributes];
    }
}

/**
 * 决定cell的布局
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionView的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    
    // 找出高度最短的那一列
    NSInteger shortestColumn = 0;
    // 找出最小高度
    
    
    NSLog(@"%@",indexPath);
    CGFloat minColumnHeight ;
    
    if(isHead==false && indexPath.row==0){
        minColumnHeight = [self.columnHeights[0] doubleValue]+self.height;

        isHead=true;
    }else if(indexPath.row==0 && isHead==true){
        
        minColumnHeight = [self.columnHeights[0] doubleValue]+self.height;
    }else{
        if(indexPath.row==1||indexPath.row==2){
            minColumnHeight = [self.columnHeights[0] doubleValue]+self.height;
        }else{
            minColumnHeight = [self.columnHeights[0] doubleValue];
        }
        
        
    }

    for (NSInteger i = 1 ; i < self.columnCount; i++) {
        // 取出第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        // 比较大小
        if(indexPath.row==0  ){
            
            shortestColumn = i;
        }else{
            
            if (minColumnHeight > columnHeight) {
                minColumnHeight = columnHeight;
                shortestColumn = i;
            }
            
        }
    }
    // 宽度
    CGFloat width = (collectionViewWidth - self.endgeInsets.left - self.endgeInsets.right - (self.columnCount - 1) *self.columnMargin) / self.columnCount;
    // x坐标
    CGFloat x = self.endgeInsets.left + shortestColumn * (width + self.columnMargin);
    // y坐标
    if(indexPath.row==0 && isHead==true){
        
        x = 5;
    }else if(indexPath.row==1 ){
        
        x =  [UIScreen mainScreen].bounds.size.width/2+5;
    }
    
    
    
    
    CGFloat y = minColumnHeight;
    if (y != self.endgeInsets.top) {
        y += self.rowMargin;
    }
    
    // 高度
    CGFloat height = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:width];
    //设置布局属性的frame
    attributes.frame = CGRectMake(x,y, width, height);
    
    NSLog(@"%f %f",x,y);
    
    
    // 更新高度
    
    self.columnHeights[shortestColumn] = @(CGRectGetMaxY(attributes.frame));
    
    
    return attributes;
}

- (CGSize)collectionViewContentSize{
    
    // 找出最大高度
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1 ; i < self.columnCount; i++) {
        // 取出第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        // 比较大小
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.endgeInsets.bottom);
}

@end






































