//
//  ActivityBarrageView.m
//  Looper
//
//  Created by 工作 on 2017/6/19.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityBarrageView.h"
#import "LooperToolClass.h"
#import "ActivityView.h"
#import "UIImageView+WebCache.h"
#import "LooperConfig.h"
#import "looperlistCellCollectionViewCell.h"
#import "sendMessageActivityView.h"
#import "ActivityViewModel.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"

@implementation ActivityBarrageView{
    float labelHeight;
}
-(NSMutableArray *)userImageArr{
    if (!_userImageArr) {
        _userImageArr=[NSMutableArray new];
    }
    return _userImageArr;
}
-(UIView *)showHiddenBuddleView{
    [_showHiddenBuddleView removeFromSuperview];
    if (!_showHiddenBuddleView) {
        _showHiddenBuddleView=[[UIView alloc]init];
        _showHiddenBuddleView.backgroundColor=[UIColor redColor];
       
    }
    return _showHiddenBuddleView;
}
-(NSMutableArray *)allShowTags{
    if (!_allShowTags) {
        _allShowTags=[[NSMutableArray alloc]init];
    }
    return _allShowTags;
}
-(NSMutableArray *)allShowImageTags{
    if (!_allShowImageTags) {
        _allShowImageTags=[NSMutableArray new];
    }
    return _allShowImageTags;
}
-(NSMutableArray *)buddleArr{
    if (!_buddleArr) {
        _buddleArr=[NSMutableArray new];
    }
    return _buddleArr;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)viewModel{
    if (self = [super initWithFrame:frame]) {
        self.obj = (ActivityView*)idObject;
        self.viewModel=viewModel;
        [self createCollectionView];
        [self initailHeaderView];
        [self initailBuddleView];
        self.activityID=[self.obj activityID];
        [self.viewModel setBarrageView:self];
        [self.viewModel getActivityInfoById:self.activityID andUserId:[LocalDataMangaer sharedManager].uid];
        labelHeight=85.0;
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
        [self addSubview:backBtn];
    }
    return self;
    
}

-(void)addImageArray:(NSArray *)imageArray{
    self.barrageInfo=imageArray;
    [self.buddleArr removeAllObjects];
    for (NSDictionary *buddleDic in imageArray) {
        [self.buddleArr   addObject: [buddleDic objectForKey:@"messagecontent"]];
        [self.userImageArr addObject:[buddleDic objectForKey:@"userimage"]];
    }
    [self.collectView reloadData];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        NSLog(@"这是一个发表评论button");
        sendMessageActivityView *view=[[sendMessageActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self.viewModel and:self];
        view.obj=self.viewModel;
        view.barrageView=self;
        [self.viewModel setSendView:view];
        [self.viewModel setBarrageView:self];
        [self addSubview:view];
    }
    if (button.tag>=2000&&button.tag<3000) {
        NSLog(@"这是一个分享button");
        
         [self.viewModel shareH5:self.barrageInfo[button.tag-2000-1]];

    }
    if (button.tag>=5000&&button.tag<6000) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowImageTags addObject:@(button.tag)];
        labelHeight=button.alpha;
        [self.collectView reloadData];
    }
    
    if (button.tag>=3000&&button.tag<4000) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowTags addObject:@(button.tag)];
        labelHeight=button.alpha;
        [self.collectView reloadData];
    }
    if (button.tag<5000&&button.tag>=4000) {
        //在这返回islike和thumbupcount的参数
        if (!button.selected) {
            [button setSelected:YES];
            //从第二个cell开始算的
            [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[button.tag-4000-1]objectForKey:@"messageid"] andActivityID:self.activityID];
        }
        else{
            [button setSelected:NO];
            [self.viewModel thumbActivityMessage:@"0" andUserId:[LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[button.tag-4000-1]objectForKey:@"messageid"] andActivityID:self.activityID];
        }
        
        NSLog(@"这是一个点赞按钮");
    }
   }
- (void)initailHeaderView {
    
    self.headerView = [[UIImageView alloc] init];
    self.headerView.frame = CGRectMake(0, -480*DEF_Adaptation_Font*0.5, [UIScreen mainScreen].bounds.size.width, 480*DEF_Adaptation_Font*0.5);
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:[self.obj objDic][@"activityimage"]]];
    self.headerView.userInteractionEnabled=NO;
    [self.collectView addSubview:self.headerView];
}
- (void)initailBuddleView {
    
    self.buddleView = [[UIImageView alloc] init];
    self.buddleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 480*DEF_Adaptation_Font*0.5);
    self.buddleView.clipsToBounds = YES;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(initDate) userInfo:nil repeats:YES];
    [self addSubview:self.buddleView];
}

