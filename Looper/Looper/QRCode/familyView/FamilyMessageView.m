//
//  FamilyMessageView.m
//  Looper
//
//  Created by 工作 on 2017/8/28.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyMessageView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "FamilyViewModel.h"
#import "UIImageView+WebCache.h"
@interface FamilyMessageView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@end
@implementation FamilyMessageView

-(instancetype)initWithFrame:(CGRect)frame andObject:(id)obj andDataArr:(NSArray *)dataArr{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        [self.obj setMessageView:self];
        self.dataArr=dataArr;
        [self setBackView];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,DEF_WIDTH(self),DEF_HEIGHT(self))];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
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
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSInteger tag=button.tag;
    
    if (tag<0) {
        NSDictionary *dataDic=self.dataArr[-tag-1];
    //拒绝
        [self.obj judgeJoinFamilyWithJoin:@"0" andRaverId:[dataDic objectForKey:@"raverid"]  andApplyId:[dataDic objectForKey:@"inviteid"]];
    }else{
        NSDictionary *dataDic=self.dataArr[tag-1];
    //同意
        [self.obj judgeJoinFamilyWithJoin:@"1" andRaverId:[dataDic objectForKey:@"raverid"]  andApplyId:[dataDic objectForKey:@"inviteid"]];
    }
}
-(void)setBackView{
    [self setBackgroundColor:[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0]];
    self.layer.cornerRadius=12.0*DEF_Adaptation_Font;
    self.layer.masksToBounds=YES;
}
-(void)reloadData:(NSArray *)dataArr{
    self.dataArr=dataArr;
    [self.tableView reloadData];
}
#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
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
    [self setTableViewCellView:cell andIndexPath:indexPath];
    return cell;
}
-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *dataDic=self.dataArr[indexPath.row];
    NSString *status=[dataDic objectForKey:@"reviewstatus"];
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(11*DEF_Adaptation_Font, 17*DEF_Adaptation_Font, 40*DEF_Adaptation_Font, 40*DEF_Adaptation_Font)];
    NSLog(@"%@",[dataDic objectForKey:@"headimageurl"]);
    [headIV sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"headimageurl"]]];
    headIV.layer.cornerRadius=20*DEF_Adaptation_Font;
    headIV.layer.masksToBounds=YES;
    [cell.contentView addSubview:headIV];
    UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font, 300*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font)];
    headLB.font=[UIFont systemFontOfSize:18];
    headLB.textColor=[UIColor whiteColor];
        headLB.text=[dataDic objectForKey:@"nickname"];
    [cell.contentView addSubview:headLB];
    UILabel *inviteLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font, 300*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font)];
    inviteLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16.f];
    inviteLB.textColor=[UIColor whiteColor];
    inviteLB.text=@"邀你入LooperEDM";
    [cell.contentView addSubview:inviteLB];
    if ([status intValue]==1) {
        UIButton *sureButton=[LooperToolClass createBtnImageNameReal:@"agreeBtn.png" andRect:CGPointMake(430*DEF_Adaptation_Font*0.5, 23*DEF_Adaptation_Font) andTag:(int)indexPath.row+1 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(28*DEF_Adaptation_Font, 28*DEF_Adaptation_Font) andTarget:self];
        [cell.contentView addSubview:sureButton];
        UIButton *refuseButton=[LooperToolClass createBtnImageNameReal:@"refuseBtn.png" andRect:CGPointMake(510*DEF_Adaptation_Font*0.5, 23*DEF_Adaptation_Font) andTag:(int)-(indexPath.row+1) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(28*DEF_Adaptation_Font, 28*DEF_Adaptation_Font) andTarget:self];
        [cell.contentView addSubview:refuseButton];
    }else{
    UILabel *personNumLB=[[UILabel alloc]initWithFrame:CGRectMake(466*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font, DEF_WIDTH(self)-466*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font)];
    personNumLB.text=@"已过期";
    personNumLB.numberOfLines=0;
    personNumLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    personNumLB.textColor=[UIColor lightGrayColor];
    personNumLB.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:personNumLB];
    }
    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:86/255.0 green:77/255.0 blue:109/255.0 alpha:1.0];
    }else{
        cell.contentView.backgroundColor=[UIColor colorWithRed:83/255.0 green:71/255.0 blue:104/255.0 alpha:1.0];
        
    }
    cell.layer.masksToBounds=YES;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  74*DEF_Adaptation_Font;
}

@end
