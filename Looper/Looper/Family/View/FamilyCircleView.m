//
//  FamilyCircleView.m
//  Looper
//
//  Created by 工作 on 2017/10/11.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyCircleView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "FamilyViewModel.h"
#import "UIImageView+WebCache.h"
@interface FamilyCircleView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UILabel *trendsLB;
    UILabel *trackLB;
    UIView *lineView;
    UIScrollView *contentView;
}
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *heightForCollectDic;
@end
@implementation FamilyCircleView
-(instancetype)initWithFrame:(CGRect)frame
                         and:(id)idObject
               andDataSource:(NSArray *)dataSource
                  andDataArr:(NSArray *)dataArr{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)idObject;
        self.dataSource=dataSource;
        self.dataArr=dataArr;
        [self initView];
    }
    return self;
}
//用于计算每个collectionV的高度
-(NSMutableDictionary *)heightForCollectDic{
    if (!_heightForCollectDic) {
        _heightForCollectDic=[[NSMutableDictionary alloc]init];
        for (int i=0; i<self.dataSource.count; i++) {
            NSDictionary *dic=self.dataSource[i];
            CGSize lblSize3 = [[dic objectForKey:@"content"] boundingRectWithSize:CGSizeMake(400*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
            CGFloat height=150*DEF_Adaptation_Font*0.5+lblSize3.height;
            for (NSDictionary *dataDic in [dic objectForKey:@"array"]) {
               CGSize lblSize2 = [[dataDic objectForKey:@"content"] boundingRectWithSize:CGSizeMake(350*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                height+=lblSize2.height+50*DEF_Adaptation_Font*0.5;
            }
            [_heightForCollectDic setObject:@(height) forKey:@(i)];
        }
    }
    return _heightForCollectDic;
}
-(void)initView{
   [self setBackgroundColor:[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0]];
    trendsLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 140*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    trendsLB.textColor=[UIColor whiteColor];
    trendsLB.textAlignment=NSTextAlignmentCenter;
    trendsLB.text=@"伙伴动态";
    trendsLB.font=[UIFont systemFontOfSize:12];
    trendsLB.tag=1;
    trendsLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLB:)];
    [trendsLB addGestureRecognizer:tap];
    [self addSubview:trendsLB];
    trackLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 140*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    trackLB.textColor=ColorRGB(255, 255, 255, 0.6);
    trackLB.textAlignment=NSTextAlignmentCenter;
    trackLB.text=@"家族足迹";
    trackLB.font=[UIFont systemFontOfSize:12];
    trackLB.tag=2;
    trackLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLB:)];
    [trackLB addGestureRecognizer:tap2];
    [self addSubview:trackLB];
    lineView=[[UIView alloc]initWithFrame:CGRectMake(165*DEF_Adaptation_Font*0.5, 64*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5, 4*DEF_Adaptation_Font*0.5)];
    lineView.backgroundColor=ColorRGB(134, 187, 221, 1.0);
    [self addSubview:lineView];
    contentView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-68*DEF_Adaptation_Font*0.5)];
    contentView.contentSize=CGSizeMake(DEF_WIDTH(self)*2, DEF_HEIGHT(self)-68*DEF_Adaptation_Font*0.5);
    contentView.backgroundColor=ColorRGB(84, 77, 107, 1.0);
    contentView.pagingEnabled=YES;
    contentView.bounces=NO;
    contentView.delegate=self;
    [self addSubview:contentView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}