//添加弹幕
-(void)initDate
{
    NSArray *danmakus = @[@"我去",
                          @"路见不平",
                          @"拔刀相助",
                          @"额，就是负伤啊",
                          @"错了，那是勇猛无敌",
                          @"哈？！英雄救美呢！！！！！",
                          @"哈哈哈哈。。。",
                          @"你们说错啦，那个坑货！",
                          @"这是一个故事啊！",
                          @"不懂不要乱说",
                          @"额。。。",
                          @"什么情况",
                          @"hello meizi",
                          @"天理难容啊～",
                          @"放开它，让我来",
                          @"nb",
                          @"这样都可以？！",
                          @"看不懂",
                          @"不错不错，有大酱风范～",
                          @"如果有一天。。。",
                          @"我去，天掉下来了",
                          @"都挺好的",
                          @"你们看到后面了吗，貌似有背景呢，哈哈哈哈哈。。。",
                          @"真是，额，强",
                          @"可以可以"];
    if (self.buddleArr.count!=0) {
        danmakus=_buddleArr;
    }
    int count=rand()%danmakus.count;
    NSString *str = [danmakus objectAtIndex:count];
    UILabel *label = [[UILabel alloc]init];
    if (40 - self.collectView.contentOffset.y>160*DEF_Adaptation_Font*0.5) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self), rand()%(int)(40 - self.collectView.contentOffset.y-200*DEF_Adaptation_Font*0.5+2)+80*DEF_Adaptation_Font*0.5, 240, 50*DEF_Adaptation_Font*0.5)];
        label.frame=CGRectMake(55*DEF_Adaptation_Font*0.5, 0, 240, 50*DEF_Adaptation_Font*0.5);
//        label.frame =CGRectMake(DEF_WIDTH(self), rand()%(int)(40 - self.collectView.contentOffset.y-160*DEF_Adaptation_Font*0.5)+80*DEF_Adaptation_Font*0.5, 240, 50*DEF_Adaptation_Font*0.5);
        label.text = str;
        CGRect viewFrame=view.frame;
        viewFrame.size.width=[self widthForString:str andHeight: 200*DEF_Adaptation_Font*0.5 andText:label]*1.5+60*DEF_Adaptation_Font*0.5;
       view.frame=viewFrame;
       view.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
        view.tag=count-1;
        [view addGestureRecognizer:singleTap];
        CGRect frame=label.frame;
        frame.size.width=[self widthForString:str andHeight: 200*DEF_Adaptation_Font*0.5 andText:label]*1.5;
        label.frame=frame;
        label.textAlignment=NSTextAlignmentLeft;
        view.layer.cornerRadius=25*DEF_Adaptation_Font*0.5;
        view.layer.masksToBounds=YES;
        label.textColor =[UIColor whiteColor];
        view.backgroundColor=[self randomColorAndIndex:arc4random_uniform(6) %5];
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5*DEF_Adaptation_Font*0.5, 5*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
        if (self.userImageArr.count) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.userImageArr[count]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        }
        imageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
        imageView.layer.masksToBounds=YES;
        [view addSubview:imageView];
        [view addSubview:label];
        //将label加入本视图中去。
        [self.buddleView addSubview:view];
        [self move:view andHeight:viewFrame.size.width];
    if (40 - self.collectView.contentOffset.y<200*DEF_Adaptation_Font*0.5) {
        [self.buddleView setHidden:YES];
    }
    else{
        [self.buddleView setHidden:NO];
    }
    }
}
//弹幕的点击事件
-(void)onClickView:(UITapGestureRecognizer *)tap{
    NSLog(@"%ld",tap.view.tag);
}

