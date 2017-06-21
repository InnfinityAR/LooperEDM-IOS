//
//  ActivityBarrageView.h
//  Looper
//
//  Created by 工作 on 2017/6/19.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ActivityBarrageView : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject;
@property(nonatomic,strong)UIImageView  *headerView;
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UIImageView *buddleView;
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)NSMutableArray  *allShowTags;
@end
