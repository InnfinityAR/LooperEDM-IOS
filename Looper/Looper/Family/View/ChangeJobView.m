//
//  ChangeJobView.m
//  Looper
//
//  Created by 工作 on 2017/9/12.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ChangeJobView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
@interface ChangeJobView(){
    UIView *bkV;
    UITableView *tableView;
}
@property(nonatomic,strong)NSDictionary *dataDic;

@end
@implementation ChangeJobView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataDic:(NSDictionary*)dataDic{
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        self.dataDic=dataDic;
        [self createView];
        
    }
    return self;
}
-(void)createView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self createHudView];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==100){
        [self removeFromSuperview];
    }else{
        
        
    }
}

-(void)createHudView{
    
    bkV =[[UIView alloc] initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 978*DEF_Adaptation_Font*0.5)];
    [bkV setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
    [self addSubview:bkV];
    bkV.layer.cornerRadius=12.0*DEF_Adaptation_Font*0.5;
    bkV.layer.masksToBounds=YES;
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 585*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    headerView.userInteractionEnabled=YES;
    [bkV addSubview:headerView];
    
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, bkV.frame.size.width-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"变更职务";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(218*DEF_Adaptation_Font*0.5, 86*DEF_Adaptation_Font*0.5, 146*DEF_Adaptation_Font*0.5, 146*DEF_Adaptation_Font*0.5)];
    headIV.image=[UIImage imageNamed:@"640-2.png"];
    headIV.layer.cornerRadius=72*DEF_Adaptation_Font*0.5;
    headIV.layer.masksToBounds=YES;
    [bkV addSubview:headIV];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(55*DEF_Adaptation_Font*0.5, 251*DEF_Adaptation_Font*0.5, 472*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    nameLB.text=[_dataDic objectForKey:@"nickname"];
    nameLB.font=[UIFont boldSystemFontOfSize:16];
    nameLB.textColor=[UIColor whiteColor];
    nameLB.textAlignment=NSTextAlignmentCenter;
    [bkV addSubview:nameLB];
    UILabel *jobLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 298*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    jobLB.textColor=[UIColor whiteColor];
    jobLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    jobLB.text=[self jobnameForStatus:[[_dataDic objectForKey:@"role"]intValue]];
    [bkV addSubview:jobLB];
    jobLB.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
    jobLB.layer.masksToBounds=YES;
    jobLB.backgroundColor=[self jobColorForStatus:[[_dataDic objectForKey:@"role"]intValue]];
    jobLB.textAlignment=NSTextAlignmentCenter;
    CGSize lblSize3 = [jobLB.text boundingRectWithSize:CGSizeMake(190*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:12.f]} context:nil].size;
    CGRect frame3=jobLB.frame;
    lblSize3.width+=32*DEF_Adaptation_Font*0.5;
    frame3.origin.x=DEF_WIDTH(bkV)/2-lblSize3.width/2;
    frame3.size=lblSize3;
    jobLB.frame=frame3;
    
    UILabel *levelLB=[[UILabel alloc]initWithFrame:CGRectMake(76*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5, 176*DEF_Adaptation_Font*0.5, 43*DEF_Adaptation_Font*0.5)];
    levelLB.textColor=ColorRGB(255, 255, 255, 0.5);
    levelLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    if ([_dataDic objectForKey:@"level"]==[NSNull null]) {
        levelLB.text=@"等级：0";
    }else{
        levelLB.text=[NSString stringWithFormat:@"等级：%@",[_dataDic objectForKey:@"level"]];
    }
    [bkV addSubview:levelLB];
    UILabel *activeLB=[[UILabel alloc]initWithFrame:CGRectMake(331*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5, 176*DEF_Adaptation_Font*0.5, 43*DEF_Adaptation_Font*0.5)];
    activeLB.textColor=ColorRGB(255, 255, 255, 0.5);
    activeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:14.f];
    activeLB.textAlignment=NSTextAlignmentRight;
    if ([_dataDic objectForKey:@"activepoints"]==[NSNull null]) {
        activeLB.text=@"活跃度：0";
    }else{
        activeLB.text=[NSString stringWithFormat:@"活跃度：%@",[_dataDic objectForKey:@"activepoints"]];
    }
    [bkV addSubview:activeLB];

    UIImageView *jobManageIV=[[UIImageView alloc]initWithFrame:CGRectMake(56*DEF_Adaptation_Font*0.5, 405*DEF_Adaptation_Font*0.5, 472*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    jobManageIV.image=[UIImage imageNamed:@"family_job_manage.png"];
    [bkV addSubview:jobManageIV];
    
    
}


-(NSString *)jobnameForStatus:(NSInteger)status{
    switch (status) {
        case 6:
            return @"舰长";
            break;
        case 5:
            return @"副舰长";
            break;
        case 4:
            return @"大副";
            break;
        case 3:
            return @"二副";
            break;
        case 2:
            return @"三副";
            break;
        case 1:
            return @"水手长";
            break;
        case 0:
            return @"水手";
            break;
        default:
            break;
    }
    return nil;
}
-(UIColor *)jobColorForStatus:(NSInteger)status{
    switch (status) {
        case 6:
            return ColorRGB(253, 123, 153, 1.0);
            break;
        case 5:
            return ColorRGB(252, 119, 158, 1.0);
            break;
        case 4:
            return ColorRGB(231, 152, 163, 1.0);
            break;
        case 3:
            return ColorRGB(247, 156, 150, 1.0);
            break;
        case 2:
            return ColorRGB(241, 171, 152, 1.0);
            break;
        case 1:
            return ColorRGB(252, 186, 140, 1.0);
            break;
        case 0:
            return ColorRGB(255, 207, 160, 1.0);
            break;
        default:
            break;
    }
    return nil;
}

@end
