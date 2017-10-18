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
#import "LooperConfig.h"
#import "ActivityCollectionViewCell.h"
#import "sendMessageActivityView.h"
#import "ActivityViewModel.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YWCarouseView.h"
#import "DataHander.h"
#import "barrageReplyView.h"
#import "XDRefresh.h"
#define BUTTONTAG  100000
@interface ActivityBarrageView()<UITextViewDelegate>
{
    float headViewHeight;
    LFWaterfallLayout *waterLayout;
    //用于添加评论
    UILabel *countLB;
    //当前选中的cell
    XDRefreshFooter *_footer;
}
@property(nonatomic,strong)UIButton * suspendBtn;
//@property(nonatomic,retain) MPMoviePlayerController *movieController;
//三个属性都是用于循环展示上传的照片
@property (nonatomic, strong) YWCarouseView * carouseView;
@property(nonatomic,strong)NSMutableArray * imageNameArray;
@property(nonatomic,strong)NSMutableArray *viewArr;

@end
@implementation ActivityBarrageView{
    float labelHeight;
    
    //是否重置BuddleSubscriptArr
    BOOL  isAddBuddleSubscriptArr;
}
-(UIButton *)suspendBtn{
    if (!_suspendBtn) {
        _suspendBtn=[LooperToolClass createBtnImageNameReal:@"sendBuddle.png" andRect:CGPointMake(DEF_WIDTH( self)-130*DEF_Adaptation_Font*0.5, DEF_HEIGHT(self)-130*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 100*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5)  andTarget:self];
        [self addSubview:_suspendBtn];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [_suspendBtn addGestureRecognizer:pan];
        
    }
    return _suspendBtn;
}
//设置悬浮框
-(void)locationChange:(UIPanGestureRecognizer*)p
{
    //[[UIApplication sharedApplication] keyWindow]
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication] keyWindow]];
    float HEIGHT=70*DEF_Adaptation_Font*0.5;
    float WIDTH=70*DEF_Adaptation_Font*0.5;
    if(p.state == UIGestureRecognizerStateChanged)
    {
        _suspendBtn.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        if(panPoint.x <= DEF_WIDTH(self)/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= DEF_HEIGHT(self)-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(panPoint.x, DEF_HEIGHT(self)-HEIGHT/2);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > DEF_HEIGHT(self)-HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(WIDTH/2, DEF_HEIGHT(self)-HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(WIDTH/2, pointy);
                }];
            }
        }
        else if(panPoint.x > DEF_WIDTH(self)/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < DEF_WIDTH(self)-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= DEF_HEIGHT(self)-40-HEIGHT/2 && panPoint.x < DEF_WIDTH(self)-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(panPoint.x, 480*DEF_Adaptation_Font-HEIGHT/2);
                }];
            }
            else if (panPoint.x > DEF_WIDTH(self)-WIDTH/2-15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(DEF_WIDTH(self)-WIDTH/2, HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > DEF_HEIGHT(self)-HEIGHT/2 ? DEF_HEIGHT(self)-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    _suspendBtn.center = CGPointMake(320*DEF_Adaptation_Font-WIDTH/2, pointy);
                }];
            }
        }
    }
}
-(NSMutableArray *)barrageInfo{
    if (!_barrageInfo) {
        _barrageInfo=[[NSMutableArray alloc]init];
    }
    return _barrageInfo;
}
-(NSMutableDictionary *)publishCellDic{
    if (!_publishCellDic) {
        _publishCellDic=[[NSMutableDictionary alloc]init];
    }
    return _publishCellDic;
}
-(NSMutableArray *)publishCountArr{
    if (!_publishCountArr) {
        _publishCountArr=[[NSMutableArray alloc]init];
    }
    return _publishCountArr;
}
-(NSMutableDictionary *)heightPublishDic{
    if (!_heightPublishDic) {
        _heightPublishDic=[[NSMutableDictionary alloc]init];
    }
    return _heightPublishDic;
}
-(NSMutableArray *)buddleSubscriptArr{
    if (!_buddleSubscriptArr) {
        _buddleSubscriptArr=[[NSMutableArray alloc]init];
        for (int i=0; i<self.buddleArr.count; i++) {
            [_buddleSubscriptArr addObject:@(i)];
        }
    }
    return _buddleSubscriptArr;
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
-(void)showHUDWithString:(NSString*)commend{
 [[DataHander sharedDataHander] showViewWithStr:commend andTime:3 andPos:CGPointZero];
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)viewModel{
    if (self = [super initWithFrame:frame]) {
        isAddBuddleSubscriptArr=NO;
        self.obj = (ActivityView*)idObject;
        self.viewModel=viewModel;
        [self.viewModel setRefreshNumber:0];
        self.activityID=[self.obj activityID];
        self.activityDIc=[self.obj activityDic];
         [self.viewModel getActivityInfoById:self.activityID andUserId:[LocalDataMangaer sharedManager].uid andPage:1 andSize:10];
        [self createCollectionView];
        [self initailHeaderView];
        [self initailBuddleView];
        
        [self.viewModel setBarrageView:self];
        
        labelHeight=85.0;

        UIButton *backBtn= [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:backBtn];
    }
    return self;
}
-(void)refreshCollectionView{
    _footer = [XDRefreshFooter footerOfScrollView:self.collectView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello2");
//                    [_footer endRefreshingWithNoMoreDataWithTitle:@"无数据了"];
                [self.viewModel getActivityInfoById:self.activityID andUserId:[LocalDataMangaer sharedManager].uid andPage:0 andSize:10];
                    [self.collectView reloadData];
                    [_footer endRefreshing];
            });
        });
    }];
}
-(void)startTimer{
  NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(initDateBarrage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop] run];
}
-(void)addImageArray:(NSArray *)imageArray{
    [self.barrageInfo addObjectsFromArray:imageArray];
    [self.userImageArr removeAllObjects];
    [self.buddleArr removeAllObjects];
    //去除评论回复的重复
    [self.publishCountArr removeAllObjects];
    [self.heightPublishDic removeAllObjects];
    [self.publishCellDic removeAllObjects];
    for (int i=0;i<self.barrageInfo.count;i++) {
        NSDictionary *buddleDic=_barrageInfo[i];
        [self.buddleArr   addObject: [buddleDic objectForKey:@"messagecontent"]];
        [self.userImageArr addObject:[buddleDic objectForKey:@"userimage"]];
#warning 在这里获取到韬哥的结果，如果imageDic中有评论的属性，就把高度加入到heightPublishDic中，把评论的内容加入到cellPublishDic中,把评论的下标加入到publishCountArr中
        if ([[buddleDic objectForKey:@"reply"] count]) {
//            [self.viewModel getReplyDataForMessageID:[[buddleDic objectForKey:@"messageid"]intValue] andIndex:i];
            [self addReplyData:i andArray:[buddleDic objectForKey:@"reply"] andReplyCount:0];
        }
//        [self.publishCellDic setObject:@(20) forKey:@(i)];
      
    }

    [self.collectView reloadData];
}

