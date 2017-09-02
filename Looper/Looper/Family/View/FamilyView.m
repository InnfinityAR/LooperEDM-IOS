//
//  FamilyView.m
//  Looper
//
//  Created by lujiawei on 28/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FamilyView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "FamilyRankView.h"
#import "FamilyMessageView.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+_DScrollView.h"
#import <objc/runtime.h>

@interface FamilyView()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchDatas;
@end
@implementation FamilyView{
    
    
    FamilyRankView *rankView;
    FamilyRankView *listView;
    FamilyMessageView *messageView;
    
//用于页面切换
//    UIView *contentView;
    UIScrollView *_sc;
    int localCurrent;
    
    
}


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self.obj setFamilyView:self];
        [self initView];
        [self initBackView];
    }
    return self;
    
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        [self.searchController removeFromParentViewController];
        [self removeFromSuperview];
        [_obj popController];
    }
    if (button.tag==101) {
        //家族搜索
        // 是否自动隐藏导航
        self.searchController.hidesNavigationBarDuringPresentation = NO;
        // 将searchBar赋值给tableView的tableHeaderView
        self.tableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.searchBar.delegate = self;
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        
    }
}

#pragma-在这里加入搜索
-(void)initSearchData:(NSArray*)searchData{
    self.searchDatas=searchData;
    [self.tableView reloadData];
}
-(UISearchController *)searchController{
    if (!_searchController) {
        _searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
        // 设置结果更新代理
        _searchController.searchResultsUpdater = self;
        // 因为在当前控制器展示结果, 所以不需要这个透明视图
        _searchController.dimsBackgroundDuringPresentation = NO;
        UITextField *txfSearchField = [_searchController.searchBar valueForKey:@"_searchField"];
        txfSearchField.placeholder=@"search(ID/city/familyName)";
        txfSearchField.backgroundColor=[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0];
        txfSearchField.textColor=[UIColor whiteColor];
        [txfSearchField setLeftViewMode:UITextFieldViewModeNever];
    }
    return _searchController;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=YES;
        _tableView.bounces=NO;
        [self addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setTableViewCellView:cell andIndexPath:indexPath];
    return cell;
    
}

-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *dataDic=self.searchDatas[indexPath.row];
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(11*DEF_Adaptation_Font, 17*DEF_Adaptation_Font, 28*DEF_Adaptation_Font, 28*DEF_Adaptation_Font)];
    [headIV sd_setImageWithURL:[NSURL URLWithString:dataDic[@"images"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
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
    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:86/255.0 green:77/255.0 blue:109/255.0 alpha:1.0];
    }else{
        cell.contentView.backgroundColor=[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0];
        
    }
    cell.layer.masksToBounds=YES;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  62*DEF_Adaptation_Font;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选择了列表中的%@", [self.searchDatas objectAtIndex:indexPath.row]);
    
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    //用于判断字符是否存在于字符串当中
    //        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    CGRect barFrame = CGRectMake(0, 0, self.frame.size.width, 64);
    // 移动到屏幕上方
    barFrame.origin.y = - 64;
    
    
    // 调整tableView的frame为全屏
    CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y = 20;
    tableFrame.size.height = self.frame.size.height -20;
    self.tableView.frame = tableFrame;
    [UIView animateWithDuration:0.4 animations:^{
        
        [self layoutIfNeeded];
        [self.tableView layoutIfNeeded];
    }];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    // 调整tableView的frame为全屏
    CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y = 64;
    tableFrame.size.height = self.frame.size.height - 64;
    
    
    [UIView animateWithDuration:0.4 animations:^{
        self.tableView.frame = tableFrame;
    }];
    [[self.obj obj]navigationController].navigationBar.hidden = YES;
    [self.tableView setHidden:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.obj searchRaverFamilyDataForSearchText:searchText];
}


#pragma-添加BackView
-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UIButton *searchBtn = [LooperToolClass createBtnImageNameReal:@"btn_serach_select.png" andRect:CGPointMake(DEF_WIDTH(self)-84*DEF_Adaptation_Font*0.5,10*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_serach_select.png" andClickImage:@"btn_serach_select.png" andTextStr:nil andSize:CGSizeMake(54*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:searchBtn];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = [scrollView contentOffset];
    int currentPage = offset.x/DEF_SCREEN_WIDTH;
    if (currentPage == 0) {
        
        if(localCurrent ==currentPage){
            
            [_sc setContentOffset:CGPointMake(DEF_SCREEN_WIDTH * (7-1), 0) animated:NO];
        }
    }
    else if(currentPage == 6) {
        if (localCurrent==currentPage) {
            [_sc setContentOffset:CGPointMake(0, 9) animated:NO];
        }
    };
    localCurrent=currentPage;
}

-(void)initView{
    
    UIImageView *bk_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [bk_image setImage:[UIImage imageNamed:@"bg_family.png"]];
    [self addSubview:bk_image];
    [self initSCView];
    [self.obj getFamilyRankDataForOrderType:nil andRaverId:nil];
    [self.obj getRaverData];
}

-(void)initFamilyRankWithDataArr:(NSArray *)dataArr{
     rankView=[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:1];
    [_sc addSubview:rankView];
    
}
-(void)initFamilyListWithDataArr:(NSArray *)dataArr{
    rankView =[[FamilyRankView alloc]initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+DEF_WIDTH(self), 0, 582*DEF_Adaptation_Font*0.5, 976*DEF_Adaptation_Font*0.5) andObject:self.obj andDataArr:dataArr andType:0];
    [_sc addSubview:rankView];
}
-(void)initSCView{
    _sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5,117*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 976*DEF_Adaptation_Font*0.5)];
    for (int i=0; i<3; i++) {
        
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5+i *582*DEF_Adaptation_Font*0.5+(i*58*DEF_Adaptation_Font*0.5), 0, 582*DEF_Adaptation_Font*0.5,  976*DEF_Adaptation_Font*0.5)];
       // view.backgroundColor = [UIColor colorWithRed:86/255.0 green:79/255.0 blue:109/255.0 alpha:1.0];
        [_sc addSubview:view];
        
    }
    _sc.contentSize = CGSizeMake(DEF_SCREEN_WIDTH*3, 0);
    _sc.delegate = self;
    _sc.pagingEnabled = YES;
    
    [_sc make3Dscrollview];
    
    [self addSubview:_sc];
}

@end
