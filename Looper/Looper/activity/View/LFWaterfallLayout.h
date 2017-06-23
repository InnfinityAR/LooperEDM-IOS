

#import <UIKit/UIKit.h>
@class LFWaterfallLayout;

@protocol LFWaterfallLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(LFWaterfallLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
//列的数量
- (CGFloat)columnCountInWaterflowLayout:(LFWaterfallLayout *)waterflowLayout;
//列的边缘
- (CGFloat)columnMarginInWaterflowLayout:(LFWaterfallLayout *)waterflowLayout;
//行的边缘
- (CGFloat)rowMarginInWaterflowLayout:(LFWaterfallLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(LFWaterfallLayout *)waterflowLayout;
@end

@interface LFWaterfallLayout : UICollectionViewLayout

@property (nonatomic , weak) id<LFWaterfallLayoutDelegate> delegate;

@end












