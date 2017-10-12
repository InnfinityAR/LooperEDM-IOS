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
    CGSize cellSize = CGSizeMake(DEF_WIDTH(self)-14, (DEF_WIDTH(self)));
    
    return cellSize;
}
// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    // 取出每个item所需要的数据
//    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.item];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 14, DEF_WIDTH(self)-14,(DEF_WIDTH(self)-14))];
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
    UIImageView *bgIV=[[UIImageView alloc]initWithFrame:CGRectMake(8*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-16*DEF_Adaptation_Font*0.5, 290*DEF_Adaptation_Font*0.5)];
    [bgIV sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"photo"]]];
    bgIV.layer.cornerRadius=5*DEF_Adaptation_Font*0.5;
    bgIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:bgIV];
    cell.contentView.backgroundColor=ColorRGB(84, 77, 107, 1.0);
    UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0,0, DEF_WIDTH(self)-16*DEF_Adaptation_Font*0.5, 290*DEF_Adaptation_Font*0.5)];
    bkView.backgroundColor=ColorRGB(0, 0, 0, 0.1);
    [bgIV addSubview:bkView];
    UIView *bottomV1=[[UIView alloc]initWithFrame:CGRectMake(70*DEF_Adaptation_Font*0.5, 160*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkView)-100*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    bottomV1.backgroundColor=[self viewColorWithRow:indexPath.row];
    [bgIV addSubview:bottomV1];
    UIView *bottomV2=[[UIView alloc]initWithFrame:CGRectMake(50*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkView)-100*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    bottomV2.backgroundColor=ColorRGB(0, 0, 0, 0.3);
    [bgIV addSubview:bottomV2];
       UILabel  *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(5*DEF_Adaptation_Font*0.5, 120*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkView)-10*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    contentLB.textColor=[UIColor whiteColor];
    contentLB.textAlignment=NSTextAlignmentCenter;
    contentLB.text=[dataDic objectForKey:@"activityname"];
    contentLB.font=[UIFont boldSystemFontOfSize:22];
    [bgIV addSubview:contentLB];
    UILabel  *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(50*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkView)-100*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
    timeLB.textColor=[UIColor whiteColor];
    timeLB.textAlignment=NSTextAlignmentCenter;
    timeLB.text=[[dataDic objectForKey:@"timetag"]substringToIndex:10];
    timeLB.font=[UIFont systemFontOfSize:18];
    [bgIV addSubview:timeLB];
//设置自适应图片
    UIImageView *imageV=[self WidthImageViewWithString:@"http://loyalty.a2storm.cn/assets/logo-eb5daa11ecf3c928938a72492f281cef3e3b7ee5ab746eaf96ed71d900e3af29.png"];
//     UIImageView *imageV=[self WidthImageViewWithString:[dataDic objectForKey:@"brandlogo"]];
    [cell.contentView addSubview:imageV];
    return cell;
    
}
-(UIImageView *)WidthImageViewWithString:(NSString *)url{
    __block CGFloat itemW = 0;
    __block CGFloat itemH = 70*DEF_Adaptation_Font*0.5;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, 26*DEF_Adaptation_Font*0.5,200*DEF_Adaptation_Font*0.5, itemH)];
        NSURL * URL = [NSURL URLWithString:url];
//加入默认本地图片
        [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@""]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        BOOL existBool = [manager diskImageExistsForURL:URL];//判断是否有缓存
        UIImage * image;
        if (existBool) {
            image = [[manager imageCache] imageFromDiskCacheForKey:URL.absoluteString];
        }else{
            NSData *data = [NSData dataWithContentsOfURL:URL];
            image = [UIImage imageWithData:data];
        }
    if (image==nil) {
//加入默认本地图片
          image=[UIImage imageNamed:@""];
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
    
//    NSDictionary *dic=self.dataArr[indexPath.row];
}
-(UIColor *)viewColorWithRow:(NSInteger)row{
    if (row%3==0) {
        return ColorRGB(223, 100, 92, 1.0);
    }else if(row%3==1){
        return ColorRGB(118, 183, 249, 1.0);
    }
    return ColorRGB(126, 128, 230, 1.0);
}
@end
