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
#import "MemberDeleteView.h"
#import "DataHander.h"
#import "UIImageView+WebCache.h"
@interface ChangeJobView()<UIScrollViewDelegate>
{
    UIView *bkV;
    UITableView *tableView;

    
    UIScrollView *selectScrollV;
//弹窗
    UIView *selectView;
}
@property(nonatomic,strong)NSDictionary *dataDic;


@property(nonatomic,strong)NSMutableArray *labelArr;
@property(nonatomic,strong)NSMutableArray *btnArr;

@property(nonatomic,strong)UIButton *inviteBtn;

//用于存储选中的职位
@property(nonatomic)NSInteger selectLb;
@property(nonatomic,strong)NSString *selectStr;



//用于选择水手长和水手使用
@property(nonatomic,strong)NSMutableArray *label2Arr;


//二副>>水手长
@property(nonatomic,strong)UIView *jobView;
@property(nonatomic,strong)UILabel *jobLB;


@property(nonatomic,strong)NSDictionary  *memberDic;
@end

@implementation ChangeJobView
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDataDic:(NSDictionary*)dataDic andMemberInfo:(NSDictionary *)memberDic{
    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        self.dataDic=dataDic;
        self.memberDic=memberDic;
        [self createView];
        
    }
    return self;
}
-(void)createView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self createHudView];
}
-(NSMutableArray *)labelArr{
    if (!_labelArr) {
        _labelArr=[[NSMutableArray alloc]init];
    }
    return _labelArr;
}
-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr=[[NSMutableArray alloc]init];
    }
    return _btnArr;
}
-(NSMutableArray *)label2Arr{
    if (!_label2Arr) {
        _label2Arr=[[NSMutableArray alloc]init];
    }
    return _label2Arr;
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==5001){
        [self removeFromSuperview];
    }
    if (button.tag>=1&&button.tag<=5) {
        if (button.selected==YES) {
            button.selected=NO;
            _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
            [_inviteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [self.jobView removeFromSuperview];
            [self.jobLB setHidden:NO];
        }else{
            button.selected=YES;
            self.selectLb=7-button.tag;
            UILabel *label=self.labelArr[button.tag-1];
            self.selectStr=label.text;
            _inviteBtn.backgroundColor=[UIColor whiteColor];
            [_inviteBtn setTitleColor:ColorRGB(255, 121, 155, 1.0) forState:(UIControlStateNormal)];
        for (UIButton *btn in self.btnArr) {
            if (btn.tag!=button.tag) {
                btn.selected=NO;
            }
        }
             [self initChangeJobView];
            [self.jobLB setHidden:YES];
                 }
    }
    
    if (button.tag==6) {
        if (button.selected==YES) {
            button.selected=NO;
            _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
            [_inviteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }else{
          [self initSelectViewWithType:1];
        }
    }
    if (button.tag==7) {
        if (button.selected==YES) {
            button.selected=NO;
            _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
            [_inviteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }else{
            [self initSelectViewWithType:2];
        }
    }
    
    if (button.tag>=100&&button.tag<=150) {
            self.selectLb=1;
            UILabel *label=self.label2Arr[button.tag-100];
            self.selectStr=label.text;
        UILabel *label1=self.labelArr[5];
        label1.text=label.text;
        for (UIButton *btn in self.btnArr) {
            if (btn.tag!=6) {
            btn.selected=NO;
            }else{
                btn.selected=YES;
            }
        }
            _inviteBtn.backgroundColor=[UIColor whiteColor];
            [_inviteBtn setTitleColor:ColorRGB(255, 121, 155, 1.0) forState:(UIControlStateNormal)];
            [selectView removeFromSuperview];
        [self initChangeJobView];
        [self.jobLB setHidden:YES];

    }
    if (button.tag>=200&&button.tag<=250) {
        self.selectLb=0;
        UILabel *label=self.label2Arr[button.tag-200];
        self.selectStr=label.text;
        UILabel *label1=self.labelArr[6];
        label1.text=label.text;
        for (UIButton *btn in self.btnArr) {
            if (btn.tag!=7) {
                btn.selected=NO;
            }else{
                btn.selected=YES;
            }
        }
        _inviteBtn.backgroundColor=[UIColor whiteColor];
        [_inviteBtn setTitleColor:ColorRGB(255, 121, 155, 1.0) forState:(UIControlStateNormal)];
        [selectView removeFromSuperview];
        [self initChangeJobView];
        [self.jobLB setHidden:YES];
    }
    if (button.tag==5002) {
        NSLog(@"%ld",self.selectLb);
        if ([self judgePushBtn]) {
        NSMutableDictionary *dataDic=[[NSMutableDictionary alloc]initWithDictionary:self.dataDic];
        [dataDic setObject:self.selectStr forKey:@"contentStr"];
        MemberDeleteView   *changeMemberV=[[MemberDeleteView alloc]initWithContentStr:[NSString stringWithFormat:@"确定%@成为“%@”",[self.dataDic objectForKey:@"nickname"],self.selectStr] andBtnName:@"确定" andType:3 andDataDic:dataDic];
        [[[self obj] familyView] addSubview:changeMemberV];
        [changeMemberV addButtonAction:^(id sender) {
            if ([[self.dataDic objectForKey:@"role"]integerValue]==1) {
        //当他是水手长的时候
                if (self.selectLb==1) {
                [[DataHander sharedDataHander] showViewWithStr:@"特殊职位不能随意更改" andTime:1 andPos:CGPointZero];
                }else{
                [self.obj delayChangeJobWithOriginUser:dataDic andView:self andWillChangeRole:[NSString stringWithFormat:@"%ld",self.selectLb]];
                }
            }
            else if(self.selectLb==1){
#warning -在这里添加更改职位改为水手长的情况，需要选择组的界面
            }
            else{
            [self.obj ChangeJobToSailorWithUserId:[self.dataDic objectForKey:@"userid"] andRole:[NSString stringWithFormat:@"%ld",self.selectLb] andOriginalRole:nil];
                [self removeFromSuperview];
        }
            
        }];
          }
    }
}
-(BOOL)judgePushBtn{
    for (UIButton *btn in self.btnArr) {
        if (btn.selected==YES) {
            return YES;
        }
    }
    return NO;

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
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10*DEF_Adaptation_Font*0.5) andTag:5001 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    
    UIImageView *headIV=[[UIImageView alloc]initWithFrame:CGRectMake(218*DEF_Adaptation_Font*0.5, 86*DEF_Adaptation_Font*0.5, 146*DEF_Adaptation_Font*0.5, 146*DEF_Adaptation_Font*0.5)];
    [headIV sd_setImageWithURL:[_dataDic objectForKey:@"headimageurl"]];
    headIV.contentMode=UIViewContentModeScaleAspectFill;
    headIV.clipsToBounds=YES;
    headIV.layer.cornerRadius=72*DEF_Adaptation_Font*0.5;
    headIV.layer.masksToBounds=YES;
    [bkV addSubview:headIV];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(55*DEF_Adaptation_Font*0.5, 251*DEF_Adaptation_Font*0.5, 472*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    nameLB.text=[_dataDic objectForKey:@"nickname"];
    nameLB.font=[UIFont boldSystemFontOfSize:16];
    nameLB.textColor=[UIColor whiteColor];
    nameLB.textAlignment=NSTextAlignmentCenter;
    [bkV addSubview:nameLB];
    self.jobLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 298*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    _jobLB.textColor=[UIColor whiteColor];
    _jobLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    _jobLB.text=[self jobnameForStatus:[[_dataDic objectForKey:@"role"]intValue]];
    [bkV addSubview:_jobLB];
    _jobLB.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
    _jobLB.layer.masksToBounds=YES;
    _jobLB.backgroundColor=[self jobColorForStatus:[[_dataDic objectForKey:@"role"]intValue]];
    _jobLB.textAlignment=NSTextAlignmentCenter;
    CGSize lblSize3 = [_jobLB.text boundingRectWithSize:CGSizeMake(190*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:12.f]} context:nil].size;
    CGRect frame3=_jobLB.frame;
    lblSize3.width+=32*DEF_Adaptation_Font*0.5;
    frame3.origin.x=DEF_WIDTH(bkV)/2-lblSize3.width/2;
    frame3.size=lblSize3;
    _jobLB.frame=frame3;
    
    
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
    selectScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 456*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), (73*6-20)*DEF_Adaptation_Font*0.5)];
    selectScrollV.contentSize=CGSizeMake(DEF_WIDTH(bkV),  (73*7-20)*DEF_Adaptation_Font*0.5);
    selectScrollV.showsVerticalScrollIndicator = NO;
    [bkV addSubview:selectScrollV];
    
    
    for (int i=0; i<5; i++) {
//后续需要有一些改动,加入无人选就变灰效果
        NSArray *memberArr=[self.memberDic objectForKey:[NSString stringWithFormat:@"%d",6-i]];
    UILabel * label =[self creatLabelWithContent:[self jobnameForStatus:6-i andNumber:memberArr.count] andRect:CGRectMake(55*DEF_Adaptation_Font*0.5, (i*73)*DEF_Adaptation_Font*0.5,471*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5) andType:1 andTag:i+1];
        if (memberArr.count==1&&i!=1) {
            label.userInteractionEnabled=NO;
            label.alpha=0.3;
        }
        if (memberArr.count==2&&i==1) {
            label.userInteractionEnabled=NO;
            label.alpha=0.3;
        }
    [selectScrollV addSubview:label];
        self.labelArr[i]=label;
    }
    for (int i=5; i<7; i++) {
//后续需要有一些改动
    NSArray *memberArr=[self.memberDic objectForKey:[NSString stringWithFormat:@"%d",6-i]];
    UILabel *lb= [self creatLabelWithContent:[self jobnameForStatus:6-i andNumber:memberArr.count] andRect:CGRectMake(55*DEF_Adaptation_Font*0.5, ((i)*73)*DEF_Adaptation_Font*0.5,471*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5) andType:2 andTag:i+1];
        if (memberArr.count==50&&i==5) {
            lb.userInteractionEnabled=NO;
            lb.alpha=0.3;
        }
        [selectScrollV addSubview:lb];
        self.labelArr[i]=lb;
    }
    self.inviteBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(57*DEF_Adaptation_Font*0.5, DEF_HEIGHT(bkV)-80*DEF_Adaptation_Font*0.5) andTag:5002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(471*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5) andTarget:self];
        [_inviteBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    _inviteBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [_inviteBtn setTintColor:[UIColor whiteColor]];
    _inviteBtn.layer.cornerRadius=10*DEF_Adaptation_Font*0.5;
    _inviteBtn.layer.masksToBounds=YES;
    _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
    [bkV addSubview:_inviteBtn];

    
}
-(UILabel *)creatLabelWithContent:(NSString *)content andRect:(CGRect)frame andType:(NSInteger)type andTag:(NSInteger)tag{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    label.text=content;
    label.textColor=ColorRGB(225, 226, 227, 1.0);
    label.textAlignment=NSTextAlignmentLeft;
    label.layer.borderWidth=1.0;
    label.layer.borderColor=[ColorRGB(225, 226, 227, 0.5)CGColor];
    label.layer.cornerRadius=10*DEF_Adaptation_Font*0.5;
    label.layer.masksToBounds=YES;
    label.tag=tag;
    label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickLabel:)];
    [label addGestureRecognizer:tap];
    if (type==1) {
    UIButton *button=[LooperToolClass createBtnImageNameReal:@"CreateFleet_disagree" andRect:CGPointMake(DEF_WIDTH(label)-50*DEF_Adaptation_Font*0.5, 9*DEF_Adaptation_Font*0.5) andTag:(int)tag andSelectImage:@"CreateFleet_agree" andClickImage:@"CreateFleet_agree" andTextStr:nil andSize:CGSizeMake(34*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5) andTarget:self];
        [self.btnArr addObject:button];
            [label addSubview:button];
    }else{
        UIButton *button=[LooperToolClass createBtnImageNameReal:@"btn_family_selectJob" andRect:CGPointMake(DEF_WIDTH(label)-50*DEF_Adaptation_Font*0.5, 9*DEF_Adaptation_Font*0.5) andTag:(int)tag andSelectImage:@"CreateFleet_agree" andClickImage:@"CreateFleet_agree" andTextStr:nil andSize:CGSizeMake(34*DEF_Adaptation_Font*0.5, 34*DEF_Adaptation_Font*0.5) andTarget:self];
        [self.btnArr addObject:button];
        [label addSubview:button];
    }
    return label;
}
-(void)onClickLabel:(UITapGestureRecognizer *)tap{
    NSInteger tag=tap.view.tag;
    if (tag<6) {
    for (UIButton *btn in self.btnArr) {
        if (btn.tag!=tag) {
            btn.selected=NO;
            }else{
            if (btn.selected==YES) {
                btn.selected=NO;
                _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
                [_inviteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                [self.jobView removeFromSuperview];
                [self.jobLB setHidden:NO];
            }else{
                btn.selected=YES;
                self.selectLb=7-btn.tag;
                UILabel *label=self.labelArr[btn.tag-1];
                self.selectStr=label.text;
                _inviteBtn.backgroundColor=[UIColor whiteColor];
                [_inviteBtn setTitleColor:ColorRGB(255, 121, 155, 1.0) forState:(UIControlStateNormal)];
                [self initChangeJobView];
                [self.jobLB setHidden:YES];
            }
        }
    }
    }
    if (tag==6) {
        UIButton *btn=self.btnArr[5];
        if (btn.selected==YES) {
            btn.selected=NO;
            _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
            [_inviteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [self.jobView removeFromSuperview];
            [self.jobLB setHidden:NO];
        }else{
        [self initSelectViewWithType:1];
        }
    }
    if (tag==7) {
        UIButton *btn=self.btnArr[6];
        if (btn.selected==YES) {
            btn.selected=NO;
            _inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
            [_inviteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [self.jobView removeFromSuperview];
            [self.jobLB setHidden:NO];
        }else{
            [self initSelectViewWithType:2];
        }
    }
    
    
    if (tag>=100&&tag<=150) {
        self.selectLb=1;
        UILabel *label=self.label2Arr[tag-100];
        self.selectStr=label.text;
        UILabel *label1=self.labelArr[5];
        label1.text=label.text;
        for (UIButton *btn in self.btnArr) {
            if (btn.tag!=6) {
                btn.selected=NO;
            }else{
                btn.selected=YES;
            }

        }
        _inviteBtn.backgroundColor=[UIColor whiteColor];
        [_inviteBtn setTitleColor:ColorRGB(255, 121, 155, 1.0) forState:(UIControlStateNormal)];
        [selectView removeFromSuperview];
        [self initChangeJobView];
        [self.jobLB setHidden:YES];
    }
    if (tag>=200&&tag<=250) {
        self.selectLb=0;
        UILabel *label=self.label2Arr[tag-200];
        self.selectStr=label.text;
        UILabel *label1=self.labelArr[6];
        label1.text=label.text;
        for (UIButton *btn in self.btnArr) {
            if (btn.tag!=7) {
                btn.selected=NO;
            }else{
                btn.selected=YES;
            }

        }
        _inviteBtn.backgroundColor=[UIColor whiteColor];
        [_inviteBtn setTitleColor:ColorRGB(255, 121, 155, 1.0) forState:(UIControlStateNormal)];
        [selectView removeFromSuperview];
        [self initChangeJobView];
        [self.jobLB setHidden:YES];
    }

}

-(void)initSelectViewWithType:(NSInteger)type{
    selectView=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(self)-406*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 406*DEF_Adaptation_Font*0.5)];
    selectView.backgroundColor=ColorRGB(68, 58, 89, 1.0);
    [self addSubview:selectView];
    UILabel *contentLb=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, DEF_WIDTH(selectView)-200*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
    contentLb.text=@"选择职位";
    contentLb.textAlignment=NSTextAlignmentCenter;
    contentLb.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    contentLb.textColor=[UIColor whiteColor];
    [selectView addSubview:contentLb];
    UIScrollView *scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60*DEF_Adaptation_Font*0.5, DEF_WIDTH(selectView), 346*DEF_Adaptation_Font*0.5)];
    scrollV.contentSize=CGSizeMake(DEF_WIDTH(selectView),  (76*50-20)*DEF_Adaptation_Font*0.5);
    scrollV.showsVerticalScrollIndicator = NO;
    [selectView addSubview:scrollV];
    for (int i=0; i<50; i++) {
        //后续需要有一些改动,加入无人选就变灰效果
        if (type==1) {
    UILabel *label= [self creatLabelWithContent:[NSString stringWithFormat:@"  %d队水手长",i+1] andRect:CGRectMake(43*DEF_Adaptation_Font*0.5, (i*76)*DEF_Adaptation_Font*0.5,556*DEF_Adaptation_Font*0.5, 56*DEF_Adaptation_Font*0.5) andType:1 andTag:i+100];
        [scrollV addSubview:label];
            self.label2Arr[i]=label;
        }else{
            UILabel *label= [self creatLabelWithContent:[NSString stringWithFormat:@"  %d队水手",i+1] andRect:CGRectMake(43*DEF_Adaptation_Font*0.5, (i*76)*DEF_Adaptation_Font*0.5,556*DEF_Adaptation_Font*0.5, 56*DEF_Adaptation_Font*0.5) andType:1 andTag:i+200];
            [scrollV addSubview:label];
            self.label2Arr[i]=label;
        }
    }

    
}
-(void)initChangeJobView{
    [_jobView removeFromSuperview];
    _jobView=[[UIView alloc]initWithFrame:CGRectMake(0,  298*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 28*DEF_Adaptation_Font*0.5)];
    [bkV addSubview:_jobView];
      UILabel *jobLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 0, 190*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    jobLB.textColor=[UIColor whiteColor];
    jobLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    jobLB.text=[self jobnameForStatus:[[_dataDic objectForKey:@"role"]intValue]];
    [_jobView addSubview:jobLB];
    jobLB.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
    jobLB.layer.masksToBounds=YES;
    jobLB.backgroundColor=[self jobColorForStatus:[[_dataDic objectForKey:@"role"]intValue]];
    jobLB.textAlignment=NSTextAlignmentCenter;
    CGSize lblSize3 = [jobLB.text boundingRectWithSize:CGSizeMake(190*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:12.f]} context:nil].size;
    CGRect frame3=jobLB.frame;
    lblSize3.width+=32*DEF_Adaptation_Font*0.5;
    frame3.origin.x=DEF_WIDTH(bkV)/2-lblSize3.width-35*DEF_Adaptation_Font*0.5;
    frame3.size=lblSize3;
    jobLB.frame=frame3;
    
    UIImageView *changeIV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(jobLB)+DEF_X(jobLB)+20*DEF_Adaptation_Font*0.5, 5*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5, 19*DEF_Adaptation_Font*0.5)];
    changeIV.image=[UIImage imageNamed:@"family_changeJob_IV"];
    [_jobView addSubview:changeIV];
    
    UILabel *job2LB=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(changeIV)+DEF_X(changeIV)+20*DEF_Adaptation_Font*0.5, 0, 190*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5)];
    job2LB.textColor=[UIColor whiteColor];
    job2LB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
    job2LB.text=[self.selectStr substringFromIndex:2];
    if (self.selectLb==5) {
         job2LB.text=@"副舰长";
    }
    [_jobView addSubview:job2LB];
    job2LB.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
    job2LB.layer.masksToBounds=YES;
    job2LB.backgroundColor=[self jobColorForStatus:self.selectLb];
    job2LB.textAlignment=NSTextAlignmentCenter;
    CGSize lblSize2 = [job2LB.text boundingRectWithSize:CGSizeMake(190*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:12.f]} context:nil].size;
    CGRect frame2=job2LB.frame;
    lblSize2.width+=32*DEF_Adaptation_Font*0.5;
    frame2.size=lblSize2;
    job2LB.frame=frame2;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [selectView removeFromSuperview];
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
-(NSString *)jobnameForStatus:(NSInteger)status andNumber:(NSInteger)number{
    switch (status) {
        case 6:
            return @"  舰长";
            break;
        case 5:
            return [NSString stringWithFormat:@"  副舰长(%ld/2)",number];
            break;
        case 4:
            return @"  大副";
            break;
        case 3:
            return @"  二副";
            break;
        case 2:
            return @"  三副";
            break;
        case 1:
            return [NSString stringWithFormat:@"  水手长(%ld/50)",number];
            break;
        case 0:
            return [NSString stringWithFormat:@"  水手"];
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