-(void)clickLB:(UITapGestureRecognizer *)tap{
    NSInteger tag=tap.view.tag;
    if (tag==1) {
    trendsLB.textColor=[UIColor whiteColor];
    trackLB.textColor=ColorRGB(255, 255, 255, 0.6);
        CGRect frame=lineView.frame;
        frame.origin.x=165*DEF_Adaptation_Font*0.5;
        lineView.frame=frame;
        contentView.contentOffset=CGPointMake(0, 0);
    }
    else if (tag==2){
        trendsLB.textColor=ColorRGB(255, 255, 255, 0.6);
        trackLB.textColor=[UIColor whiteColor];
        CGRect frame=lineView.frame;
        frame.origin.x=395*DEF_Adaptation_Font*0.5;
        lineView.frame=frame;
        contentView.contentOffset=CGPointMake(DEF_WIDTH(self), 0);
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat xOffset=scrollView.contentOffset.x;
    CGFloat yOffset=scrollView.contentOffset.y;
    xOffset=ceilf(xOffset);
    CGFloat  scollX=ceilf(DEF_WIDTH(self));
    NSLog(@"xoffset:%f,scroll: %f ,yoffset:%f",xOffset,scollX,yOffset);
    if (yOffset==0) {
        if (xOffset<=scollX+20*DEF_Adaptation_Font*0.5&&xOffset>=scollX-20*DEF_Adaptation_Font*0.5) {
            trackLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
            trendsLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame=lineView.frame;
                frame.origin.x=395*DEF_Adaptation_Font*0.5;
                lineView.frame=frame;
            } completion:^(BOOL finished) {
            }];
        }
        if (xOffset>0&&xOffset<20*DEF_Adaptation_Font*0.5){
            trackLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
            trendsLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame=lineView.frame;
                frame.origin.x=165*DEF_Adaptation_Font*0.5;
                lineView.frame=frame;
            } completion:^(BOOL finished) {
            }];
        }
    }
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置每个item的大小，
        //        flowLayout.itemSize = CGSizeMake(DEF_WIDTH(self)-14, (DEF_WIDTH(self)-14));
        //    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        // 设置列的最小间距
        flowLayout.minimumInteritemSpacing = 7;
        // 设置最小行间距
        flowLayout.minimumLineSpacing = 7;
        // 设置布局的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(7, 7, 7, 7);
        // 滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH(self), DEF_HEIGHT(contentView)) collectionViewLayout:flowLayout];
        [contentView addSubview:_collectionView];
        _collectionView.backgroundColor =[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}
#pragma -UICollectionView，家族动态
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeMake(DEF_WIDTH(self)-14, [[self.heightForCollectDic objectForKey:@(indexPath.row)]floatValue]);
    return cellSize;
}
// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 取出每个item所需要的数据
//    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.item];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 14, DEF_WIDTH(self)-14,[[self.heightForCollectDic objectForKey:@(indexPath.row)]floatValue])];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius=5.0;
    imageView.layer.masksToBounds=YES;
    imageView.backgroundColor=ColorRGB(random()%255, random()%255, random()%255, 1.0);
    [cell.contentView addSubview:imageView];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.item];
    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self),0,DEF_WIDTH(self), DEF_HEIGHT(contentView))style:UITableViewStylePlain];
        [contentView addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:86/255.0 green:77/255.0 blue:108/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        //        _tableView.bounces=NO;
        _tableView.alwaysBounceVertical=YES;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}
#pragma-UITableView的代理-伙伴足迹
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *dataDic=[[NSDictionary alloc]initWithDictionary:self.dataArr[indexPath.row]];
    UIImageView *bgIV=[[UIImageView alloc]initWithFrame:CGRectMake(8*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-16*DEF_Adaptation_Font*0.5, 290*DEF_Adaptation_Font*0.5)];
    [bgIV sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"photo"]]];
    bgIV.contentMode=UIViewContentModeScaleAspectFill;
    bgIV.clipsToBounds=YES;
    bgIV.layer.cornerRadius=10*DEF_Adaptation_Font*0.5;
    bgIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:bgIV];
    cell.contentView.backgroundColor=ColorRGB(84, 77, 107, 1.0);
    UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0,0, DEF_WIDTH(self)-16*DEF_Adaptation_Font*0.5, 290*DEF_Adaptation_Font*0.5)];
    bkView.backgroundColor=ColorRGB(0, 0, 0, 0.2);
    [bgIV addSubview:bkView];
       UILabel  *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, DEF_WIDTH(bgIV)-40*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.textAlignment=NSTextAlignmentCenter;
    contentLB.text=[dataDic objectForKey:@"activityname"];
    contentLB.font=[UIFont boldSystemFontOfSize:24];
    //添加阴影效果