-(void)move:(UIView*)view andHeight:(float )height
{
    int time=0;
    if (height<=DEF_WIDTH(self)/2) {
        time=8;
    }
    else if(height>=DEF_WIDTH(self)/2&&height<=DEF_WIDTH(self)){
        time=(height/DEF_WIDTH(self))*16;
    }
    else{
        time=(height/DEF_WIDTH(self))*10;
    }
//    CABasicAnimation *anim = [CABasicAnimation animation];
//    anim.keyPath = @"position";
//    // 指定动画结束时具体数值
//    // 此处给的一定是对象类型，所以要使用NSValue进行包装
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(-DEF_WIDTH(view), DEF_HEIGHT(view))];
//    // 设置动画时长
//    anim.duration = 4;
//    // 固定动画结束时视图的位置
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    // 动画重复饿次数
//    anim.repeatCount = 1;
//    // 添加动画到层上
//    [view.layer addAnimation:anim forKey:nil];
    [UIView animateWithDuration:time animations:^{
        view.frame = CGRectMake(- view.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }
     ];
    
}
-(NSMutableArray *)colorArr{
    if (!_colorArr) {
        _colorArr=[NSMutableArray new];
        [_colorArr addObject:[UIColor colorWithRed:76/255.0 green:206/255.0 blue:130/255.0 alpha:1.0]];
        [_colorArr addObject:[UIColor colorWithRed:240/255.0 green:139/255.0 blue:158/255.0 alpha:1.0]];
        [_colorArr addObject:[UIColor colorWithRed:211/255.0 green:138/255.0 blue:212/255.0 alpha:1.0]];
        [_colorArr addObject:[UIColor colorWithRed:236/255.0 green:190/255.0 blue:130/255.0 alpha:1.0]];
        [_colorArr addObject:[UIColor colorWithRed:66/255.0 green:188/255.0 blue:197/255.0 alpha:1.0]];
        
    }
    return  _colorArr;
}
-(UIColor *)randomColorAndIndex:(int)index
{
    
    return self.colorArr[index];
}


-(void)createCollectionView{
    //    UICollectionViewFlowLayout *viewlayout=[[UICollectionViewFlowLayout alloc]init];
    //    viewlayout.headerReferenceSize=CGSizeMake(1, 1);
    // 创建布局
    LFWaterfallLayout *flowLayout = [[LFWaterfallLayout alloc] init];
    flowLayout.delegate = self;
    // 创建collecView
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) collectionViewLayout:flowLayout ];
    //注册头视图
    [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewID"];
    //     flowLayout.headerReferenceSize=CGSizeMake(DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5);
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.alwaysBounceVertical = YES;
    _collectView.scrollsToTop = YES;
    //偏移量（预留出顶部图片的位置）
    _collectView.contentInset = UIEdgeInsetsMake(420*DEF_Adaptation_Font*0.5, 0, 0, 0 );
    [_collectView setBackgroundColor:[UIColor colorWithRed:45/255.0 green:20/255.0 blue:53/255.0 alpha:1.0]];
    [_collectView registerClass:[looperlistCellCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    [self addSubview:_collectView];
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderViewID" forIndexPath:indexPath];
        //添加头视图的内容
        [self addContent];
        //头视图添加view
        [header addSubview:self.collectHeaderView];
        return header;
    }
    return nil;
}
/*
 *  补充头部内容
 */
-(void)addContent
{
    self.collectHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 80*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-10, 80*DEF_Adaptation_Font*0.5)];
    label.text=[NSString stringWithFormat:@"【LooperEDM】抖腿大战即将开始,大家一起嗨起来！！！%@",[self.obj objDic][@"activityname"]];
    label.font=[UIFont boldSystemFontOfSize:15];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.textColor=[UIColor whiteColor];
    label.numberOfLines=2;
    [self.collectHeaderView addSubview:label];
  
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 160*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-10, 80*DEF_Adaptation_Font*0.5)];
    label2.text=[NSString stringWithFormat:@"             人已经进入战场\n活动时间%@至%@",[[self.obj objDic][@"startdate"] substringToIndex:10] ,[[self.obj objDic][@"enddate"] substringToIndex:10]];
    label2.font=[UIFont systemFontOfSize:13];
    label2.textColor=[UIColor whiteColor];
    label2.numberOfLines=2;
    [self.collectHeaderView addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, 145*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    label3.text=[NSString stringWithFormat:@"2048"];
    label3.font=[UIFont boldSystemFontOfSize:14];
    label3.textColor=[UIColor yellowColor];
    label3.numberOfLines=1;
    [self.collectHeaderView addSubview:label3];

    
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,  240*DEF_Adaptation_Font*0.5-4, DEF_WIDTH(self), 4)];
    imageView.image=[UIImage imageNamed:@"btn_line.png"];
    [self.collectHeaderView addSubview:imageView];
    self.collectHeaderView.backgroundColor=[UIColor colorWithRed:45/255.0 green:20/255.0 blue:53/255.0 alpha:1.0];
    
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5);
    
    
}