-(void)addReplyData:(NSInteger)index andArray:(NSArray *)dataArr andReplyCount:(NSInteger)replyCount{
    self.replyCount=replyCount;
    if (index!=0) {
    index+=1;
    }
    self.replyIndex=index;
[self.publishCountArr addObject:@(index)];
//     [self.heightPublishDic setObject:@(50) forKey:@(index)];
     [self.publishCellDic setObject:dataArr forKey:@(index)];
    float height=0;
    for (int i=0;i<dataArr.count;i++) {
        NSDictionary *dataDic=dataArr[i];
        NSString * content = [dataDic objectForKey:@"messagecontent"];
        if (dataArr.count==1) {
//            height=[self heightForString:content andWidth:(DEF_WIDTH(self)/2-150*DEF_Adaptation_Font*0.5) andText:[[UILabel alloc]init]];
             CGSize lblSize = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10 -120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            height=lblSize.height;
             [self.heightPublishDic setObject:@(height+50*DEF_Adaptation_Font) forKey:@(index)];
        }
        if (dataArr.count>=2&&i==0) {
//            height=[self heightForString:content andWidth:(DEF_WIDTH(self)/2-150*DEF_Adaptation_Font*0.5) andText:[[UILabel alloc]init]];
            CGSize lblSize = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10 -120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            height=lblSize.height;
        }
        if (dataArr.count>=2&&i==1) {
            CGSize lblSize = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10 -120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            height+=lblSize.height;
//            height+=[self heightForString:content andWidth:(DEF_WIDTH(self)/2-150*DEF_Adaptation_Font*0.5) andText:[[UILabel alloc]init]];
               [self.heightPublishDic setObject:@(height+140*DEF_Adaptation_Font*0.5) forKey:@(index)];
        }
    }
    [self.collectView reloadData];
}
-(void)removeActivityAction{
    _footer=nil;
//    [_collectView removeFromSuperview];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==100){
        [self removeActivityAction];
//               [self.movieController stop];
        [self removeFromSuperview];
        }
    if (button.tag==101) {
        [self.publishCountArr removeAllObjects];
        [self.heightPublishDic removeAllObjects];
        [self.publishCellDic removeAllObjects];
        [self.allShowTags removeAllObjects];
        [self.allShowImageTags removeAllObjects];
//        [self.heightDic removeObjectForKey:@(0)];
        NSLog(@"这是一个发表评论button");
        sendMessageActivityView *view=[[sendMessageActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self.viewModel and:self andIndexPath:-1];
        view.obj=self.viewModel;
        view.barrageView=self;
        [self.viewModel setSendView:view];
        [self.viewModel setBarrageView:self];
        [self addSubview:view];
    }
    if (button.tag>=5*BUTTONTAG&&button.tag<5*BUTTONTAG+self.barrageInfo.count+10) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowImageTags addObject:@(button.tag)];
        labelHeight=button.alpha;
        [self.heightDic setObject:@(labelHeight) forKey:@(button.tag-5*BUTTONTAG)];
        [self.collectView reloadData];
    }
    
    if (button.tag>=3*BUTTONTAG&&button.tag<3*BUTTONTAG+self.barrageInfo.count+10) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowTags addObject:@(button.tag)];
        labelHeight=button.alpha;
         [self.heightDic setObject:@(labelHeight) forKey:@(button.tag-3*BUTTONTAG)];
        [self.collectView reloadData];
    }
    if (button.tag>=4*BUTTONTAG&&button.tag<4*BUTTONTAG+self.barrageInfo.count+10) {
        NSLog(@"这是跳转更多回复的按钮");
        barrageReplyView *replyV=[[barrageReplyView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self andIndex:button.tag-4*BUTTONTAG andViewModel:_viewModel andActivityID:self.activityID];
        [self addSubview:replyV];
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
//    if (0) {
//        [self addAVPlayer];
//    }
    self.headerView.userInteractionEnabled=YES;
    [self.collectView addSubview:self.headerView];
}
-(void)addAVPlayer {
//    NSString *videoPath=@"http://flv2.bn.netease.com/videolib3/1510/25/bIHxK3719/SD/bIHxK3719-mobile.mp4";
//    //    NSURL *videoUrl = [[NSBundle mainBundle]URLForResource:@"clear" withExtension:@"mp4"];//定位资源clear.mp4
//    self.movieController = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:videoPath]];//初始化movieController
//    [self.movieController.view setFrame:CGRectMake(0, 0, DEF_WIDTH(self), 530*DEF_Adaptation_Font*0.5)];//movieController视图的大小
//    [self.movieController setRepeatMode:MPMovieRepeatModeOne];//重复方式
//    [self.movieController setScalingMode:MPMovieScalingModeAspectFill];//缩放方式满屏
//    [self.movieController play];//播放
//    [self.headerView addSubview:self.movieController.view];//添加
}
- (void)initailBuddleView {
    
    self.buddleView = [[UIImageView alloc] init];
    self.buddleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500*DEF_Adaptation_Font*0.5);
    self.buddleView.clipsToBounds = YES;
    
    NSTimer *timer=  [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(initDate) userInfo:nil repeats:YES];
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
    if (self.buddleSubscriptArr.count!=0&&self.buddleSubscriptArr.count<=self.buddleArr.count) {
//**防止弹幕重复出现
    int subscript=rand()%self.buddleSubscriptArr.count;
     int   count=[self.buddleSubscriptArr[subscript]intValue];
        NSString *str=[self.buddleArr objectAtIndex:[self.buddleSubscriptArr[subscript]intValue]];        //把用过的下标移除
        [self.buddleSubscriptArr removeObjectAtIndex:subscript];
//**设置弹幕的长度
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55*DEF_Adaptation_Font*0.5, 0, 240, 50*DEF_Adaptation_Font*0.5)];
        label.text = str;
        CGRect frame=label.frame;
        frame.size.width=[self widthForString:str andHeight: 200*DEF_Adaptation_Font*0.5 andText:label]*1.5;
        label.frame=frame;
        label.textAlignment=NSTextAlignmentLeft;
        label.textColor =[UIColor whiteColor];