//    contentLB.shadowColor = [UIColor blackColor];
//    contentLB.shadowOffset = CGSizeMake(1, 1);
    NSShadow *shadow1=[[NSShadow  alloc]init];
    shadow1.shadowBlurRadius = 10.0;
    shadow1.shadowColor = [UIColor blackColor];
    contentLB.attributedText = [[NSAttributedString alloc] initWithString:contentLB.text attributes:@{NSShadowAttributeName: shadow1}];
    [bgIV addSubview:contentLB];
    
    UILabel  *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(50*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, DEF_WIDTH(bgIV)-100*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    timeLB.textColor=[UIColor whiteColor];
    timeLB.textAlignment=NSTextAlignmentCenter;
    if ([dataDic objectForKey:@"starttime"]!=nil&&[dataDic objectForKey:@"starttime"]!=[NSNull null]) {
    NSString *time=[self timestampSwitchTime:[[dataDic objectForKey:@"starttime"]intValue]];
    if (time!=nil) {
//        timeLB.text=[time substringToIndex:11];
        timeLB.text=[dataDic objectForKey:@"timetag"];
    timeLB.font=[UIFont systemFontOfSize:18];
    //添加阴影效果
    NSShadow *shadow=[[NSShadow  alloc]init];
    shadow.shadowBlurRadius = 10.0;
    shadow.shadowColor = [UIColor blackColor];
    timeLB.attributedText = [[NSAttributedString alloc] initWithString:timeLB.text attributes:@{NSShadowAttributeName: shadow}];
    [bgIV addSubview:timeLB];
    }
    }
//设置自适应图片
    if ([dataDic objectForKey:@"brandlogo"]!=[NSNull null]&&![[dataDic objectForKey:@"brandlogo"]isEqualToString:@""]) {
     UIImageView *imageV=[self WidthImageViewWithString:[dataDic objectForKey:@"brandlogo"]];
    [cell.contentView addSubview:imageV];
    }else{
        UIImage *image=[UIImage imageNamed:@"product_logo.png"];
          UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(-80*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5,image.size.width / image.size.height * 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
        imageV.image=image;
        [cell.contentView addSubview:imageV];
    }
    return cell;
    
}
-(NSString *)timestampSwitchTime:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd号 HH:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}
-(NSString *)changeDateFormatterWithString:(NSString *)string{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:string];
     fmt.dateFormat = @"yyyy年MM月dd号 HH:mm:ss";
    NSString *dateStr=[fmt stringFromDate:date];
    return dateStr;
}
-(UIImageView *)WidthImageViewWithString:(NSString *)url{
    __block CGFloat itemW = 0;
    __block CGFloat itemH = 70*DEF_Adaptation_Font*0.5;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5,200*DEF_Adaptation_Font*0.5, itemH)];
        NSURL * URL = [NSURL URLWithString:url];
//加入默认本地图片
        [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"product_logo.png"]options:SDWebImageRetryFailed];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
   __block  UIImage * image;
    [manager diskImageExistsForURL:URL completion:^(BOOL isInCache) {
        if (isInCache) {
             image = [[manager imageCache] imageFromDiskCacheForKey:URL.absoluteString];
        }else{
            NSData *data = [NSData dataWithContentsOfURL:URL];
            image = [UIImage imageWithData:data];
        }
    }];//判断是否有缓存
    if (image==nil) {
//加入默认本地图片
          image=[UIImage imageNamed:@"product_logo.png"];
    }
        //根据image的比例来设置高度
            itemW = image.size.width / image.size.height * itemH;
    CGRect logoFrame=imageView.frame;
    if (image!=nil) {
    logoFrame.size.width= itemW;
    }
    imageView.frame=logoFrame;
    return imageView;
}
//设置自动适配行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 340*DEF_Adaptation_Font*0.5;
}
//用于传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic=self.dataArr[indexPath.row];
    NSString *activityID=[dic objectForKey:@"activityid"];
    [_obj createPhotoWallController:activityID];
}
//求最大公约数
-(NSInteger)judgeTwoNumberWithA:(NSInteger)a andB:(NSInteger)b{
    NSInteger max=a>b?a:b;
    NSInteger min=a<b?a:b;
    if (max==0) {
        return 0;
    }else{
        return (max%min==0)?min:([self judgeTwoNumberWithA:min andB:(max%min)]);
    }
}
/**
 *  递归设置传入的UIView内所有UILabel的文字颜色
 *
 *  @param view 要设置的UIView
 */
- (void)setupTextColor:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {// 如果子控件是UILabel,则设置文字颜色
            UILabel *label = (UILabel*)subView;
            label.textColor = [UIColor redColor];
        } else { // 如果子控件不是UILabel,则调用自身继续遍历子控件
            [self setupTextColor:subView];
        }
    }
}
@end
