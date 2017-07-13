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
#import "ActivityCollectionViewCell.h"
#import "sendMessageActivityView.h"
#import "ActivityViewModel.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YWCarouseView.h"
#define BUTTONTAG  10000
@interface ActivityBarrageView()
{
    float headViewHeight;
    LFWaterfallLayout *waterLayout;
}
@property(nonatomic,retain) MPMoviePlayerController *movieController;
@property (nonatomic, strong) YWCarouseView * carouseView;
@property(nonatomic,strong)NSMutableArray * imageNameArray;
@property(nonatomic,strong)NSMutableArray *viewArr;

@end
@implementation ActivityBarrageView{
    float labelHeight;
    //多线程
    NSThread *_thread;
}
-(NSMutableDictionary *)heightDic{
    if (!_heightDic) {
        _heightDic=[NSMutableDictionary dictionary];
    }
    return _heightDic;
}
-(NSMutableArray *)viewArr{
    if (!_viewArr) {
        _viewArr=[NSMutableArray array];
    }
    return _viewArr;
}
-(NSMutableArray *)barrageArr{
    if (!_barrageArr) {
        _barrageArr=[NSMutableArray new];
    }
    return _barrageArr;
}
-(NSMutableArray *)buddleCountArr{
    if (!_buddleCountArr) {
        _buddleCountArr=[NSMutableArray new];
        for (int i=0; i<8; i++) {
            [_buddleCountArr addObject:@(i)];
        }
    }
    return _buddleCountArr;
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
        _allShowTags=[[NSMutableArray alloc]initWithCapacity:50];
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
        self.activityID=[self.obj activityID];
        self.activityDIc=[self.obj activityDic];
        [self.viewModel getActivityInfoById:self.activityID andUserId:[LocalDataMangaer sharedManager].uid];        
        [self createCollectionView];
        [self initailHeaderView];
        [self initailBuddleView];
        
        [self.viewModel setBarrageView:self];
        
        labelHeight=85.0;
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
        [self addSubview:backBtn];
    }
    return self;
}
-(void)startTimer{
  NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(initDateBarrage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop] run];
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
        [self.movieController stop];
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
    if (button.tag>=2*BUTTONTAG&&button.tag<2*BUTTONTAG+self.barrageInfo.count+10) {
        NSLog(@"这是一个分享button");
        
        [self.viewModel shareH5:self.barrageInfo[button.tag-2*BUTTONTAG-1]];
        
    }
    if (button.tag>=5*BUTTONTAG&&button.tag<5*BUTTONTAG+self.barrageInfo.count+10) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowImageTags addObject:@(button.tag)];
        labelHeight=button.alpha;
        [self.heightDic setObject:@(labelHeight) forKey:@(button.tag-5*BUTTONTAG)];
        if (button.tag-5*BUTTONTAG==1) {
            waterLayout.secondCellHeight= DEF_WIDTH(self)/2-10+(labelHeight-85.0)*DEF_Adaptation_Font+ (DEF_WIDTH(self)/2-10)-60*DEF_Adaptation_Font*0.5;
        }
        [self.collectView reloadData];
    }
    
    if (button.tag>=3*BUTTONTAG&&button.tag<3*BUTTONTAG+self.barrageInfo.count+10) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowTags addObject:@(button.tag)];
        labelHeight=button.alpha;
         [self.heightDic setObject:@(labelHeight) forKey:@(button.tag-3*BUTTONTAG)];
        if (button.tag-3*BUTTONTAG==1) {
            waterLayout.secondCellHeight=DEF_WIDTH(self)/2-10+labelHeight-85.0+20*DEF_Adaptation_Font*0.5;;
        }
        [self.collectView reloadData];
    }
    if (button.tag<4*BUTTONTAG+self.barrageInfo.count+10&&button.tag>=4*BUTTONTAG) {
        //在这返回islike和thumbupcount的参数
        if (!button.selected) {
            [button setSelected:YES];
            //从第二个cell开始算的
            [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[button.tag-4*BUTTONTAG-1]objectForKey:@"messageid"] andActivityID:self.activityID];
            [self.allShowTags removeAllObjects];
            [self.allShowImageTags removeAllObjects];
        }
        else{
            [button setSelected:NO];
            [self.viewModel thumbActivityMessage:@"0" andUserId:[LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[button.tag-4*BUTTONTAG-1]objectForKey:@"messageid"] andActivityID:self.activityID];
            [self.allShowTags removeAllObjects];
            [self.allShowImageTags removeAllObjects];
        }
        
        NSLog(@"这是一个点赞按钮");
    }
}
- (void)initailHeaderView {
    
    self.headerView = [[UIImageView alloc] init];
    
    self.headerView.frame = CGRectMake(0, -450*DEF_Adaptation_Font*0.5, [UIScreen mainScreen].bounds.size.width, 530*DEF_Adaptation_Font*0.5);
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerView.clipsToBounds=YES;
    if ([self.activityDIc[@"activityimage"]isKindOfClass:[NSNull class]]) {
        self.headerView.image=[UIImage imageNamed:@"bk_front_login.png"];
    }else{
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.activityDIc[@"activityimage"]]];
        
    }
    //加入播放视频
    if (0) {
        [self addAVPlayer];
    }
    self.headerView.userInteractionEnabled=YES;
    [self.collectView addSubview:self.headerView];
}
-(void)addAVPlayer {
    NSString *videoPath=@"http://flv2.bn.netease.com/videolib3/1510/25/bIHxK3719/SD/bIHxK3719-mobile.mp4";
    //    NSURL *videoUrl = [[NSBundle mainBundle]URLForResource:@"clear" withExtension:@"mp4"];//定位资源clear.mp4
    self.movieController = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:videoPath]];//初始化movieController
    [self.movieController.view setFrame:CGRectMake(0, 0, DEF_WIDTH(self), 530*DEF_Adaptation_Font*0.5)];//movieController视图的大小
    [self.movieController setRepeatMode:MPMovieRepeatModeOne];//重复方式
    [self.movieController setScalingMode:MPMovieScalingModeAspectFill];//缩放方式满屏
    [self.movieController play];//播放
    [self.headerView addSubview:self.movieController.view];//添加
    
    
}
- (void)initailBuddleView {
    
    self.buddleView = [[UIImageView alloc] init];
    self.buddleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500*DEF_Adaptation_Font*0.5);
    self.buddleView.clipsToBounds = YES;
    
    NSTimer *timer=  [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(initDate) userInfo:nil repeats:YES];
    AppDelegate *delegate= (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.timer=timer;
            [self startTimer];
    self.buddleView.userInteractionEnabled=YES;
    [self addSubview:self.buddleView];
}
//添加轨道
-(int)addGuiDao{
    int random=rand()%self.buddleCountArr.count;
    return random;
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
    int randomCount=[self addGuiDao];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self), [self.buddleCountArr[randomCount]intValue]*55*DEF_Adaptation_Font*0.5, 240, 100*DEF_Adaptation_Font*0.5)];
    CGRect viewFrame1=view1.frame;
    viewFrame1.size.width=[self widthForString:str andHeight: 200*DEF_Adaptation_Font*0.5 andText:label]*1.5+60*DEF_Adaptation_Font*0.5;
    if (viewFrame1.size.width<=DEF_WIDTH(self)/2) {
        viewFrame1.size.width+=30*DEF_Adaptation_Font*0.5;
    }
    if (viewFrame1.size.width<=DEF_WIDTH(self)*(3/4)&&viewFrame1.size.width>DEF_WIDTH(self)/2) {
        viewFrame1.size.width+=20*DEF_Adaptation_Font*0.5;
    }
    
    view1.frame=viewFrame1;
    view1.userInteractionEnabled=YES;
    //尝试判断view1在哪个轨迹
    view1.alpha=[self.buddleCountArr[randomCount]intValue]+2;
    if (self.buddleCountArr.count==1) {
        //防止数组没有元素,同时清除后台数据
        for (int i = 0; i<self.buddleView.subviews.count; i++) {
            UIView *sub = self.buddleView.subviews[i];
            [sub removeFromSuperview];
        }
        self.buddleCountArr=nil;
    }
    else{
        [self.buddleCountArr removeObjectAtIndex:randomCount];
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 50*DEF_Adaptation_Font*0.5, DEF_WIDTH(view1), 50*DEF_Adaptation_Font*0.5)];
    label.frame=CGRectMake(55*DEF_Adaptation_Font*0.5, 0, 240, 50*DEF_Adaptation_Font*0.5);
    //        label.frame =CGRectMake(DEF_WIDTH(self), rand()%(int)(40 - self.collectView.contentOffset.y-160*DEF_Adaptation_Font*0.5)+80*DEF_Adaptation_Font*0.5, 240, 50*DEF_Adaptation_Font*0.5);
    label.text = str;
    CGRect viewFrame=view.frame;
    viewFrame.size.width=view1.frame.size.width;
    view.frame=viewFrame;
    
    //给view添加pan手势
    view.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [view addGestureRecognizer:singleTap];
    
    //给view1添加swipe手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp; //默认向上
    [view1 addGestureRecognizer:swipeGesture];
    
    view.backgroundColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5];
    //        view.backgroundColor=[self randomColorAndIndex:arc4random_uniform(6) %5];
    // 弹幕点赞
    if (self.barrageInfo.count) {
        if ([self.barrageInfo[count][@"isthumb"]intValue]==1) {
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(view1)/2-20, 5*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
            view.tag=count;
            view1.tag=count-1;
            imageV.tag=count-BUTTONTAG;
            imageV.image=[UIImage imageNamed:@"commendYes2.png"];
            [view1 addSubview:imageV];
            view.backgroundColor=[UIColor colorWithRed:193/255.0 green:216/255.0 blue:76/255.0 alpha:1.0];
        }
        else{
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(5*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
            imageV.image=[UIImage imageNamed:@"commendYes2.png"];
            view.tag=-count;
            view1.tag=-count-1;
            imageV.tag=-count-BUTTONTAG;
            [view1 addSubview:imageV];
        }
    }
    CGRect frame=label.frame;
    frame.size.width=[self widthForString:str andHeight: 200*DEF_Adaptation_Font*0.5 andText:label]*1.5;
    label.frame=frame;
    label.textAlignment=NSTextAlignmentLeft;
    view.layer.cornerRadius=25*DEF_Adaptation_Font*0.5;
    view.layer.masksToBounds=YES;
    label.textColor =[UIColor whiteColor];
    
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
    [view1 addSubview:view];
    [self.buddleView addSubview:view1];
    //    self.buddleView.alpha=0.9;
    //        [self move:view1 andHeight:viewFrame.size.width];
    [self.barrageArr addObject:view1];
    
    
}
//轻扫手势
-(void)swipeGesture:(UISwipeGestureRecognizer *)swipe{
    UIImageView *imageV=  (UIImageView *)[swipe.view viewWithTag:(swipe.view.tag-BUTTONTAG+1)];
    UIView *view=(UIView *)[swipe.view viewWithTag:(swipe.view.tag+1)];
    NSLog(@"view1:%ld, view: %ld ,imageV :%ld",swipe.view.tag,view.tag,imageV.tag);
    [view setBackgroundColor:[UIColor colorWithRed:193/255.0 green:216/255.0 blue:76/255.0 alpha:1.0]];
    if (view.tag<0) {
        [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[-view.tag]objectForKey:@"messageid"] andActivityID:self.activityID];
    }
    view.tag=-view.tag;
    imageV.tag=view.tag-BUTTONTAG;
    //点赞按钮向上运动的动画
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)/2-40*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    [self.buddleView addSubview:imageView];
    imageView.image=[UIImage imageNamed:@"icon_looper_goodA1"];
    [UIView animateWithDuration:2 animations:^{
        CGRect frame=imageView.frame;
        frame = CGRectMake(DEF_WIDTH(self)/2-40*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5);
        imageView.frame=frame;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }
     ];
}