//**设置弹幕的轨道
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
        //给view1添加swipe手势
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
        //设置轻扫的方向
        swipeGesture.direction = UISwipeGestureRecognizerDirectionUp; //默认向上
        [view1 addGestureRecognizer:swipeGesture];
//**判断view1在哪个轨迹,轨迹总共0~7
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
        CGRect viewFrame=view.frame;
        viewFrame.size.width=view1.frame.size.width;
        view.frame=viewFrame;
        view.layer.cornerRadius=25*DEF_Adaptation_Font*0.5;
        view.layer.masksToBounds=YES;
        //给view添加pan手势
        view.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
        [view addGestureRecognizer:singleTap];
        view.backgroundColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5];
        
    // 弹幕点赞
    if (self.barrageInfo.count) {
        if ([self.barrageInfo[count][@"isthumb"]intValue]==1) {
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(view1)/2-20, 5*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
            view.tag=count;
              view1.tag=count-1;
            imageV.tag=count-BUTTONTAG;
            if (count==0) {
                view.tag=BUTTONTAG;
                imageV.tag=-BUTTONTAG;
                view1.tag=2*BUTTONTAG;
            }
          
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
            if (count==0) {
                view.tag=-BUTTONTAG;
                 imageV.tag=BUTTONTAG;
                view1.tag=-2*BUTTONTAG;
            }
            
            [view1 addSubview:imageV];
        }
    }
       
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
    [self.barrageArr addObject:view1];
    }
    else if (self.buddleSubscriptArr.count>self.buddleArr.count){
        self.buddleSubscriptArr=nil;
    }
