//
//  ActivityView.m
//  Looper
//
//  Created by 工作 on 2017/5/17.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityView.h"
#import "LooperConfig.h"
#import "ActivityCell.h"
#import "ActivityViewController.h"
#import "UIImageView+WebCache.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "ActivityCollectionViewCell.h"
@interface ActivityView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UILabel *daoBdaoLB;
    UILabel *onlineLB;
    UIView *lineView;
    //如果是左右滑动的话，不能执行scroll中的改变scrollV的frame的方法
    BOOL isScrollViewScrollForLeftOrRight;
    //用于界面的轻扫切换
    UIScrollView *scrollV;
}
@end
@implementation ActivityView
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray new];
    }
    return _dataArr;
}
-(NSMutableArray *)selectDataArr{
    if (!_selectDataArr) {
        _selectDataArr=[[NSMutableArray alloc]init];
    }
    return _selectDataArr;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        isScrollViewScrollForLeftOrRight=NO;
        self.obj = (ActivityViewModel*)idObject;
                [self initHeadView];
               //加载懒加载
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
        [self.collectView registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self initView];
    }
    return self;
    
}
-(void)initHeadView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 66*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    daoBdaoLB = [LooperToolClass createLableView:CGPointMake(85*DEF_Adaptation_Font*0.5,50*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(500*DEF_Adaptation_Font*0.5/2,97*DEF_Adaptation_Font*0.5) andText:@"叨Bi叨" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:daoBdaoLB];
    daoBdaoLB.tag=1;
    daoBdaoLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [daoBdaoLB addGestureRecognizer:singleTap];
    onlineLB = [LooperToolClass createLableView:CGPointMake(55*DEF_Adaptation_Font*0.5+500*DEF_Adaptation_Font*0.5/2,50*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5/2,97*DEF_Adaptation_Font*0.5) andText:@"在现场" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:onlineLB];
    onlineLB.tag=2;
    onlineLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    onlineLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickView:)];
    [onlineLB addGestureRecognizer:singleTap2];
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 129*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 4)];
    view.image=[UIImage imageNamed:@"AcitivitySeg.png"];
    [self addSubview:view];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(187*DEF_Adaptation_Font*0.5, 131*DEF_Adaptation_Font*0.5, (500/2-204)*DEF_Adaptation_Font*0.5, 2)];
    
    lineView.backgroundColor=[UIColor colorWithRed:107/255.0 green:104/255.0 blue:222/255.0 alpha:1.0];
    [self addSubview:lineView];
    scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 137*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-137*DEF_Adaptation_Font*0.5)];
    scrollV.contentSize=CGSizeMake(DEF_WIDTH(scrollV)*2, DEF_HEIGHT(scrollV));
    scrollV.backgroundColor=[UIColor clearColor];
    scrollV.backgroundColor=[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
    scrollV.pagingEnabled=YES;
    scrollV.bounces=NO;
    scrollV.delegate=self;
    [self addSubview:scrollV];
   
}
-(void)onClickView:(UITapGestureRecognizer *)tap{
    if (tap.view.tag==1) {
        onlineLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        daoBdaoLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        scrollV.contentOffset=CGPointMake(0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=187*DEF_Adaptation_Font*0.5;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (tap.view.tag==2) {
        onlineLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        daoBdaoLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        scrollV.contentOffset=CGPointMake(DEF_WIDTH(self),0);
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=157*DEF_Adaptation_Font*0.5+530*DEF_Adaptation_Font*0.5/2;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }

}
//用于储存线下数据
-(void)reloadCollectData:(NSMutableArray*)DataLoop{
    self.selectDataArr=DataLoop;
//    [self.tableView removeFromSuperview];
//    self.tableView=nil;
    [self.collectView reloadData];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        [self removeFromSuperview];
        [_obj popController];
    }
    if (button.tag==101) {
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,30*DEF_Adaptation_Font*0.5,DEF_WIDTH(self), DEF_HEIGHT(scrollV))style:UITableViewStylePlain];
        [scrollV addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=NO;
        _tableView.bounces=NO;
    }
    return _tableView;
}
-(UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置每个item的大小，
        flowLayout.itemSize = CGSizeMake(DEF_WIDTH(self)/2-10, (DEF_WIDTH(self)/2-10)*1.8);
        //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        // 设置列的最小间距
        flowLayout.minimumInteritemSpacing = 5;
        // 设置最小行间距
        flowLayout.minimumLineSpacing = 5;
        // 设置布局的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        // 滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self), 30*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, DEF_HEIGHT(scrollV)) collectionViewLayout:flowLayout];
        _collectView.backgroundColor = [UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
        // 设置代理
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [scrollV addSubview:_collectView];
    }
    return _collectView;
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0]];
    [self.obj pustDataForSomeString:@""];
    [self.obj requestData];
}
-(void)reloadTableData:(NSMutableArray*)DataLoop{
    self.dataArr=DataLoop;
//    [self.collectView removeFromSuperview];
//    self.collectView=nil;
    [self.tableView reloadData];
}
#pragma -UICollectionView
// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.selectDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 取出每个item所需要的数据
    NSDictionary *dic = [self.selectDataArr objectAtIndex:indexPath.item];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self)/2-10, (DEF_WIDTH(self)/2-10)*1.3)];
    imageView.layer.cornerRadius=5.0;
    imageView.layer.masksToBounds=YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"photo"]]];
    [cell.contentView addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,  (DEF_WIDTH(self)/2-10)*1.3, DEF_WIDTH(self)/2-10, (DEF_WIDTH(self)/2-10)*0.3)];
    label.text=[dic objectForKey:@"activityname"];
    label.textColor=[UIColor whiteColor];
    label.numberOfLines=2;
    [cell.contentView addSubview:label];
        UIView *bottomV=[[UIView alloc]initWithFrame:CGRectMake(0,  (DEF_WIDTH(self)/2-10)*1.6-10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)/2-10, (DEF_WIDTH(self)/2-10)*0.3)];
    [cell.contentView addSubview:bottomV];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(20,  0, DEF_WIDTH(self)/2-10, 40*DEF_Adaptation_Font*0.5)];
    label2.text=[NSString stringWithFormat:@"%@人参加",[dic objectForKey:@"followcount"]];
    label2.textColor=[UIColor colorWithRed:169/255.0 green:167/255.0 blue:183/255.0 alpha:1.0];
    label2.font=[UIFont systemFontOfSize:12];
    [bottomV addSubview:label2];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,  10*DEF_Adaptation_Font*0.5, 15, 12)];
    imageview.image=[UIImage imageNamed:@"sun.png"];
    [bottomV addSubview:imageview];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0,  (DEF_WIDTH(self)/2-10)*0.1, 50, 20)];
    CGRect frame=label3.frame;
    frame.origin=CGPointMake(0,  (DEF_WIDTH(self)/2-10)*0.1);
    NSString *string=[[self getAStringOfChineseWord:[dic objectForKey:@"city"]]componentsJoinedByString:@","];
    string = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    label3.text=[NSString stringWithFormat:@"%@",string];
    label3.textColor=[UIColor whiteColor];
    label3.backgroundColor=[UIColor colorWithRed:109/255.0 green:216/255.0 blue:116/255.0 alpha:1.0];
    UIImageView *label3Shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0,  (DEF_WIDTH(self)/2-10)*0.1, 50, 20)];
    label3Shadow.image=[UIImage imageNamed:@"cityShadow.png"];
    label3.layer.cornerRadius=1.0;
    label3.layer.masksToBounds=YES;
    label3.font=[UIFont systemFontOfSize:14];
    label3.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:label3];
    [cell.contentView addSubview:label3Shadow];
    return cell;
}
//取出字符串中中文
- (NSArray *)getAStringOfChineseWord:(NSString *)string
{
    if (string == nil || [string isEqual:@""])
    {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i<[string length]; i++)
    {
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00)
        {
            [arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return arr;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.selectDataArr objectAtIndex:indexPath.item];
    NSString *activityID=[dic objectForKey:@"activityid"];
    
    [_obj createPhotoWallController:activityID];
    
}
#pragma-UITableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.objDic=[[NSDictionary alloc]initWithDictionary:self.dataArr[indexPath.row]];
    NSDictionary *dic=self.objDic[@"message"];
    if ((![self.objDic[@"message"] isKindOfClass:[NSNull class]])&&![dic  isEqual:@(0)]) {
        [cell.headPhoto sd_setImageWithURL:[NSURL URLWithString:dic[@"userimage"]]];
        //        cell.commentLB.text=[NSString stringWithFormat:@"%@\n",self.objDic[@"activityname"]];
    }
    else{
        cell.headPhoto.image=[UIImage imageNamed:@"bk_front_login.png"];
        cell.commentLB.text=@"战斗之夜，燃烧吧，我的青春";
    }
    if (self.objDic[@"activityimage"]==[NSNull null]) {
        cell.mainPhoto.image=[UIImage imageNamed:@"bk_front_login.png"];
    }
    else{
        [cell.mainPhoto sd_setImageWithURL:[NSURL URLWithString:self.objDic[@"activityimage"]]];
    }
    cell.commentLB.text=self.objDic[@"activitydes"];
    cell.themeLB.text=[NSString stringWithFormat:@"Looper燃烧的战斗之夜!\n%@",self.objDic[@"activityname"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.themeLB.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10*DEF_Adaptation_Font*0.5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cell.themeLB.text length])];
   cell.themeLB.attributedText = attributedString;

    //    cell.themeLB.text=self.objDic[@"activitydes"];
    //    cell.endTimeLB.text=[self.objDic[@"startdate"]substringToIndex:10];
    //    cell.numberLB.text=[self.objDic[@"enddate"]substringToIndex:10];;
    if ([self.objDic[@"followercount"] isEqualToString:@"0"] ){
        if ([self.objDic[@"followercount"]intValue]==0){
            cell.followCountLB.text=@"我要参加";
        }
        else{
            cell.followCountLB.text=[NSString stringWithFormat:@"%@人参加", self.objDic[@"followercount"]];
        }
    }
    return cell;
  
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [self.obj dataForH5:self.dataArr[indexPath.row]];
      NSDictionary *dic=self.dataArr[indexPath.row];
    self.activityID=[dic objectForKey:@"activityid"];
    self.activityDic=dic;
    ActivityBarrageView *view=[[ActivityBarrageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self),DEF_HEIGHT(self)) and:self and:self.obj];
    view.obj=self;
    view.viewModel=self.obj;
    [self addSubview:view];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset=scrollView.contentOffset.x;
    CGFloat moveY=[scrollView.panGestureRecognizer translationInView:self].y;
