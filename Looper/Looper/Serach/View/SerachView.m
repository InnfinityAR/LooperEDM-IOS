//
//  SerachView.m
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "SerachView.h"
#import "SerachViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "DataHander.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"
static const CGFloat kButtonWidth =70; // 导航按钮宽度
@interface SerachView()
{
    UIScrollView *_titleScrollView;    // 标题栏
    NSArray *titleArray;
    UIScrollView *_contentScrollview;  // 内容区
    UIView *_buttonCircle;               // 标题小横线
    NSInteger _pageCount;              // 分页数
    
    UIView *headView;
}
@property (nonatomic,strong) NSMutableArray *tableViews;
@end
@implementation SerachView {
    
    
    UISearchBar*  mySeatchBar;
    NSMutableArray *ActivityArray;
    NSMutableArray *userArray;
    NSMutableArray *DJArray;
    NSMutableArray *RaverArray;
}
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (SerachViewModel*)idObject;
        [self initView];
    }
    return self;
}
-(NSMutableArray *)tableViews{
    if (!_tableViews) {
        _tableViews=[[NSMutableArray alloc]init];
    }
    return _tableViews;
}
-(void)initView{
    ActivityArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
    [self createSerachViewHud];
    [self createTitleScrollView];
    [self createButtonCricle];
    [self createContentScrollview];
}
- (void)createTitleScrollView
{
// 标题栏,包括小横线的位置
    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 44*DEF_Adaptation_Font*0.5)];
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.bounces = NO;
    _titleScrollView.delegate = self;
    [self addSubview:_titleScrollView];
// 添加button
    titleArray = @[@"活动", @"用户", @"艺人", @"家族"];
    _pageCount = titleArray.count;
    _titleScrollView.contentSize = CGSizeMake(kButtonWidth * _pageCount+DEF_WIDTH(self)/2-kButtonWidth/2, 40*DEF_Adaptation_Font*0.5);
    for (int i = 0; i < _pageCount; i++)
    {
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(kButtonWidth * i+DEF_WIDTH(self)/2-kButtonWidth/2, 0, kButtonWidth, 40*DEF_Adaptation_Font*0.5)];
        [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [titleBtn addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchDown];
        titleBtn.tag = 1000 + i; // button做标记，方便后面索引，为了不出冲突，就把这个数值设得大一些
        [_titleScrollView addSubview:titleBtn];
    };
}
- (void)createButtonCricle
{
    // 初始时刻停在最左边与按钮对齐
    _buttonCircle = [[UIView alloc] initWithFrame:CGRectMake(DEF_WIDTH(self)/2-1*DEF_Adaptation_Font, 40*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font, 2*DEF_Adaptation_Font)];
    _buttonCircle.backgroundColor = [UIColor whiteColor];
    // 小横线加载scrollview上才能跟随button联动
    [_titleScrollView addSubview:_buttonCircle];
}

