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


@implementation SerachView {
    
    
    UISearchBar*  mySeatchBar;
    UITableView *tableView;
    NSMutableArray *serachDataLoop;
    NSMutableArray *serachDataUser;
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 48*DEF_Adaptation_Font*0.5;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEF_SCREEN_WIDTH, 48*DEF_Adaptation_Font*0.5)];
    [v setBackgroundColor:[UIColor clearColor]];
    if(section==0){
        if([serachDataLoop count]==0){
            return v;
        }
    }
    if(section==1){
        if([serachDataUser count]==0){
            return v;
        }
    }
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5, 0*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, 48*DEF_Adaptation_Font*0.5)];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    if(section==0){
        labelTitle.text = @"loop";
    }else{
        labelTitle.text = @"用户";
    }
    
    [v addSubview:labelTitle];
    
    return v;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        NSDictionary *data = [serachDataLoop objectAtIndex:indexPath.row];
        [_obj movelooperPos:data];
    }else if(indexPath.section==1){
        
        NSDictionary *data = [serachDataUser objectAtIndex:indexPath.row];
        
        if([[data objectForKey:@"userid"] isEqualToString:[LocalDataMangaer sharedManager].uid]!=true){
            
            [_obj createUserView:data];
            
        }else{
            [[DataHander sharedDataHander] showViewWithStr:@"不能和自己聊天" andTime:2 andPos:CGPointZero];
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  110*DEF_Adaptation_Font*0.5;
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section ==0){
        return [serachDataLoop count];
    }else if(section==1){
        return [serachDataUser count];
        
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
    
    
    if(indexPath.section==0){
        
        UIView *tempBg = [LooperToolClass createViewAndRect:CGPointMake(66*DEF_Adaptation_Font_x*0.5,10*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(88*DEF_Adaptation_Font_x*0.5, 88*DEF_Adaptation_Font*0.5) andIsRadius:true andImageName:[[serachDataLoop objectAtIndex:indexPath.row] objectForKey:@"news_img"]];
        
        [cell.contentView addSubview:tempBg];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 35*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(334*DEF_Adaptation_Font_x*0.5, 38*DEF_Adaptation_Font_x*0.5) andText:[[serachDataLoop objectAtIndex:indexPath.row] objectForKey:@"news_title"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [cell.contentView addSubview:titleNum];
        
    }else if(indexPath.section==1){
        UIView *tempBg = [LooperToolClass createViewAndRect:CGPointMake(66*DEF_Adaptation_Font_x*0.5,10*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(88*DEF_Adaptation_Font_x*0.5, 88*DEF_Adaptation_Font*0.5) andIsRadius:true andImageName:[[serachDataUser objectAtIndex:indexPath.row] objectForKey:@"headimageurl"]];
        
        [cell.contentView addSubview:tempBg];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(154*DEF_Adaptation_Font_x*0.5, 35*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(334*DEF_Adaptation_Font_x*0.5, 38*DEF_Adaptation_Font_x*0.5) andText:[[serachDataUser objectAtIndex:indexPath.row] objectForKey:@"nickname"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [cell.contentView addSubview:titleNum];
        
    }
    
    
    return cell;
}




-(void)initView{
    
    serachDataLoop = [[NSMutableArray alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
    
    [self createSerachViewHud];
    [self createTableView];
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        
        [_obj popController];
    }else if(button.tag==101){
        [_obj serachStr:mySeatchBar.text];
        [self endEditing:true];
        
    }
}

-(void)createTableView{
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 133*0.5*DEF_Adaptation_Font,640*DEF_Adaptation_Font_x*0.5, 998*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
}


-(void)reloadTableData:(NSMutableArray*)DataLoop andUserArray:(NSMutableArray*)DataUser{
    
    serachDataLoop = DataLoop;
    serachDataUser = DataUser;
    
    [tableView reloadData];
    
}


-(void)createSerachViewHud{
    

    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    
    
    UIButton *serachBtn = [LooperToolClass createBtnImageName:@"btn_serach_select.png" andRect:CGPointMake(553, 36) andTag:101 andSelectImage:@"btn_serach_select.png" andClickImage:@"btn_serach_select.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:serachBtn];
    
    mySeatchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(76 * DEF_Adaptation_Font*0.5, 65 * DEF_Adaptation_Font*0.5, 477*0.5*DEF_Adaptation_Font, 50 * DEF_Adaptation_Font*0.5)];
    
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
    
    UIImageView *line = [LooperToolClass createImageView:@"bg_serach_line.png" andRect:CGPointMake(76, 120) andTag:100 andSize:CGSizeMake(519, 1) andIsRadius:false];
    [self addSubview:line];
    
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




@end