//    NSLog(@"%f", scrollView.contentOffset.x);
//    NSLog(@"yOffset===%f,panPoint===%f",yOffset,moveY);
    if (xOffset>50*DEF_Adaptation_Font*0.5&&xOffset<640*DEF_Adaptation_Font*0.5) {
        isScrollViewScrollForLeftOrRight=YES;
        //只有在这种情况下才去改变x
    if (xOffset<200*DEF_Adaptation_Font*0.5&&xOffset>50*DEF_Adaptation_Font*0.5) {
        onlineLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        daoBdaoLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=187*DEF_Adaptation_Font*0.5;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];
    }
    if (xOffset>500*DEF_Adaptation_Font*0.5&&xOffset<640*DEF_Adaptation_Font*0.5) {
        onlineLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        daoBdaoLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=lineView.frame;
            frame.origin.x=157*DEF_Adaptation_Font*0.5+530*DEF_Adaptation_Font*0.5/2;
            lineView.frame=frame;
        } completion:^(BOOL finished) {
        }];

    }
    }
    if (isScrollViewScrollForLeftOrRight==NO) {
    if (moveY<0) {
        //往上滑
        CGRect frame=self.tableView.frame;
        frame=CGRectMake(0, 3, DEF_WIDTH(self), DEF_HEIGHT(scrollView));
        self.tableView.frame=frame;
        CGRect frame1=self.collectView.frame;
        frame1=CGRectMake(DEF_WIDTH(self), 3, DEF_WIDTH(self), DEF_HEIGHT(scrollView));
        self.collectView.frame=frame1;

            }
    if (moveY>0) {
        //往下滑
        CGRect frame=self.tableView.frame;
        frame=CGRectMake(0, 30*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(scrollView));
        self.tableView.frame=frame;
        CGRect frame1=self.collectView.frame;
        frame1=CGRectMake(DEF_WIDTH(self), 30*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(scrollView));
        self.collectView.frame=frame1;
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isScrollViewScrollForLeftOrRight=NO;
}
@end