- (void)createContentScrollview
{
    // 添加内容页面
    _contentScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), DEF_HEIGHT(self)-180*DEF_Adaptation_Font*0.5)];
    _contentScrollview.pagingEnabled = YES;
    _contentScrollview.bounces = NO;
    _contentScrollview.contentSize = CGSizeMake(DEF_WIDTH(self) * _pageCount, DEF_HEIGHT(self)-180*DEF_HEIGHT(self));
    _contentScrollview.showsHorizontalScrollIndicator = NO;
    _contentScrollview.delegate = self;
    [self addSubview:_contentScrollview];
    // 添加分页面
    for (int i = 0; i < _pageCount; i++)
    {
        UIView *contentV=[[UIView alloc]initWithFrame:CGRectMake(DEF_WIDTH(self)*i,0, DEF_WIDTH(self), DEF_HEIGHT(self)-180*DEF_Adaptation_Font*0.5)];
//        contentV.backgroundColor=ColorRGB(random()%255, random()%255, random()%255, 1.0);
        [_contentScrollview addSubview:contentV];
        [self createTableViewWithCount:i andSuperView:contentV];
    }
    // 初始化后选中某个栏目
    [self titleButtonClicked:[_titleScrollView viewWithTag:1000 + 0]];
}
#pragma mark - 标题button点击事件
- (void)titleButtonClicked:(UIButton *)sender
{
    // 根据点击的button切换页面和偏移
    printf("%s clicked\n", sender.currentTitle.UTF8String);
    // 强调被选中的button
    // 放大聚焦
    sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    // 变色
//    [sender setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    // 居中title
    [self settleTitleButton:sender];
    // 带动画切换到对应的内容,会触发scrollViewDidScroll
    NSInteger pageIndex = sender.tag - 1000;
    [_contentScrollview setContentOffset:CGPointMake(DEF_WIDTH(self) * pageIndex, 0) animated:NO];
}
#pragma mark - 标题按钮和横线居中偏移
- (void)settleTitleButton:(UIButton *)button
{
    // 这个偏移量是相对于scrollview的content frame原点的相对对标
    CGFloat deltaX = button.center.x - DEF_WIDTH(self) / 2;
    // 设置偏移量，记住这段算法
    if (deltaX < 0)
    {
        // 最左边
        deltaX = 0;
    }
    CGFloat maxDeltaX = _titleScrollView.contentSize.width - DEF_WIDTH(self);
//    if (deltaX > maxDeltaX)
//    {
//        // 最右边不能超范围
//        deltaX = maxDeltaX;
//    }
    [_titleScrollView setContentOffset:CGPointMake(deltaX, 0) animated:YES];
}
#pragma mark - scrollview滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
// 根据content内容偏移调整标题栏
    if (scrollView == _titleScrollView)
    {
        printf("title moved\n");
    }
    else if (scrollView == _contentScrollview)
    {
        printf("content moved\n");
        // 获得左右两个button的索引, 注意最后取整
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger leftTitleIndex = offsetX / DEF_WIDTH(self);
        NSInteger rightTitleIndex = leftTitleIndex + 1;
        // 因为设置了到边不能滑动，所以不考虑边界
        UIButton *leftTitleButton = [_titleScrollView viewWithTag:1000 + leftTitleIndex];
        UIButton *rightTitleButton = [_titleScrollView viewWithTag:1000 + rightTitleIndex];
        // 设置大小和颜色渐变以及小横线的联动
        // 权重因子 0~1 小数, 左边和右边互补
        CGFloat rightTitleFactor = offsetX / DEF_WIDTH(self) - leftTitleIndex;
        CGFloat leftTitleFactor = 1 - rightTitleFactor;
        // 尺寸
        CGFloat maxExtraScale = 1.2 - 1;
        leftTitleButton.transform = CGAffineTransformMakeScale(1 + leftTitleFactor * maxExtraScale, 1 + leftTitleFactor * maxExtraScale);
        rightTitleButton.transform = CGAffineTransformMakeScale(1 + rightTitleFactor * maxExtraScale, 1 + rightTitleFactor * maxExtraScale);
        // 颜色
//        UIColor *leftTitleColor = [UIColor colorWithRed:0 green:leftTitleFactor blue:0 alpha:1];
//        UIColor *rightTitleColor = [UIColor colorWithRed:0 green:rightTitleFactor blue:0 alpha:1];
//        [leftTitleButton setTitleColor:leftTitleColor forState:UIControlStateNormal];
//        [rightTitleButton setTitleColor:rightTitleColor forState:UIControlStateNormal];
        // 小横线位移
        _buttonCircle.frame = CGRectMake(kButtonWidth * (leftTitleIndex + rightTitleFactor)-1*DEF_Adaptation_Font+DEF_WIDTH(self)/2, _buttonCircle.frame.origin.y, 2*DEF_Adaptation_Font, 2*DEF_Adaptation_Font);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 内容区块滑动结束调整标题栏居中
    if (scrollView == _contentScrollview)
    {
        // 取得索引值
        NSInteger titleIndex = scrollView.contentOffset.x / DEF_WIDTH(self);
        // title居中
        [self settleTitleButton:[_titleScrollView viewWithTag:1000 + titleIndex]];
    }
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==100){
        [_obj popController];
    }else if(button.tag==101){
        [_obj serachStr:mySeatchBar.text];
        [self endEditing:true];
    }
}
-(void)reloadTableData:(NSMutableArray*)DataLoop andUserArray:(NSMutableArray*)DataUser andMusicArr:(NSMutableArray *)musicArr andAlbumnArr:(NSMutableArray *)albumnArr{
    ActivityArray = DataLoop;
    userArray = DataUser;
    DJArray=musicArr;
    RaverArray=albumnArr;
    for (UITableView *tableView in self.tableViews) {
        [tableView reloadData];
    }
}
-(void)initHeaderVWithSuper:(UIView *)superV{
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 10*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 75*DEF_Adaptation_Font*0.5)];
    headView.backgroundColor=ColorRGB(41, 41, 46, 0.7);
    [superV addSubview:headView];
    UILabel *familyLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 292*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    familyLB.text=@"家族";
    familyLB.userInteractionEnabled=YES;