#pragma mark-<UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.barrageInfo.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    looperlistCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellView" forIndexPath:indexPath] ;
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[looperlistCellCollectionViewCell alloc]init];
    }else{
        
    }
    cell.layer.cornerRadius=4.0;
    cell.layer.masksToBounds=YES;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UIButton *button= [LooperToolClass createBtnImageNameReal:@"writeBuddle.png" andRect:CGPointMake(0, 0) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(DEF_WIDTH(self)/2-10, DEF_WIDTH(self)/2-10) andTarget:self];
            [cell.contentView addSubview:button];
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
            [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:[LocalDataMangaer sharedManager].HeadImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            
            imageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
            imageView.layer.masksToBounds=YES;
            [cell.contentView addSubview:imageView];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 170*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
            label.text=[NSString stringWithFormat:@"%@",[LocalDataMangaer sharedManager].NickName];
            label.font=[UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:label];
            label.textColor=[UIColor whiteColor];
            cell.backgroundColor=[UIColor colorWithRed:45/255.0 green:20/255.0 blue:53/255.0 alpha:1.0];
            return cell;
        }
        //赋值
        if (self.barrageInfo.count) {
            NSDictionary *imageDic=self.barrageInfo[indexPath.row-1];
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"userimage"]]];
            imageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
            imageView.layer.masksToBounds=YES;
            //加入点击事件
            imageView.userInteractionEnabled=YES;
            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
            imageView.tag=indexPath.row-1;
            [imageView addGestureRecognizer:singleTap];
            [cell.contentView addSubview:imageView];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)-90)*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
            label.font=[UIFont boldSystemFontOfSize:14];
            label.textColor=[UIColor whiteColor];
            label.text=[imageDic objectForKey:@"username"];
            [cell.contentView addSubview:label];
            cell.backgroundColor =[self randomColorAndIndex:indexPath.row%5];
            UIButton *button= [LooperToolClass createBtnImageNameReal:@"btn_looper_share.png" andRect:CGPointMake(cell.frame.size.width-5-40*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-40*DEF_Adaptation_Font*0.5) andTag:(int)(2000+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
            [cell.contentView addSubview:button];
            UIButton *commendBtn= [LooperToolClass createBtnImageNameReal:@"commendNO.png" andRect:CGPointMake(5, cell.frame.size.height-45*DEF_Adaptation_Font*0.5) andTag:(int)(4000+indexPath.row) andSelectImage:@"commendYes.png" andClickImage:@"commendYes.png" andTextStr:nil andSize:CGSizeMake(35*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5) andTarget:self];
            if ([imageDic[@"isthumb"]intValue]==1) {
                [commendBtn setSelected:YES];
            }
            [cell.contentView addSubview:commendBtn];
            UILabel *commendLB=[[UILabel alloc]initWithFrame:CGRectMake(10+30*DEF_Adaptation_Font*0.5,cell.frame.size.height-5-30*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
            commendLB.font=[UIFont boldSystemFontOfSize:13];
            commendLB.textColor=[UIColor whiteColor];
            commendLB.text=[NSString stringWithFormat:@"%@赞",imageDic[@"thumbupcount"]];
            [cell.contentView addSubview:commendLB];
            
            //在这边判断是否有图片
            if ([imageDic objectForKey:@"messagePicture"]==[NSNull null]||[[imageDic objectForKey:@"messagePicture"]isEqualToString:@""]) {
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), DEF_WIDTH(self)/2-10-100*DEF_Adaptation_Font*0.5)];
                label2.textAlignment=NSTextAlignmentCenter;
                label2.text=imageDic[@"messagecontent"];
                //        label2.text=[NSString stringWithFormat:@"说点什么...这好似一串很长很长的字符串。。。我也不知道要说啥。就先这样测试一下.还不够长，这TM写的竟然还不够长，非叫我我合reifhwe  wfkwejfnewkfkfwnfew"];
                float  label2Height= [self heightForString:label2.text andWidth:(DEF_WIDTH(self)/2-50*DEF_Adaptation_Font*0.5) andText:label2];
                label2.font=[UIFont boldSystemFontOfSize:14];
                label2.textColor=[UIColor whiteColor];
                [cell.contentView addSubview:label2];
                label2.numberOfLines=0;
                if (label2Height>85.0) {
                    label2.numberOfLines=5;
                }
                UIButton *allShowBtn= [LooperToolClass createBtnImageNameReal:@"backView.png" andRect:CGPointMake(cell.frame.size.width/2-5-20*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-40*DEF_Adaptation_Font*0.5) andTag:(int)(3000+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
                allShowBtn.alpha=label2Height;
                [cell.contentView addSubview:allShowBtn];
                //用于消除allShowBtn
                for (NSNumber *tag in self.allShowTags) {
                    if ([tag intValue]==indexPath.row+3000) {
                        [allShowBtn removeFromSuperview];
                        [self layoutSubviewsandCell:cell AndLabelHeight:label2Height];
                        CGRect frame=label2.frame;
                        frame.size.height=label2Height+20*DEF_Adaptation_Font*0.5;
                        label2.frame=frame;
                        label2.numberOfLines=0;
                        [cell layoutIfNeeded];
                    }
                }
                if (label2Height<=85.0) {
                    [allShowBtn removeFromSuperview];
                }
            }else{
                //在这里添加有imageView的情况
                UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), 80*DEF_Adaptation_Font*0.5)];
                [imageV sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"messagePicture"]]];
                imageV.contentMode =  UIViewContentModeScaleAspectFill;
                imageV.clipsToBounds  = YES;
                [cell.contentView addSubview:imageV];
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 135*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), DEF_WIDTH(self)/2-10-185*DEF_Adaptation_Font*0.5)];
                label2.textAlignment=NSTextAlignmentCenter;
                label2.text=imageDic[@"messagecontent"];
                float  label2Height= [self heightForString:label2.text andWidth:(DEF_WIDTH(self)/2-50*DEF_Adaptation_Font*0.5) andText:label2];
                label2.font=[UIFont boldSystemFontOfSize:14];
                label2.textColor=[UIColor whiteColor];
                [cell.contentView addSubview:label2];
                label2.numberOfLines=0;
                if (label2Height>45.0) {
                    label2.numberOfLines=3;
                }
                UIButton *allShowBtn= [LooperToolClass createBtnImageNameReal:@"backView.png" andRect:CGPointMake(cell.frame.size.width/2-5-20*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-40*DEF_Adaptation_Font*0.5) andTag:(int)(5000+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
                allShowBtn.alpha=label2Height;
                [cell.contentView addSubview:allShowBtn];
                //用于修改image和label的frame
                for (NSNumber *tag in self.allShowImageTags) {
                    if ([tag intValue]==indexPath.row+5000) {
                        [allShowBtn removeFromSuperview];
                        CGRect frame=label2.frame;
                        frame.size.height=label2Height+20*DEF_Adaptation_Font*0.5;
                        frame.origin.y=55*DEF_Adaptation_Font*0.5+ (DEF_WIDTH(self)/2-20);
                        label2.frame=frame;
                        label2.numberOfLines=0;
                        CGRect frame2=imageV.frame;
                        frame2.size.height=(DEF_WIDTH(self)/2-20);
                        imageV.frame=frame2;
                        [cell layoutIfNeeded];
                    }
                }
                
            }
        }
        return cell;
        
        //下面是section：1
    }else{
        return cell;
    }
}
-(void)onClickImage:(UITapGestureRecognizer *)tap{
    //点击头像跳转
    NSDictionary *imageDic=self.barrageInfo[tap.view.tag];
    NSString *userid=[imageDic objectForKey:@"userid"];
    [self.viewModel jumpToAddUserInfoVC:userid];
    NSLog(@"%ld",tap.view.tag);
    
}
- (float) heightForString:(NSString *)value andWidth:(float)width andText:(UILabel *)label{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    label.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height+16.0;
}
- (float) widthForString:(NSString *)value andHeight:(float)height andText:(UILabel *)label{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    label.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(MAXFLOAT, height) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.width;
}
//定义每个UICollectionViewCell 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0) {
//        return CGSizeMake(DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5);
//    }
//    for (NSNumber *tag in self.allShowTags) {
//        if ([tag intValue]==indexPath.row+3000) {
//           return CGSizeMake(DEF_WIDTH(self)/2-10,DEF_WIDTH(self)/2-10+labelHeight-85.0+20);
//        }
//    }
//    for (NSNumber *tag in self.allShowImageTags) {
//        if ([tag intValue]==indexPath.row+5000) {
//            return CGSizeMake(DEF_WIDTH(self)/2-10,DEF_WIDTH(self)/2-10+labelHeight-85.0+20+ (DEF_WIDTH(self)/2-20));
//        }
//    }
//    return CGSizeMake(DEF_WIDTH(self)/2-10,DEF_WIDTH(self)/2-10);
//}
#pragma mark -- LFWaterfallLayoutDelegate --
- (CGFloat)waterflowLayout:(LFWaterfallLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    for (NSNumber *tag in self.allShowTags) {
        if ([tag intValue]==index+3000) {
            return DEF_WIDTH(self)/2-10+labelHeight-85.0+20;
        }
    }
    for (NSNumber *tag in self.allShowImageTags) {
        if ([tag intValue]==index+5000) {
            return DEF_WIDTH(self)/2-10+labelHeight-85.0+20+ (DEF_WIDTH(self)/2-20);
        }
    }
    NSLog(@"index %ld",index);
    return DEF_WIDTH(self)/2-10;
    
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}