//**弹幕下标使用完后暂停8秒重新生成下标
    else{
        if (isAddBuddleSubscriptArr==NO) {
        [self performSelector:@selector(addBuddleSubscriptArr) withObject:nil/*可传任意类型参数*/ afterDelay:10.0];
            isAddBuddleSubscriptArr=YES;
        }
    }
}
-(void)addBuddleSubscriptArr{
    self.buddleSubscriptArr=nil;
    isAddBuddleSubscriptArr=NO;
}
//轻扫手势
-(void)swipeGesture:(UISwipeGestureRecognizer *)swipe{
    int count=0;
    if (swipe.view.tag!=2*BUTTONTAG&&swipe.view.tag!=-BUTTONTAG*2) {
        count=(int)swipe.view.tag+1;
    }
    if (count<=0) {
//说明还未被点赞
         if ([self.barrageInfo[-count][@"isthumb"]intValue]==0) {
    UIImageView *imageV=  (UIImageView *)[swipe.view viewWithTag:(swipe.view.tag-BUTTONTAG+1)];
              UIView *view=(UIView *)[swipe.view viewWithTag:(swipe.view.tag+1)];
    if (swipe.view.tag==BUTTONTAG*2||swipe.view.tag==-BUTTONTAG*2) {
        imageV=  (UIImageView *)[swipe.view viewWithTag:(-(swipe.view.tag)/2)];
        view=(UIView *)[swipe.view viewWithTag:(swipe.view.tag/2)];
    }
    NSLog(@"view1:%ld, view: %ld ,imageV :%ld",swipe.view.tag,view.tag,imageV.tag);
    [view setBackgroundColor:[UIColor colorWithRed:193/255.0 green:216/255.0 blue:76/255.0 alpha:1.0]];
             if (swipe.view.tag==BUTTONTAG*2||swipe.view.tag==-BUTTONTAG*2) {
        [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[0]objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
    }else{
        [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[-swipe.view.tag-1]objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
    }
    view.tag=-view.tag;
    imageV.tag=view.tag-BUTTONTAG;
    if (view.tag==-BUTTONTAG||view.tag==BUTTONTAG) {
        imageV.tag=-view.tag;
    }
         }
    }
    
//**点赞按钮向上运动的动画
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
    if (tap.view.tag==-BUTTONTAG||tap.view.tag==BUTTONTAG) {
        imageV=  (UIImageView *)[self viewWithTag:(-tap.view.tag)];
    }
      NSLog(@"打印一下imageView %ld view %ld的tag值",(long)imageV.tag,tap.view.tag);
    if (tap.view.tag<0) {
        [tap.view setBackgroundColor:[UIColor colorWithRed:193/255.0 green:216/255.0 blue:76/255.0 alpha:1.0]];
        [UIView animateWithDuration:0.1 animations:^{
            imageV.frame = CGRectMake(DEF_WIDTH(tap.view)/2-20, 5*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5);
        } completion:^(BOOL finished) {
        }
         ];
        if (tap.view.tag==-BUTTONTAG) {
             [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[0]objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
        }else{
        [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[-tap.view.tag]objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
        }
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
        //当view.tag=0时
        if (tap.view.tag==BUTTONTAG) {
            [self.viewModel thumbActivityMessage:@"0" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[0]objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
        }else{
        [self.viewModel thumbActivityMessage:@"0" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[self.barrageInfo[tap.view.tag]objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
        }
    }
    tap.view.tag=-tap.view.tag;
    imageV.tag=tap.view.tag-BUTTONTAG;
    if (tap.view.tag==-BUTTONTAG||tap.view.tag==BUTTONTAG) {
       imageV.tag=-tap.view.tag;
    }
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
     CGSize lblSize = [label2.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    headViewHeight=lblSize.height+50*DEF_Adaptation_Font*0.5;
//    headViewHeight= [self heightForString:label2.text andWidth:( DEF_WIDTH(self)-62*DEF_Adaptation_Font*0.5) andText:label2]+50*DEF_Adaptation_Font*0.5;
    waterLayout=flowLayout;
    flowLayout.height=headViewHeight+170*DEF_Adaptation_Font*0.5+4;
//没有活动详情
    if ([self.activityDIc objectForKey:@"rules"]==[NSNull null]||[[self.activityDIc objectForKey:@"rules"]isEqualToString:@""]) {
        CGSize lblSize2 = [label2.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-180*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        headViewHeight=lblSize2.height+60*DEF_Adaptation_Font*0.5;
         flowLayout.height=headViewHeight+55*DEF_Adaptation_Font*0.5+4;
    }
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
       [self refreshCollectionView];
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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 85*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 80*DEF_Adaptation_Font*0.5)];
    label.text=[NSString stringWithFormat:@"%@",self.activityDIc[@"activitydes"]];
    label.font=[UIFont systemFontOfSize:16];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.textColor=[UIColor whiteColor];
    label.numberOfLines=2;
    [self.collectHeaderView addSubview:label];
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(15, 170*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 120*DEF_Adaptation_Font*0.5)];
    [self.collectHeaderView addSubview:contentView];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0, 5*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 25*DEF_Adaptation_Font*0.5)];
    label3.text=@"· 活动说明";
    label3.textColor=[UIColor yellowColor];
    label3.font=[UIFont boldSystemFontOfSize:14];
    label3.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityStateLB:)];
    [label3 addGestureRecognizer:singleTap];
    [contentView addSubview:label3];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 24*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-30, 100*DEF_Adaptation_Font*0.5)];
    if ([self.activityDIc objectForKey:@"applerules"]==[NSNull null]||[[self.activityDIc objectForKey:@"applerules"]isEqualToString:@""]) {
        label2.text=[NSString stringWithFormat:@"%@",[self.activityDIc objectForKey:@"activitydes"]];
        label2.font=[UIFont systemFontOfSize:16];
        label2.textColor=[UIColor whiteColor];
        [label setHidden:YES];
        [label3 setHidden:YES];
        CGRect frame=contentView.frame;
        frame.origin.y=60*DEF_Adaptation_Font*0.5;
        contentView.frame=frame;
    }else{
    label2.text=[NSString stringWithFormat:@"%@",[self.activityDIc objectForKey:@"applerules"]];
    label2.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    label2.textColor=[UIColor colorWithRed:150/255.0 green:145/255.0 blue:180/255.0 alpha:1.0];
    }
    //自动适配
    CGRect frame=label2.frame;
    frame.size.height=headViewHeight-20*DEF_Adaptation_Font*0.5;
    label2.frame=frame;

    label2.numberOfLines=0;
    [contentView addSubview:label2];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(-15,  headViewHeight, DEF_WIDTH(self), 4)];
    imageView.alpha=0.6;
    imageView.image=[UIImage imageNamed:@"cutoffLine.png"];
    [contentView addSubview:imageView];
}
-(void)onClickActivityStateLB:(UITapGestureRecognizer *)tap{

}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5);
}

