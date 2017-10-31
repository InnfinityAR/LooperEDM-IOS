//
//  FamilySearchView.m
//  Looper
//
//  Created by 工作 on 2017/9/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilySearchView.h"
#import "FamilyViewModel.h"
#import "UIImageView+WebCache.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "FamilyRankView.h"
@interface FamilySearchView()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>
{
    FamilyRankView *rankView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *searchDatas;
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation FamilySearchView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self initView];
    }
    return self;
    
}
-(void)initView{
     [self setBackgroundColor:[UIColor colorWithRed:86/255.0 green:77/255.0 blue:109/255.0 alpha:1.0]];
//    [self.tableView setHidden:NO];
//    [self.tableView reloadData];
    [self initBackView];
     [self addSubview:self.searchBar];
    rankView=[[FamilyRankView alloc]initWithFrame:CGRectMake(0, 130*DEF_Adaptation_Font*0.5, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 130*DEF_Adaptation_Font*0.5)andObject:self.obj andDataArr:self.searchDatas andType:0];
    [self addSubview:rankView];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
       
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        [self.obj searchRaverFamilyDataForSearchText:self.searchBar.text];
    }
}

-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    UIButton *serachBtn = [LooperToolClass createBtnImageName:@"chatlist_serach.png" andRect:CGPointMake(503, 46) andTag:101 andSelectImage:@"chatlist_serach.png" andClickImage:@"chatlist_serach.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:serachBtn];
//    UIImageView *line = [LooperToolClass createImageView:@"bg_serach_line.png" andRect:CGPointMake(66, 120) andTag:100 andSize:CGSizeMake(519, 1) andIsRadius:false];
//     [self addSubview:line];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(60*DEF_Adaptation_Font*0.5, 115*DEF_Adaptation_Font*0.5, 519*DEF_Adaptation_Font*0.5, 1.0*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor whiteColor];
    [self addSubview:lineV];
   
}
-(void)initSearchData:(NSArray*)searchData{
    self.searchDatas=searchData;
    [rankView reloadData:searchData];
//    [self.tableView reloadData];
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(76 * DEF_Adaptation_Font*0.5, 60 * DEF_Adaptation_Font*0.5, 477*0.5*DEF_Adaptation_Font, 50 * DEF_Adaptation_Font*0.5)];
        
        _searchBar.delegate = self;
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.barStyle = UIBarStyleBlack;
        _searchBar.placeholder = @"搜索family(姓名，id，城市)";
        [_searchBar becomeFirstResponder];
        
        [self addSubview:_searchBar];
        UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
        [txfSearchField setBackgroundColor:[UIColor clearColor]];
        [txfSearchField setLeftViewMode:UITextFieldViewModeNever];
        [txfSearchField setRightViewMode:UITextFieldViewModeNever];
        [txfSearchField setBackground:[UIImage imageNamed:@"searchbar_bgImg.png"]];
        [txfSearchField setBorderStyle:UITextBorderStyleNone];
        txfSearchField.layer.borderColor = [UIColor clearColor].CGColor;
        txfSearchField.clearButtonMode=UITextFieldViewModeNever;
    }
    return  _searchBar;
}
#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //    [self.obj searchRaverFamilyDataForSearchText:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [_obj searchRaverFamilyDataForSearchText:searchBar.text];
    [self endEditing:true];
}
#pragma -UITableView,在这里没用到，直接使用了familyRankView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130*DEF_Adaptation_Font*0.5, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 130*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:true];
}
@end
