//
//  ActivityBarrageView.h
//  Looper
//
//  Created by 工作 on 2017/6/19.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewModel.h"
#import "LFWaterfallLayout.h"
@interface ActivityBarrageView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,LFWaterfallLayoutDelegate,UICollectionViewDelegateFlowLayout>
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)viewModel;
@property(nonatomic,strong)UIImageView  *headerView;
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UIImageView *buddleView;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSString *activityID;
@property(nonatomic,strong)NSDictionary *activityDIc;
@property(nonatomic,strong)id viewModel;
@property(nonatomic,strong)NSMutableArray  *allShowTags;
@property(nonatomic,strong)NSMutableArray *allShowImageTags;
-(void)addImageArray:(NSArray *)imageArray;
@property(nonatomic,strong)NSArray *barrageInfo;
@property(nonatomic,strong)NSMutableArray *buddleArr;
@property(nonatomic,strong)NSMutableArray *userImageArr;
@property(nonatomic,strong)NSMutableArray *colorArr;
@property(nonatomic,strong)UIView *collectHeaderView;
@property(nonatomic,strong)UIView *showHiddenBuddleView;
//用于添加实时弹幕
@property(nonatomic,strong)NSMutableArray *barrageArr;
//用于弹幕轨道
@property(nonatomic,strong)NSMutableArray *buddleCountArr;
@end