#pragma mark-<UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (self.barrageInfo.count==0) {
        return 2;
    }
    return self.barrageInfo.count+1;
}
//第一个cell
-(void)firstCellForUpdateData:(ActivityCollectionViewCell *)cell{
    UIButton *button= [LooperToolClass createBtnImageNameReal:@"writeBuddle.png" andRect:CGPointMake(0, 0) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(DEF_WIDTH(self)/2-10, DEF_WIDTH(self)/2-10) andTarget:self];
    [cell.contentView addSubview:button];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:[LocalDataMangaer sharedManager].HeadImageUrl]];
    imageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
    imageView.layer.masksToBounds=YES;
    [cell.contentView addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 170*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    label.text=[NSString stringWithFormat:@"%@",[LocalDataMangaer sharedManager].NickName];
    label.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    [cell.contentView addSubview:label];
    label.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor colorWithRed:30/255.0 green:31/255.0 blue:54/255.0 alpha:1.0];
     cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
}
-(void)originViewForCell:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:(NSDictionary*)imageDic{
    cell.backgroundColor =[self randomColorAndIndex:indexPath.row%5];
   __block NSDictionary *messageDic=[NSDictionary dictionary];
    if ([imageDic[@"isthumb"]intValue]==1) {
        [cell.commendBtn setSelected:YES];
    }
    else{
     [cell.commendBtn setSelected:NO];
    }
    //从第二个cell开始算的
    if (indexPath.row==0) {
        messageDic=self.barrageInfo[0];
    }
    else{
        messageDic=self.barrageInfo[indexPath.row-1];
    }
    //点赞按钮的点击事件
    cell.commendBtnClick = ^{
        //在这返回islike和thumbupcount的参数
        if (!cell.commendBtn.selected) {
            [cell.commendBtn setSelected:YES];
            [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[messageDic objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
            [self.allShowTags removeAllObjects];
            [self.allShowImageTags removeAllObjects];
        }
        else{
            [cell.commendBtn setSelected:NO];
            [self.viewModel thumbActivityMessage:@"0" andUserId:[LocalDataMangaer sharedManager].uid andMessageId:[messageDic objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:NO];
            [self.allShowTags removeAllObjects];
            [self.allShowImageTags removeAllObjects];
        }
        NSLog(@"这是一个点赞按钮");
    };
    //分享按钮
    cell.shareBtnClick = ^{
        sendMessageActivityView *view=[[sendMessageActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self.viewModel and:self andIndexPath:indexPath.row];
        view.obj=self.viewModel;
        view.barrageView=self;
        view.cellIndexPath=indexPath.row;
        [self.viewModel setSendView:view];
        [self.viewModel setBarrageView:self];
        [self addSubview:view];
//        [self.viewModel shareH5:messageDic];
    };
    //点赞人数赋值
    cell.commendLB.text=[NSString stringWithFormat:@"%@赞",imageDic[@"thumbupcount"]];
}

//不管是否cell有图片都会使用的view
-(void)AllUseViewForCellIfHaveImage:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:(NSDictionary*)imageDic{
    [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"userimage"]]placeholderImage:[UIImage imageNamed:@"btn_looper.png"] options:SDWebImageRetryFailed];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    cell.userImageView.tag=indexPath.row;
    [cell.userImageView addGestureRecognizer:singleTap];
    cell.userNameLB.text=[imageDic objectForKey:@"username"];
    
}

-(void)hiddenCellUIForOther:(ActivityCollectionViewCell *)cell andIs:(BOOL)yes{
    [cell.commendLB setHidden:yes];
    [cell.commendBtn setHidden:yes];
    [cell.userImageView setHidden:yes];
    [cell.userNameLB setHidden:yes];
    [cell.contentLB setHidden:yes];
    [cell.shareBtn setHidden:yes];
}
-(void)cellUIWhenNoPhoto:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:
(NSDictionary*)imageDic{
     cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottomIV.png"]];
    [cell.contentLB setHidden:NO];
    cell.contentLB.text=imageDic[@"messagecontent"];
    float  label2Height= [self heightForString:cell.contentLB.text andWidth:(DEF_WIDTH(self)/2-50*DEF_Adaptation_Font*0.5) andText:cell.contentLB];
    cell.contentLB.font=[UIFont boldSystemFontOfSize:14];
    if (label2Height<30) {
        cell.contentLB.font=[UIFont boldSystemFontOfSize:18];}
    cell.contentLB.numberOfLines=0;
    if (label2Height>85.0) {
        cell.contentLB.numberOfLines=5;}
 UIButton   *allShowBtn= [LooperToolClass createBtnImageNameReal:@"allShowBtn.jpg" andRect:CGPointMake(cell.frame.size.width/2-5-60*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-60*DEF_Adaptation_Font*0.5) andTag:(int)(3*BUTTONTAG+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    allShowBtn.alpha=label2Height;
    [cell.contentView addSubview:allShowBtn];
    //用于消除allShowBtn
    for (NSNumber *tag in self.allShowTags) {
        if ([tag intValue]==indexPath.row+3*BUTTONTAG) {
            [allShowBtn removeFromSuperview];
            CGRect frame=cell.contentLB.frame;
            frame.size.height=label2Height+20*DEF_Adaptation_Font*0.5;
            cell.contentLB.frame=frame;
            cell.contentLB.numberOfLines=0;
            [cell layoutIfNeeded];
        }
    }
     [self addTalkingPublish:cell andIndexpath:indexPath andImageDic:imageDic andallShowBtn:allShowBtn andIsImageView:NO];
    if (label2Height<=85.0) {
        [allShowBtn removeFromSuperview];
    }
}
-(void)cellUIWhenHavePhoto:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:(NSDictionary*)imageDic{
     cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottomIV.png"]];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (DEF_WIDTH(self)/2-10), 130*DEF_Adaptation_Font*0.5)];
    NSString *string=[imageDic objectForKey:@"messagePicture"];
    NSArray *array = [string componentsSeparatedByString:@";"];
    [imageV sd_setImageWithURL:[NSURL URLWithString:array[0]]placeholderImage:nil options:SDWebImageRetryFailed];
    imageV.contentMode =  UIViewContentModeScaleAspectFill;
    imageV.clipsToBounds  = YES;
    imageV.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickPhoto:)];
    imageV.tag=indexPath.row-1+BUTTONTAG;
    [imageV addGestureRecognizer:singleTap1];
    [cell.contentView addSubview:imageV];
    
    [cell.contentLB setHidden:YES];
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
  UIButton  *allShowBtn= [LooperToolClass createBtnImageNameReal:@"allShowBtn.jpg" andRect:CGPointMake(cell.frame.size.width/2-5-60*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-60*DEF_Adaptation_Font*0.5) andTag:(int)(5*BUTTONTAG+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
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
        }}
     [self addTalkingPublish:cell andIndexpath:indexPath andImageDic:imageDic andallShowBtn:allShowBtn andIsImageView:YES];
  }
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    //重用cell
   ActivityCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellView" forIndexPath:indexPath] ;
    [cell updateCell];
    if (indexPath.row<10) {
        [self.suspendBtn setHidden:YES];
    }
    else{
        [self.suspendBtn setHidden:NO];
    }
    
    for (UIView *view in [cell.contentView subviews]){
        [view removeFromSuperview];
    }
    if (!cell) {cell = [[ActivityCollectionViewCell alloc]init];}else{  }
           if (indexPath.row==1) {
               [self hiddenCellUIForOther:cell andIs:YES];
    [self firstCellForUpdateData:cell];
        return cell;}
           else{
               [self hiddenCellUIForOther:cell andIs:NO];}
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
                [self cellUIWhenNoPhoto:cell andIndexpath:indexPath andImageDic:imageDic];
            
            }else{
                //在这里添加有imageView的情况
                [self cellUIWhenHavePhoto:cell andIndexpath:indexPath andImageDic:imageDic];
                [self AllUseViewForCellIfHaveImage:cell andIndexpath:indexPath andImageDic:imageDic];
}
        }
    
        return cell;
}
-(void)addTalkingPublish:(ActivityCollectionViewCell *)cell andIndexpath:(NSIndexPath *)indexPath andImageDic:(NSDictionary*)imageDic andallShowBtn:(UIButton *)allShowBtn andIsImageView:(BOOL)isImageView{
       for (NSNumber *index in self.publishCountArr) {
        if ([index intValue]==indexPath.row) {
            NSInteger heightForReply=[[self.heightPublishDic objectForKey:index]integerValue];
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, DEF_HEIGHT(cell)-heightForReply+10, DEF_WIDTH(cell)-20, 1.0)];
            lineView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
            [cell.contentView addSubview:lineView];
             NSArray *dataArr=[self.publishCellDic objectForKey:index];
            UIButton *morePublishBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(20*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-23) andTag:(int)indexPath.row+4*BUTTONTAG andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(DEF_WIDTH(cell), 18) andTarget:self];
            if (self.replyIndex==[index intValue]&&self.replyCount>0) {
                 [morePublishBtn setTitle:[NSString stringWithFormat:@"共%ld条回复>>",self.replyCount] forState:(UIControlStateNormal)];
            }else{
               [morePublishBtn setTitle:[NSString stringWithFormat:@"共%@条回复>>",[imageDic objectForKey:@"replycount"]] forState:(UIControlStateNormal)];
            }
            [morePublishBtn setTitleColor:[UIColor colorWithRed:68/255.0 green:130/255.0 blue:173/255.0 alpha:1.0] forState:(UIControlStateNormal)];
            morePublishBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            morePublishBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            [cell.contentView addSubview:morePublishBtn];
