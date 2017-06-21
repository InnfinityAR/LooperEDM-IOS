//
//  ActivityBarrageView.h
//  Looper
//
//  Created by 工作 on 2017/6/19.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewModel.h"
@interface ActivityBarrageView : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)viewModel;
@property(nonatomic,strong)UIImageView  *headerView;
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UIImageView *buddleView;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSString *activityID;
@property(nonatomic,strong)id viewModel;
@property(nonatomic,strong)NSMutableArray  *allShowTags;
-(void)addImageArray:(NSArray *)imageArray;
@property(nonatomic,strong)NSArray *barrageInfo;
@property(nonatomic,strong)NSMutableArray *buddleArr;
@end
