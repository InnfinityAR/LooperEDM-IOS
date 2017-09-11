//
//  FramilyAddInviteView.m
//  Looper
//
//  Created by lujiawei on 04/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "FramilyAddInviteView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "LooperToolClass.h"

#define closeBtnTag 1000
#define inviteBtnTag 1001

@implementation FramilyAddInviteView{


    UISearchBar *_searchBar;
    UIView *bkV;
    UITableView *tableView;
    
    NSMutableArray *_dataSource;
    NSInteger isSortJob;//sortBtn
    NSInteger isSortLevel;//sortBtn
    NSInteger isSortActive;//sortBtn
    NSInteger isSortSex;//sortBtn


}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject{

    
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        
        [self createView];
        
    }
    return self;
}

-(void)setDataSource:(NSArray*)arrayData{

    _dataSource = [[NSMutableArray alloc] initWithArray:arrayData];
    [self createTableView];
}



-(void)createView{

    isSortJob=0;
    isSortLevel=0;
    isSortActive=0;
    isSortSex=0;
    
    

    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self createHudView];
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
   
    if(button.tag==closeBtnTag){
        [self removeFromSuperview];
    }else{
    
        
    }
}

-(void)createSerachView{
    

}


-(void)onClickBtn:(UITapGestureRecognizer*)tap{


    if (tap.view.tag==101) {
        if (isSortLevel==1) {
            isSortLevel=0;
            [self sortFromLargelToSmall:@"level"];
            [tableView reloadData];
        }else{
            isSortLevel=1;
            [self sortFromSmallToLarge:@"level"];
            [tableView reloadData];
        }
    }
    
    
    
    if (tap.view.tag==100) {
        if (isSortActive==1) {
            isSortActive=0;
            [self sortFromLargelToSmall:@"nickname"];
             [tableView reloadData];
        }else{
            isSortActive=1;
            [self sortFromSmallToLarge:@"nickname"];
             [tableView reloadData];
        }
    }



if (tap.view.tag==102) {
        if (isSortSex==0) {
            isSortSex=1;
            [self sortFromLargelToSmall:@"sex"];
             [tableView reloadData];
        }else{
            isSortSex=0;
            [self sortFromSmallToLarge:@"sex"];
             [tableView reloadData];
        }
    }

    
}


-(void)sortReverseArr{
    if (_dataSource.count>1) {
        for (int i=1; i<_dataSource.count/2; i++) {
            NSDictionary *dic=_dataSource[i];
            _dataSource[i]=_dataSource[_dataSource.count-i];
            _dataSource[_dataSource.count-i]=dic;
        }
    }
    
}
-(void)sortFromSmallToLarge:(NSString *)type{
    if (_dataSource.count>1) {
        for (int i=1; i<_dataSource.count; i++) {
            for (int j=1; j<i; j++) {
                if ([[_dataSource[i]objectForKey:type]integerValue]<[[_dataSource[j]objectForKey:type]integerValue]) {
                    NSDictionary *dic=_dataSource[i];
                    _dataSource[i]=_dataSource[j];
                    _dataSource[j]=dic;
                }
            }
        }
    }
}
-(void)sortFromLargelToSmall:(NSString *)type{
    if (_dataSource.count>1) {
        for (int i=1; i<_dataSource.count; i++) {
            for (int j=1; j<i; j++) {
                if ([[_dataSource[i]objectForKey:type]integerValue]>[[_dataSource[j]objectForKey:type]integerValue]) {
                    NSDictionary *dic=_dataSource[i];
                    _dataSource[i]=_dataSource[j];
                    _dataSource[j]=dic;
                }
            }
        }
    }
}


-(void)createBtnLabel:(CGRect)rect and:(int)tag andStr:(NSString*)string{

    UILabel *btnName=[[UILabel alloc]initWithFrame:rect];
    btnName.text=string;
    btnName.userInteractionEnabled=YES;
    btnName.tag=tag;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBtn:)];
    [btnName addGestureRecognizer:singleTap];
    [self addSubview:btnName];
    btnName.textColor=[UIColor whiteColor];
    btnName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    btnName.textAlignment=NSTextAlignmentCenter;
    [bkV addSubview:btnName];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row%2==1) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0];
    }else{
        cell.contentView.backgroundColor=ColorRGB(84, 71, 104, 1.0);
        
    }
    NSDictionary *dataDic=_dataSource[indexPath.row];

    UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"headimageurl"]]];
    headImage.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    headImage.layer.masksToBounds=YES;
    [cell.contentView addSubview:headImage];
    
    UILabel *nickName=[[UILabel alloc]initWithFrame:CGRectMake(126*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
    nickName.textColor=[UIColor whiteColor];
    nickName.font=[UIFont systemFontOfSize:14];
    nickName.text=[dataDic objectForKey:@"nickname"];
    [cell.contentView addSubview:nickName];
    
    UILabel *level=[[UILabel alloc]initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5,0*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
    level.textColor=[UIColor whiteColor];
    level.font=[UIFont systemFontOfSize:14];
    if ([dataDic objectForKey:@"level"]==[NSNull null]) {
        level.text=@"I";
    }else{
        level.text=[dataDic objectForKey:@"level"];
    }
    level.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:level];
    
    if([dataDic objectForKey:@"sex"]==[NSNull null]){
        UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(425*DEF_Adaptation_Font*0.5, 33*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"family_man.png"];
        [cell.contentView addSubview:sexIV];
    }else if ([[dataDic objectForKey:@"sex"]intValue]==1) {
        UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(425*DEF_Adaptation_Font*0.5, 33*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"family_man.png"];
        [cell.contentView addSubview:sexIV];
    }else if([[dataDic objectForKey:@"sex"]intValue]==0){
        UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(425*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, 41*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"familyMember_person.png"];
         [cell.contentView addSubview:sexIV];
    }else if([[dataDic objectForKey:@"sex"]intValue]==2){
        UIImageView *sexIV=[[UIImageView alloc]initWithFrame:CGRectMake(425*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
        sexIV.image=[UIImage imageNamed:@"family_Woman.png"];
         [cell.contentView addSubview:sexIV];
    }
    
    
    UIButton *inviteBtn = [LooperToolClass createBtnImageName:@"btn_Family_invite.png" andRect:CGPointMake(475, 31) andTag:inviteBtnTag andSelectImage:@"btn_family_invited.png" andClickImage:@"btn_Family_invite.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [cell.contentView addSubview:inviteBtn];

    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  93*DEF_Adaptation_Font*0.5;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_dataSource count];
}



-(void)createTableView{
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5, 187*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 745*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView setBackgroundColor:[UIColor clearColor]];
    [bkV addSubview:tableView];

}
-(void)createHudView{
    
    bkV =[[UIView alloc] initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 978*DEF_Adaptation_Font*0.5)];
    [bkV setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
    [self addSubview:bkV];
    bkV.layer.cornerRadius=12.0*DEF_Adaptation_Font*0.5;
    bkV.layer.masksToBounds=YES;
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 585*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    [bkV addSubview:headerView];
    
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, bkV.frame.size.width-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"邀请好友";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(541, 114) andTag:closeBtnTag andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:closeBtn];

    [self createSerachView];
    
    [self createBtnLabel:CGRectMake(103*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:100 andStr:@"名称"];
    [self createBtnLabel:CGRectMake(303*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:101 andStr:@"等级"];
    [self createBtnLabel:CGRectMake(395*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:102 andStr:@"性别"];
    
    
    
}











@end
