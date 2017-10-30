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
static const CGFloat kButtonWidth =70; // 导航按钮宽度
@interface SerachView()
{
    UIScrollView *_titleScrollView;    // 标题栏
    NSArray *titleArray;
    UIScrollView *_contentScrollview;  // 内容区
    UIView *_buttonCircle;               // 标题小横线
    NSInteger _pageCount;              // 分页数
}
@property (nonatomic,strong) NSMutableArray *tableViews;
@end
@implementation SerachView {
    
    
    UISearchBar*  mySeatchBar;
    NSMutableArray *serachDataLoop;
    NSMutableArray *serachDataUser;
    NSMutableArray *MusicArray;
    NSMutableArray *AlbumnArray;
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
    serachDataLoop = [[NSMutableArray alloc] initWithCapacity:50];
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
    titleArray = @[@"loop", @"用户", @"歌曲", @"相册", @"艺人", @"家族"];
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
    [_contentScrollview setContentOffset:CGPointMake(DEF_WIDTH(self) * pageIndex, 0) animated:YES];
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
    if (deltaX > maxDeltaX)
    {
        // 最右边不能超范围
        deltaX = maxDeltaX;
    }
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
    serachDataLoop = DataLoop;
    serachDataUser = DataUser;
    MusicArray=musicArr;
    AlbumnArray=albumnArr;
    for (UITableView *tableView in self.tableViews) {
        [tableView reloadData];
    }
}
#pragma -UITableView
-(void)createTableViewWithCount:(NSInteger)count andSuperView:(UIView *)view{
    UITableView  *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 0,DEF_WIDTH(self), DEF_HEIGHT(self)-180*DEF_Adaptation_Font*0.5)style:UITableViewStylePlain];
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
        return [serachDataLoop count];
    }else if([self judgeTableViewCount:tableView]==1){
        return [serachDataUser count];
    }
    else if([self judgeTableViewCount:tableView]==2){
        return [MusicArray count];
    }
    else if([self judgeTableViewCount:tableView]==3){
        return [AlbumnArray count];
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
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    
    
    if([self judgeTableViewCount:tableView]==0){
        
        UIView *tempBg = [LooperToolClass createViewAndRect:CGPointMake(66*DEF_Adaptation_Font_x*0.5,10*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(88*DEF_Adaptation_Font_x*0.5, 88*DEF_Adaptation_Font*0.5) andIsRadius:true andImageName:[[serachDataLoop objectAtIndex:indexPath.row] objectForKey:@"news_img"]];
        
        [cell.contentView addSubview:tempBg];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 35*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(334*DEF_Adaptation_Font_x*0.5, 38*DEF_Adaptation_Font_x*0.5) andText:[[serachDataLoop objectAtIndex:indexPath.row] objectForKey:@"news_title"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [cell.contentView addSubview:titleNum];
        
    }else if([self judgeTableViewCount:tableView]==1){
        UIView *tempBg = [LooperToolClass createViewAndRect:CGPointMake(66*DEF_Adaptation_Font_x*0.5,10*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(88*DEF_Adaptation_Font_x*0.5, 88*DEF_Adaptation_Font*0.5) andIsRadius:true andImageName:[[serachDataUser objectAtIndex:indexPath.row] objectForKey:@"headimageurl"]];
        
        [cell.contentView addSubview:tempBg];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 35*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(334*DEF_Adaptation_Font_x*0.5, 38*DEF_Adaptation_Font_x*0.5) andText:[[serachDataUser objectAtIndex:indexPath.row] objectForKey:@"nickname"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [cell.contentView addSubview:titleNum];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  110*DEF_Adaptation_Font*0.5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self judgeTableViewCount:tableView]==0){
//Loop
        NSDictionary *data = [serachDataLoop objectAtIndex:indexPath.row];
        [_obj movelooperPos:data];
    }else if([self judgeTableViewCount:tableView]==1){
//用户
        NSDictionary *data = [serachDataUser objectAtIndex:indexPath.row];
        if([[data objectForKey:@"userid"] isEqualToString:[LocalDataMangaer sharedManager].uid]!=true){
            [_obj createUserView:data];
        }else{
            [[DataHander sharedDataHander] showViewWithStr:@"不能和自己聊天" andTime:2 andPos:CGPointZero];
        }
    }
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
    mySeatchBar.placeholder = @"搜索Loop、用户";
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
