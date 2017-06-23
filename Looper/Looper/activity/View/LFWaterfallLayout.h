

#import <UIKit/UIKit.h>
<<<<<<< HEAD
#import "LooperConfig.h"
=======
>>>>>>> f4d45b43d49275aeba6cf8d791d4b9a2c4a24abc
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

<<<<<<< HEAD
@interface LFWaterfallLayout : UICollectionViewFlowLayout
=======
@interface LFWaterfallLayout : UICollectionViewLayout
>>>>>>> f4d45b43d49275aeba6cf8d791d4b9a2c4a24abc

@property (nonatomic , weak) id<LFWaterfallLayoutDelegate> delegate;

@end