//    familyLB.tag=1;
//    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
//    [familyLB addGestureRecognizer:singleTap];
    [self addSubview:familyLB];
    familyLB.textColor=[UIColor whiteColor];
    familyLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    familyLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:familyLB];
    UILabel *rankLB=[[UILabel alloc]initWithFrame:CGRectMake(292*DEF_Adaptation_Font*0.5, 0, 58*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    rankLB.text=@"等级";
    rankLB.userInteractionEnabled=YES;
//    rankLB.tag=2;
//    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
//    [rankLB addGestureRecognizer:singleTap1];
    [self addSubview:rankLB];
    rankLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    rankLB.textColor=[UIColor whiteColor];
    rankLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:rankLB];
    UILabel *livenessLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 0, 116*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    livenessLB.numberOfLines=0;
    livenessLB.textAlignment=NSTextAlignmentCenter;
    livenessLB.userInteractionEnabled=YES;
    livenessLB.text=@"位置";
//    livenessLB.tag=3;
//    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
//    [livenessLB addGestureRecognizer:singleTap2];
    [self addSubview:livenessLB];
    livenessLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    livenessLB.textColor=[UIColor whiteColor];
    livenessLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:livenessLB];
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(466*DEF_Adaptation_Font*0.5, 0, DEF_WIDTH(self)-466*DEF_Adaptation_Font*0.5, DEF_HEIGHT(headView))];
    personNumLB.text=@"人数\n(500人)";
    personNumLB.userInteractionEnabled=YES;