//这个cell的contentView改变没有用
- (void)layoutSubviewsandCell:(looperlistCellCollectionViewCell*)cell  AndLabelHeight:(float)label2Height{
    [super layoutSubviews];
    //    CGRect cellFrame=cell.contentView.frame;
    //    cellFrame.size.height=DEF_WIDTH(self)/2-10+label2Height-85.0;
    //    cell.contentView.frame=cellFrame;
   //cell.backgroundColor=[UIColor greenColor];
}

#pragma mark - < UITableViewDelegate >
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGRect newFrame = self.headerView.frame;
//    CGFloat settingViewOffsetY = 50 - scrollView.contentOffset.y;
//    //    CGPoint point =  [scrollView.panGestureRecognizer translationInView:self];
//NSLog(@"scrollViewContent:%f==%f===%f",scrollView.contentOffset.y,settingViewOffsetY,250*DEF_Adaptation_Font*0.5);
//    newFrame.size.height = settingViewOffsetY;
//        if (settingViewOffsetY <=50*DEF_Adaptation_Font*0.5) {
//            newFrame.size.height =50*DEF_Adaptation_Font*0.5;
//        }
//    if (settingViewOffsetY<=400*DEF_Adaptation_Font*0.5) {
//        //        self.settingView.contentInset = UIEdgeInsetsMake(settingViewOffsetY, 0, 0, 0);
//        self.collectView.contentInset = UIEdgeInsetsMake(settingViewOffsetY, 0, 0, 0);
//        
//    }else{
//     self.collectView.contentInset = UIEdgeInsetsMake(400*DEF_Adaptation_Font*0.5, 0, 0, 0);
//    }
//    self.headerView.frame = newFrame;
    CGFloat yOffset  = scrollView.contentOffset.y;
    NSLog(@"yOffset===%f",yOffset);
    CGFloat xOffset = (yOffset +400*DEF_Adaptation_Font*0.5)/2;
    
    if(yOffset < -400*DEF_Adaptation_Font*0.5) {
        CGRect f =self.headerView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        f.origin.x= xOffset;
        //int abs(int i); // 处理int类型的取绝对值
        //double fabs(double i); //处理double类型的取绝对值
        //float fabsf(float i); //处理float类型的取绝对值
        f.size.width=DEF_WIDTH(self) + fabs(xOffset)*2;
        
        self.headerView.frame= f;
       
    }
    else{
     CGRect f2 =self.buddleView.frame;
        f2.size.height=-yOffset+80*DEF_Adaptation_Font*0.5;
        if (-yOffset<=-30) {
            f2.size.height=30;
        }
         self.buddleView.frame=f2;
    }
    NSLog(@"总长度:%f,加上的长度:%f", 40 - self.collectView.contentOffset.y-160*DEF_Adaptation_Font*0.5,80*DEF_Adaptation_Font*0.5);
}

@end