//弹幕的点击事件
-(void)onClickView:(UITapGestureRecognizer *)tap{
    UIImageView *imageV=  (UIImageView *)[self viewWithTag:(tap.view.tag-BUTTONTAG)];
    NSLog(@"打印一下imageView %ld view %ld的tag值",(long)imageV.tag,tap.view.tag);
    if (tap.view.tag<0) {
        [tap.view setBackgroundColor:[UIColor colorWithRed:193/255.0 green:216/255.0 blue:76/255.0 alpha:1.0]];
        [UIView animateWithDuration:0.1 animations:^{
            imageV.frame = CGRectMake(DEF_WIDTH(tap.view)/2-20, 5*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5);
        } completion:^(BOOL finished) {
        }
         ];
        [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[-tap.view.tag]objectForKey:@"messageid"] andActivityID:self.activityID];
        
    }
    //已经点赞
    if (tap.view.tag>0) {
        [UIView animateWithDuration:0.1 animations:^{
            imageV.frame = CGRectMake(5*DEF_Adaptation_Font*0.5, 55*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5);
        } completion:^(BOOL finished) {
        }
         ];
        //        [tap.view setBackgroundColor:[self randomColorAndIndex:arc4random_uniform(6) %5]];
        tap.view.backgroundColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.4];
        [self.viewModel thumbActivityMessage:@"0" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[tap.view.tag]objectForKey:@"messageid"] andActivityID:self.activityID];
    }
    tap.view.tag=-tap.view.tag;
    imageV.tag=tap.view.tag-BUTTONTAG;
    [self.collectView reloadData];
    
}
-(void)initDateBarrage{
    if (self.barrageArr.count) {
        for (int i=0;i<self.barrageArr.count;i++) {
            UIView *view=self.barrageArr[i];
            //x+buddleView.width<self.width/2），则把返回给self.buddleCount
            if (DEF_X(view)+DEF_WIDTH(view)<DEF_WIDTH(self)-20&&view.alpha!=1) {
                //                 NSLog(@"view所在弹幕的位置%f",view.alpha);
                [self.buddleCountArr addObject:@((int)view.alpha-2)];
                view.alpha=1;
            }
            //用于移动弹幕
            CGRect frame = view.frame;
            frame.origin.x-=0.5;
            view.frame = frame;
            if (view.center.x<-DEF_WIDTH(view)-DEF_WIDTH(self)) {
                [self.barrageArr removeObject:view];
                [view removeFromSuperview];
            }
            
        }
    }
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
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(15, 150*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 80*DEF_Adaptation_Font*0.5)];
    label2.text=[NSString stringWithFormat:@"%@",[self.activityDIc objectForKey:@"activitydes"]];
    headViewHeight= [self heightForString:label2.text andWidth:( DEF_WIDTH(self)-15) andText:label2];
    waterLayout=flowLayout;
    flowLayout.height=headViewHeight+160*DEF_Adaptation_Font*0.5+4;
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
    _collectView.contentInset = UIEdgeInsetsMake(450*DEF_Adaptation_Font*0.5, 0, 0, 0 );
    [_collectView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:37/255.0 blue:61/255.0 alpha:1.0]];
    [_collectView registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
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
    NSDictionary *message=self.activityDIc[@"message"] ;
    self.collectHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 80*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 80*DEF_Adaptation_Font*0.5)];
    label.text=[NSString stringWithFormat:@"【LooperEDM】嗨起来！！！%@",self.activityDIc[@"activityname"]];
    label.font=[UIFont systemFontOfSize:16];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.textColor=[UIColor whiteColor];
    label.numberOfLines=2;
    [self.collectHeaderView addSubview:label];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(15, 150*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 80*DEF_Adaptation_Font*0.5)];
    label2.text=[NSString stringWithFormat:@"%@",[self.activityDIc objectForKey:@"activitydes"]];
    float headerViewHeight= [self heightForString:label2.text andWidth:( DEF_WIDTH(self)-15) andText:label2];
    //自动适配
    CGRect frame=label2.frame;
    frame.size.height=headerViewHeight;
    label2.frame=frame;
    label2.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    label2.textColor=[UIColor colorWithRed:150/255.0 green:145/255.0 blue:180/255.0 alpha:1.0];
    label2.numberOfLines=0;
    [self.collectHeaderView addSubview:label2];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,  160*DEF_Adaptation_Font*0.5+headerViewHeight, DEF_WIDTH(self), 4)];
    imageView.alpha=0.6;
    imageView.image=[UIImage imageNamed:@"cutoffLine.png"];
    [self.collectHeaderView addSubview:imageView];
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
//第一个cell
-(void)firstCellForUpdateData:(ActivityCollectionViewCell *)cell{
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
    label.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    [cell.contentView addSubview:label];
    label.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor colorWithRed:30/255.0 green:31/255.0 blue:54/255.0 alpha:1.0];
}
-(void)originViewForCell:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:(NSDictionary*)imageDic{
    cell.backgroundColor =[self randomColorAndIndex:indexPath.row%5];
    //            UIButton *button= [LooperToolClass createBtnImageNameReal:@"btn_looper_share.png" andRect:CGPointMake(cell.frame.size.width-5-30*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-30*DEF_Adaptation_Font*0.5) andTag:(int)(2*BUTTONTAG+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(30*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) andTarget:self];
    //            [cell.contentView addSubview:button];
    UIButton *commendBtn= [LooperToolClass createBtnImageNameReal:@"commendNO.png" andRect:CGPointMake(5*DEF_Adaptation_Font*0.5, cell.frame.size.height-75*DEF_Adaptation_Font*0.5) andTag:(int)(4*BUTTONTAG+indexPath.row) andSelectImage:@"commendYES.png" andClickImage:@"commendYES.png" andTextStr:nil andSize:CGSizeMake(65*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font*0.5) andTarget:self];
    if ([imageDic[@"isthumb"]intValue]==1) {
        [commendBtn setSelected:YES];
    }
    [cell.contentView addSubview:commendBtn];
    UILabel *commendLB=[[UILabel alloc]initWithFrame:CGRectMake(8+35*DEF_Adaptation_Font*0.5,cell.frame.size.height-5-30*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    commendLB.font=[UIFont boldSystemFontOfSize:13];
    commendLB.textColor=[UIColor whiteColor];
    commendLB.text=[NSString stringWithFormat:@"%@赞",imageDic[@"thumbupcount"]];
    [cell.contentView addSubview:commendLB];
}
//不管是否cell有图片都会使用的view
-(void)AllUseViewForCellIfHaveImage:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:(NSDictionary*)imageDic{
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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)/2-110*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    label.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    label.textColor=[UIColor whiteColor];
    label.text=[imageDic objectForKey:@"username"];
    [cell.contentView addSubview:label];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
   ActivityCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellView" forIndexPath:indexPath] ;
    
    for (UIView *view in [cell.contentView subviews]){
        [view removeFromSuperview];
    }
    if (!cell) {cell = [[ActivityCollectionViewCell alloc]init];}else{  }
    cell.layer.cornerRadius=4.0;
    cell.layer.masksToBounds=YES;
        if (indexPath.row==1) {
            [self firstCellForUpdateData:cell];
            return cell;
        }
        //赋值
        if (self.barrageInfo.count) {
            NSDictionary *imageDic=[NSDictionary dictionary];
            if (indexPath.row==0) {
                 imageDic =self.barrageInfo[indexPath.row];
            }else{
             imageDic=self.barrageInfo[indexPath.row-1];
            }
            [self originViewForCell:cell andIndexpath:indexPath andImageDic:imageDic];
            //在这边判断是否有图片
            if ([imageDic objectForKey:@"messagePicture"]==[NSNull null]||[[imageDic objectForKey:@"messagePicture"]isEqualToString:@""]) {
                [self AllUseViewForCellIfHaveImage:cell andIndexpath:indexPath andImageDic:imageDic];
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), DEF_WIDTH(self)/2-10-100*DEF_Adaptation_Font*0.5)];
                label2.textAlignment=NSTextAlignmentCenter;
                label2.text=imageDic[@"messagecontent"];
                float  label2Height= [self heightForString:label2.text andWidth:(DEF_WIDTH(self)/2-50*DEF_Adaptation_Font*0.5) andText:label2];
                label2.font=[UIFont boldSystemFontOfSize:14];
                if (label2Height<30) {
                    label2.font=[UIFont boldSystemFontOfSize:18];
                }
                label2.textColor=[UIColor whiteColor];
                [cell.contentView addSubview:label2];
                label2.numberOfLines=0;
                if (label2Height>85.0) {
                    label2.numberOfLines=5;
                }
                UIButton *allShowBtn= [LooperToolClass createBtnImageNameReal:@"allShowBtn.jpg" andRect:CGPointMake(cell.frame.size.width/2-5-60*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-60*DEF_Adaptation_Font*0.5) andTag:(int)(3*BUTTONTAG+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
                allShowBtn.alpha=label2Height;
                [cell.contentView addSubview:allShowBtn];
                //用于消除allShowBtn
                for (NSNumber *tag in self.allShowTags) {
                    if ([tag intValue]==indexPath.row+3*BUTTONTAG) {
                        [allShowBtn removeFromSuperview];
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
                UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (DEF_WIDTH(self)/2-10), 130*DEF_Adaptation_Font*0.5)];
                NSString *string=[imageDic objectForKey:@"messagePicture"];
                NSArray *array = [string componentsSeparatedByString:@";"];
                [imageV sd_setImageWithURL:[NSURL URLWithString:array[0]]];
                imageV.contentMode =  UIViewContentModeScaleAspectFill;
                imageV.clipsToBounds  = YES;
                imageV.userInteractionEnabled=YES;
                //加入点击事件
                UITapGestureRecognizer *singleTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickPhoto:)];
                imageV.tag=indexPath.row-1+BUTTONTAG;
                [imageV addGestureRecognizer:singleTap1];
                [cell.contentView addSubview:imageV];
                [self AllUseViewForCellIfHaveImage:cell andIndexpath:indexPath andImageDic:imageDic];
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
                UIButton *allShowBtn= [LooperToolClass createBtnImageNameReal:@"allShowBtn.jpg" andRect:CGPointMake(cell.frame.size.width/2-5-60*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-60*DEF_Adaptation_Font*0.5) andTag:(int)(5*BUTTONTAG+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
                allShowBtn.alpha=label2Height;
                [cell.contentView addSubview:allShowBtn];
                //用于修改image和label的frame
                for (NSNumber *tag in self.allShowImageTags) {
                    if ([tag intValue]==indexPath.row+5*BUTTONTAG) {
                        [allShowBtn removeFromSuperview];
                        CGRect frame=label2.frame;
                        frame.size.height=label2Height+20*DEF_Adaptation_Font*0.5;
                        frame.origin.y=5*DEF_Adaptation_Font*0.5+ (DEF_WIDTH(self)/2-10);
                        label2.frame=frame;
                        label2.numberOfLines=0;
                        CGRect frame2=imageV.frame;
                        frame2.size.height=(DEF_WIDTH(self)/2-10);
                        imageV.frame=frame2;
                        [cell layoutIfNeeded];
                    }
                }
                
            }
        }
        cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottomIV.png"]];
        return cell;
}
-(void)onClickPhoto:(UITapGestureRecognizer *)tap{
    [self.viewArr removeAllObjects];
    BOOL viewArrIsTwo=NO;
    //点击头像跳转
    NSDictionary *imageDic=self.barrageInfo[tap.view.tag-BUTTONTAG];
    NSString *string=[imageDic objectForKey:@"messagePicture"];
    NSArray *array = [string componentsSeparatedByString:@";"];
    NSLog(@"%@",array);
    self.imageNameArray=[[NSMutableArray alloc]initWithArray:array];
    if (array.count==1) {
        
    }
    else  if (array.count==2) {
        for (int i=0; i<2; i++) {
            [self.imageNameArray addObject:array[i]];
        }
        viewArrIsTwo=YES;
    }
    //使用自动循环
    for (int i=0; i<self.imageNameArray.count; i++)
        
    {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH(self), DEF_HEIGHT(self))];
        imageView.contentMode=1;
        imageView.clipsToBounds=YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageNameArray[i]]];
        [self.viewArr addObject:imageView];
        
    }
    NSArray <UIView *> * views = self.viewArr;
    
    self.carouseView = [[YWCarouseView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) withTwo:viewArrIsTwo withViews:views withPageControl:NO];
    
    [self addSubview:self.carouseView];
    
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
#pragma mark -- LFWaterfallLayoutDelegate --
- (CGFloat)waterflowLayout:(LFWaterfallLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    for (NSNumber *tag in self.allShowTags) {
        if ([tag intValue]==index+3*BUTTONTAG) {
            return DEF_WIDTH(self)/2-10+([[self.heightDic objectForKey:@([tag intValue]-3*BUTTONTAG)]intValue] -85.0)*DEF_Adaptation_Font+20*DEF_Adaptation_Font*0.5;
        }
    }
    for (NSNumber *tag in self.allShowImageTags) {
        if ([tag intValue]==index+5*BUTTONTAG) {
        return DEF_WIDTH(self)/2-10+([[self.heightDic objectForKey:@([tag intValue]-5*BUTTONTAG)]intValue] -85.0)*DEF_Adaptation_Font+ (DEF_WIDTH(self)/2-10)-60*DEF_Adaptation_Font*0.5;//因为头像的50像素重合了
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
#pragma mark - < UITableViewDelegate >

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     CGFloat yOffset  = scrollView.contentOffset.y;
    NSLog(@"yOffset===%f,panPoint===%f",yOffset,[scrollView.panGestureRecognizer translationInView:self].y);
    CGFloat xOffset = (yOffset +400*DEF_Adaptation_Font*0.5)/2;
    
    if(yOffset < -480*DEF_Adaptation_Font*0.5) {
        CGRect f =self.headerView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset+80*DEF_Adaptation_Font*0.5;
        f.origin.x= xOffset;
        //int abs(int i); // 处理int类型的取绝对值
        //double fabs(double i); //处理double类型的取绝对值
        //float fabsf(float i); //处理float类型的取绝对值
        f.size.width=DEF_WIDTH(self) + fabs(xOffset)*2;
        self.headerView.frame= f;
        //修改视频的拉伸效果
        CGRect f3=self.movieController.view.frame;
        f3.size.height=-yOffset+60*DEF_Adaptation_Font*0.5;
        f3.size.width=DEF_WIDTH(self) + fabs(xOffset)*2;
        self.movieController.view.frame= f3;
    }
    else{
        CGRect f2 =self.buddleView.frame;
        f2.size.height=-yOffset+80*DEF_Adaptation_Font*0.5;
        if (-yOffset<=-30) {
            f2.size.height=30;
        }
        self.buddleView.frame=f2;
        if (yOffset>=-400*DEF_Adaptation_Font*0.5&&yOffset<=-200*DEF_Adaptation_Font*0.5) {
            CGRect newFrame = self.headerView.frame;
            newFrame.origin.y=yOffset;
            newFrame.size.height=-yOffset+80*DEF_Adaptation_Font*0.5;
            self.headerView.frame=newFrame;
        }
        else{
            CGRect f =self.headerView.frame;
            f.origin.y= yOffset ;
            f.size.height=  -yOffset+80*DEF_Adaptation_Font*0.5;
            self.headerView.clipsToBounds=YES;
            self.headerView.frame= f;
            
        }
        //隐藏一下buddleView
        if (yOffset>-100*DEF_Adaptation_Font*0.5) {
            [self.buddleView setHidden:YES];
        }else{
            [self.buddleView setHidden:NO];
        }
        
    }
    //    NSLog(@"总长度:%f,加上的长度:%f", 40 - self.collectView.contentOffset.y-160*DEF_Adaptation_Font*0.5,80*DEF_Adaptation_Font*0.5);
}

@end