//    personNumLB.tag=4;
//    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickActivityLB:)];
//    [personNumLB addGestureRecognizer:singleTap3];
    [self addSubview:personNumLB];
    personNumLB.numberOfLines=0;
    personNumLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    personNumLB.textColor=[UIColor whiteColor];
    personNumLB.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:personNumLB];
}
#pragma -UITableView
-(void)createTableViewWithCount:(NSInteger)count andSuperView:(UIView *)view{
    UITableView  *tableView =nil;
    if (count!=3) {
      tableView=[[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 0,DEF_WIDTH(self), DEF_HEIGHT(self)-180*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
        tableView.bounces=NO;
    }else{
        tableView=[[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 75*DEF_Adaptation_Font*0.5,DEF_WIDTH(self), DEF_HEIGHT(self)-(180+75)*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
        [self initHeaderVWithSuper:view];
        [headView setHidden:YES];
    }
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [view addSubview:tableView];
    [self.tableViews addObject:tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self judgeTableViewCount:tableView]==0){
        return [ActivityArray count];
    }else if([self judgeTableViewCount:tableView]==1){
        return [userArray count];
    }
    else if([self judgeTableViewCount:tableView]==2){
        return [DJArray count];
    }
    else if([self judgeTableViewCount:tableView]==3){
        if (RaverArray.count>0) {
            [headView setHidden:NO];
        }else{
              [headView setHidden:YES];
        }
        return [RaverArray count];
    }
    return 0;
}
-(NSInteger)judgeTableViewCount:(UITableView *)tableView{
    for (int i=0; i<self.tableViews.count; i++) {
        UITableView *tableV=self.tableViews[i];
        if ([tableV isEqual:tableView]) {
            return i;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    
    
    if([self judgeTableViewCount:tableView]==0){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, 410*DEF_Adaptation_Font*0.5)];
        [cell.contentView addSubview:bgView];
        [self createActiveCellView:[ActivityArray objectAtIndex:indexPath.row] andBgView:bgView];
    }else if([self judgeTableViewCount:tableView]==1){
        UIView *tempBg = [LooperToolClass createViewAndRect:CGPointMake(66*DEF_Adaptation_Font_x*0.5,20*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(88*DEF_Adaptation_Font_x*0.5, 88*DEF_Adaptation_Font*0.5) andIsRadius:true andImageName:[[userArray objectAtIndex:indexPath.row] objectForKey:@"headimageurl"]];
        
        [cell.contentView addSubview:tempBg];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 35*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(334*DEF_Adaptation_Font_x*0.5, 38*DEF_Adaptation_Font_x*0.5) andText:[[userArray objectAtIndex:indexPath.row] objectForKey:@"nickname"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:titleNum];
    }else if([self judgeTableViewCount:tableView]==2){
        UIView *tempBg = [LooperToolClass createViewAndRect:CGPointMake(66*DEF_Adaptation_Font_x*0.5,20*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(88*DEF_Adaptation_Font_x*0.5, 88*DEF_Adaptation_Font*0.5) andIsRadius:true andImageName:[[DJArray objectAtIndex:indexPath.row] objectForKey:@"images"]];
        [cell.contentView addSubview:tempBg];
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 35*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(334*DEF_Adaptation_Font_x*0.5, 38*DEF_Adaptation_Font_x*0.5) andText:[[DJArray objectAtIndex:indexPath.row] objectForKey:@"djname"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:titleNum];
    }else if([self judgeTableViewCount:tableView]==3){
        [self setTableViewCellView:cell andIndexPath:indexPath];
    }
    if (indexPath.row!=0) {
        UIView *backV=[[UIView alloc]initWithFrame:CGRectMake(150*DEF_Adaptation_Font*0.5, 0, DEF_WIDTH(self)-150*DEF_Adaptation_Font*0.5, 0.8*DEF_Adaptation_Font*0.5)];
        backV.backgroundColor=[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8];
        [cell.contentView addSubview:backV];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self judgeTableViewCount:tableView]==0) {
        return 410*DEF_Adaptation_Font*0.5;
    }  else if ([self judgeTableViewCount:tableView]==3) {
        return 62*DEF_Adaptation_Font;
    }
    return  110*DEF_Adaptation_Font*0.5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self judgeTableViewCount:tableView]==0){
//Loop
        NSDictionary *data = [ActivityArray objectAtIndex:indexPath.row];
//        [_obj movelooperPos:data];
        [self.obj jumpToNActivityViewControllerWithActivityId:data andType:1];
    }else if([self judgeTableViewCount:tableView]==1){
//用户
        NSDictionary *data = [userArray objectAtIndex:indexPath.row];
        if([[data objectForKey:@"userid"] isEqualToString:[LocalDataMangaer sharedManager].uid]!=true){
            [_obj createUserView:data];
        }else{
            [[DataHander sharedDataHander] showViewWithStr:@"不能和自己聊天" andTime:2 andPos:CGPointZero];
        }
    }else if ([self judgeTableViewCount:tableView]==2){
        NSDictionary *data = [DJArray objectAtIndex:indexPath.row];
         [self.obj jumpToNActivityViewControllerWithActivityId:data andType:2];
    }else if ([self judgeTableViewCount:tableView]==3){
      NSDictionary *dataDic = [RaverArray objectAtIndex:indexPath.row];
     [self.obj getFamilyApplyDataWithDataDic:dataDic];
    }
}
-(void)createActiveCellView:(NSDictionary*)data andBgView:(UIView*)view{
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5,44*DEF_Adaptation_Font*0.5, 210*DEF_Adaptation_Font*0.5, 308*DEF_Adaptation_Font*0.5)];
    [imageV sd_setImageWithURL:[[NSURL alloc] initWithString: [data objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    imageV.tag = [[data objectForKey:@"activityid"] intValue];
//    imageV.userInteractionEnabled=YES;
//    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createActiveView:)];
//    [imageV addGestureRecognizer:singleTap];
    
    imageV.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
    imageV.layer.masksToBounds = YES;
    [view addSubview:imageV];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(276*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 78*DEF_Adaptation_Font*0.5)];
    titleLable.numberOfLines = 0;
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:20]];
    titleLable.text = [data objectForKey:@"activityname"];
    [view addSubview:titleLable];
    UILabel *tagLable=nil;
    if ([data objectForKey:@"tag"]==[NSNull null]) {
        tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
    }else{
        tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
        tagLable.text = [data objectForKey:@"tag"];
        CGSize lblSize3 = [tagLable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 27*DEF_Adaptation_Font*0.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:13]} context:nil].size;
        CGRect frame3=tagLable.frame;
        frame3.size.width=lblSize3.width+30*DEF_Adaptation_Font*0.5;
        tagLable.frame=frame3;
    }
    [tagLable setTextColor:[UIColor whiteColor]];
    [tagLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
    [tagLable setBackgroundColor:[UIColor colorWithRed:25/255.0 green:196/255.0 blue:193/255.0 alpha:1.0]];
    [view addSubview:tagLable];
    [tagLable setTextAlignment:NSTextAlignmentCenter];
    tagLable.layer.cornerRadius = 13*DEF_Adaptation_Font*0.5;
    tagLable.layer.masksToBounds = YES;
    
    UIImageView *icon_time=[LooperToolClass createImageView:@"time.png" andRect:CGPointMake(276, 200) andTag:100 andSize:CGSizeMake(16*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:icon_time];
    
    icon_time.frame = CGRectMake(icon_time.frame.origin.x, icon_time.frame.origin.y, 24*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5);
    
    UIImageView *icon_location=[LooperToolClass createImageView:@"locaton.png" andRect:CGPointMake(276, 242) andTag:100 andSize:CGSizeMake(16*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:icon_location];
    
    icon_location.frame = CGRectMake(icon_location.frame.origin.x, icon_location.frame.origin.y, 24*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5);
    
    
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    [timeLable setTextColor:[UIColor whiteColor]];
    [timeLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    timeLable.text = [data objectForKey:@"timetag"];
    [view addSubview:timeLable];
    
    
    UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5)];
    [locationLable setTextColor:[UIColor whiteColor]];
    locationLable.numberOfLines=0;
    [locationLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    locationLable.text = [data objectForKey:@"place"];
    [locationLable sizeToFit];
    [view addSubview:locationLable];
    
    CGSize maximumSize = CGSizeMake(294*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5);
    NSString *dateString = [data objectForKey:@"place"];
    UIFont *dateFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    CGSize dateStringSize = [dateString sizeWithFont:dateFont
                                   constrainedToSize:maximumSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    CGRect dateFrame = CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, dateStringSize.height);
    locationLable.frame = dateFrame;
    
    if([data[@"ticketurl"] isEqualToString:@""]==true){
        
        UIImageView *icon_price=[LooperToolClass createImageView:@"icon_price.png" andRect:CGPointMake(278, 328) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_price];
    }else{
        UIImageView *icon_ticket=[LooperToolClass createImageView:@"icon_ticket.png" andRect:CGPointMake(278, 328) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_ticket];
    }
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(368*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 235*DEF_Adaptation_Font*0.5, 32*DEF_Adaptation_Font*0.5)];
    [priceLable setTextColor:[UIColor colorWithRed:191/255.0 green:252/255.0 blue:255/255.0 alpha:1.0]];
    [priceLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    priceLable.text = [data objectForKey:@"price"];
    [view addSubview:priceLable];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, view.frame.size.height, 568*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor colorWithRed:160/255.0 green:138/255.0 blue:197/255.0 alpha:0.1f]];
    [view addSubview:line];
}
-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *dataDic=RaverArray[indexPath.row];
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(11*DEF_Adaptation_Font, 17*DEF_Adaptation_Font, 28*DEF_Adaptation_Font, 28*DEF_Adaptation_Font)];
    [headIV sd_setImageWithURL:[NSURL URLWithString:dataDic[@"images"]] placeholderImage:[UIImage imageNamed:@"btn_home.png"]options:SDWebImageRetryFailed];
    headIV.layer.cornerRadius=14*DEF_Adaptation_Font;
    headIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:headIV];
    UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font, 190*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font)];
    headLB.numberOfLines=0;
    headLB.font=[UIFont systemFontOfSize:14];
    headLB.textColor=[UIColor whiteColor];
    headLB.text=dataDic[@"ravername"];
    [cell.contentView addSubview:headLB];
    
    UILabel *rankLB=[[UILabel alloc]initWithFrame:CGRectMake(292*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, 58*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    rankLB.font=[UIFont systemFontOfSize:14];
    rankLB.textColor=[UIColor whiteColor];
    rankLB.textAlignment=NSTextAlignmentCenter;
    if ([dataDic objectForKey:@"raverlevel"]==[NSNull null]) {
        rankLB.text=@"I";
    }else{
        rankLB.text=[dataDic objectForKey:@"raverlevel"];
    }
    [cell.contentView addSubview:rankLB];
    
    UILabel *livenessLB=[[UILabel alloc]initWithFrame:CGRectMake(350*DEF_Adaptation_Font*0.5, 13*DEF_Adaptation_Font, 116*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font)];
    livenessLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    livenessLB.numberOfLines=0;
    livenessLB.textColor=[UIColor whiteColor];
    livenessLB.textAlignment=NSTextAlignmentCenter;
    livenessLB.text=@"上海/黄浦";
    //        livenessLB.text=[dataDic objectForKey:@"raveraddress"];
    [cell.contentView addSubview:livenessLB];
    
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(468*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font, DEF_WIDTH(self)-468*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    personNumLB.text=[dataDic objectForKey:@"membercount"];
    personNumLB.numberOfLines=0;
    personNumLB.font=[UIFont systemFontOfSize:14];
    personNumLB.textColor=[UIColor whiteColor];
    personNumLB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:personNumLB];
    
    cell.layer.masksToBounds=YES;
    
}
#pragma -UISearchBar
-(void)createSerachViewHud{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UIButton *serachBtn = [LooperToolClass createBtnImageName:@"chatlist_serach.png" andRect:CGPointMake(503, 46) andTag:101 andSelectImage:@"chatlist_serach.png" andClickImage:@"chatlist_serach.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:serachBtn];
    //    UIImageView *line = [LooperToolClass createImageView:@"bg_serach_line.png" andRect:CGPointMake(66, 120) andTag:100 andSize:CGSizeMake(519, 1) andIsRadius:false];
    //     [self addSubview:line];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(60*DEF_Adaptation_Font*0.5, 115*DEF_Adaptation_Font*0.5, 519*DEF_Adaptation_Font*0.5, 1.0*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor whiteColor];
    [self addSubview:lineV];
    
    mySeatchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(76 * DEF_Adaptation_Font*0.5, 60 * DEF_Adaptation_Font*0.5, 477*0.5*DEF_Adaptation_Font, 50 * DEF_Adaptation_Font*0.5)];
    mySeatchBar.delegate = self;
    [mySeatchBar setBackgroundColor:[UIColor clearColor]];
    [[[mySeatchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    mySeatchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
    mySeatchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    mySeatchBar.barStyle = UIBarStyleBlack;
    mySeatchBar.placeholder = @"搜索用户,艺人,活动以及家族";
    [mySeatchBar becomeFirstResponder];
    [self addSubview:mySeatchBar];
    
    UITextField *txfSearchField = [mySeatchBar valueForKey:@"_searchField"];
    [txfSearchField setBackgroundColor:[UIColor clearColor]];
    [txfSearchField setLeftViewMode:UITextFieldViewModeNever];
    [txfSearchField setRightViewMode:UITextFieldViewModeNever];
    [txfSearchField setBackground:[UIImage imageNamed:@"searchbar_bgImg.png"]];
    [txfSearchField setBorderStyle:UITextBorderStyleNone];
    txfSearchField.layer.borderColor = [UIColor clearColor].CGColor;
    txfSearchField.clearButtonMode=UITextFieldViewModeNever;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_obj serachStr:mySeatchBar.text];
    [self endEditing:true];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


@end