#warning-在这里加入多条回复
           
            if (dataArr.count==1) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-heightForReply+33*DEF_Adaptation_Font*0.5,80*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
                 label.text=[dataArr.firstObject objectForKey:@"username"];
                if ([[dataArr.firstObject objectForKey:@"username"]isEqualToString:@""]) {
                    label.text=@"赵日天";
                }
                 label.textAlignment=NSTextAlignmentRight;
                 label.font=[UIFont systemFontOfSize:13];
                 label.textColor=[UIColor colorWithRed:68/255.0 green:130/255.0 blue:173/255.0 alpha:1.0];
                [cell.contentView addSubview:label];
                UILabel *content=[[UILabel alloc]initWithFrame:CGRectMake(10+80*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-heightForReply+40*DEF_Adaptation_Font*0.5,DEF_WIDTH(cell)-10-120*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
           content.text=[NSString stringWithFormat:@":%@",[dataArr.firstObject objectForKey:@"messagecontent"]];
                content.textColor=[UIColor whiteColor];
                content.numberOfLines=0;
                content.font=[UIFont systemFontOfSize:13];
                CGRect contentFrame=content.frame;
                CGSize lblSize = [content.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10 -120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                contentFrame.size=lblSize;
                content.frame=contentFrame;
                [cell.contentView addSubview:content];
            }
            if (dataArr.count>=2) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-heightForReply+38*DEF_Adaptation_Font*0.5,80*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
                label.text=[dataArr.firstObject objectForKey:@"username"];
                if ([[dataArr.firstObject objectForKey:@"username"]isEqualToString:@""]) {
                    label.text=@"赵日天";
                }
               label.textColor=[UIColor colorWithRed:68/255.0 green:130/255.0 blue:173/255.0 alpha:1.0];
                 label.textAlignment=NSTextAlignmentRight;
                  label.font=[UIFont systemFontOfSize:13];
                [cell.contentView addSubview:label];
                UILabel *content=[[UILabel alloc]initWithFrame:CGRectMake(10+80*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-heightForReply+45*DEF_Adaptation_Font*0.5,DEF_WIDTH(cell)-10-120*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
                content.text=[NSString stringWithFormat:@":%@",[dataArr.firstObject objectForKey:@"messagecontent"]];
                content.numberOfLines=0;
                content.textColor=[UIColor whiteColor];
                content.font=[UIFont systemFontOfSize:13];
                CGRect contentFrame=content.frame;
               CGSize lblSize = [content.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10 -120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                float height=lblSize.height;
                contentFrame.size=lblSize;
                content.frame=contentFrame;
                [cell.contentView addSubview:content];
                
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-heightForReply+53*DEF_Adaptation_Font*0.5+height,80*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
                  label2.font=[UIFont systemFontOfSize:13];
                label2.text=[dataArr[1] objectForKey:@"username"];
                if ([[dataArr[1] objectForKey:@"username"]isEqualToString:@""]) {
                    label2.text=@"赵日天";
                }
                 label2.textAlignment=NSTextAlignmentRight;
                label2.textColor=[UIColor colorWithRed:68/255.0 green:130/255.0 blue:173/255.0 alpha:1.0];
                [cell.contentView addSubview:label2];
                UILabel *content2=[[UILabel alloc]initWithFrame:CGRectMake(10+80*DEF_Adaptation_Font*0.5, DEF_HEIGHT(cell)-heightForReply+60*DEF_Adaptation_Font*0.5+height,DEF_WIDTH(cell)-10-120*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
                content2.text=[NSString stringWithFormat:@":%@",[dataArr[1]objectForKey:@"messagecontent"]];
                content2.numberOfLines=0;
                content2.textColor=[UIColor whiteColor];
                content2.font=[UIFont systemFontOfSize:13];
                CGRect contentFrame2=content2.frame;
                 CGSize lblSize2 = [content2.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2-10 -120*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                contentFrame2.size=lblSize2;
                content2.frame=contentFrame2;
                [cell.contentView addSubview:content2];

            }
            
            CGRect frame1=cell.commendBtn.frame;
            frame1.origin.y= DEF_HEIGHT(cell)-75*DEF_Adaptation_Font*0.5-heightForReply;
            cell.commendBtn.frame=frame1;
            CGRect frame2=cell.commendLB.frame;
            frame2.origin.y=DEF_HEIGHT(cell)-5-30*DEF_Adaptation_Font*0.5-heightForReply;
            cell.commendLB.frame=frame2;
            CGRect frame3=cell.shareBtn.frame;
           frame3.origin.y=DEF_HEIGHT(cell)-5-40*DEF_Adaptation_Font*0.5-heightForReply;
            cell.shareBtn.frame=frame3;
            CGRect frame4=allShowBtn.frame;
            frame4.origin.y=DEF_HEIGHT(cell)-5-60*DEF_Adaptation_Font*0.5-heightForReply;
            allShowBtn.frame=frame4;
//            if (isImageView==YES) {
//            [self.allShowImageTags addObject:@(allShowBtn.tag)];
//            labelHeight=allShowBtn.alpha;
//            [self.heightDic setObject:@(labelHeight) forKey:@(allShowBtn.tag-5*BUTTONTAG)];
//             [cell layoutIfNeeded];
//            }
    }
    }
}
-(void)onClickPhoto:(UITapGestureRecognizer *)tap{
    [self.viewArr removeAllObjects];
    BOOL viewArrIsTwo=NO;
    //点击头像跳转
    NSDictionary *imageDic=[NSDictionary dictionary];
    if (tap.view.tag-BUTTONTAG<=0) {
        imageDic=self.barrageInfo[tap.view.tag-BUTTONTAG+1];
    }else{
    imageDic=self.barrageInfo[tap.view.tag-BUTTONTAG];
    }
    NSString *string=[imageDic objectForKey:@"messagePicture"];
    NSArray *array = [string componentsSeparatedByString:@";"];
    NSLog(@"%@",array);
    self.imageNameArray=[[NSMutableArray alloc]initWithArray:array];
     if (array.count==2) {
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
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageNameArray[i]]placeholderImage:nil options:SDWebImageRetryFailed];
        [self.viewArr addObject:imageView];
    }
    NSArray <UIView *> * views = self.viewArr;
    self.carouseView = [[YWCarouseView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) withTwo:viewArrIsTwo withViews:views withPageControl:NO];
    [self addSubview:self.carouseView];
}
-(void)onClickImage:(UITapGestureRecognizer *)tap{
    //点击头像跳转
    NSDictionary *imageDic=nil;
    if (tap.view.tag==0) {
        imageDic=self.barrageInfo[0];
    }
    else{
    imageDic= self.barrageInfo[tap.view.tag-1];
    }
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
    //当有图片展开且有回复的时候
      for (NSNumber *tag in self.allShowImageTags) {
         if ([tag intValue]==index+5*BUTTONTAG) {
              for (NSNumber *count in self.publishCountArr ) {
                   if ([count intValue]==index) {
                   return DEF_WIDTH(self)/2-10+([[self.heightDic objectForKey:@([tag intValue]-5*BUTTONTAG)]intValue] -85.0)*DEF_Adaptation_Font+ (DEF_WIDTH(self)/2-10)-60*DEF_Adaptation_Font*0.5+[[self.heightPublishDic objectForKey:@([count intValue])]intValue];
                   }
              }
         }
      }
    //当有展开且有回复的时候
    for (NSNumber *tag in self.allShowTags) {
        if ([tag intValue]==index+3*BUTTONTAG) {
            for (NSNumber *count in self.publishCountArr ) {
                if ([count intValue]==index) {
                   return DEF_WIDTH(self)/2-10+([[self.heightDic objectForKey:@([tag intValue]-3*BUTTONTAG)]intValue] -85.0)*DEF_Adaptation_Font+20*DEF_Adaptation_Font*0.5+[[self.heightPublishDic objectForKey:@([count intValue])]intValue];
                }
            }
        }
    }
//当没有评论的时候
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
    for (NSNumber *count in self.publishCountArr ) {
         if ([count intValue]==index) {
        return DEF_WIDTH(self)/2-10+[[self.heightPublishDic objectForKey:@([count intValue])]intValue];
         }
    }
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
//        CGRect f3=self.movieController.view.frame;
//        f3.size.height=-yOffset+60*DEF_Adaptation_Font*0.5;
//        f3.size.width=DEF_WIDTH(self) + fabs(xOffset)*2;
//        self.movieController.view.frame= f3;
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
   _collectView.contentInset = UIEdgeInsetsMake(450*DEF_Adaptation_Font*0.5, 0, 0, 0 );
    //    NSLog(@"总长度:%f,加上的长度:%f", 40 - self.collectView.contentOffset.y-160*DEF_Adaptation_Font*0.5,80*DEF_Adaptation_Font*0.5);
}

@end
