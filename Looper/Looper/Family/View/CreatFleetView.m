//
//  CreatFleetView.m
//  Looper
//
//  Created by 工作 on 2017/9/14.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "CreatFleetView.h"
#import "FamilyViewModel.h"
#import"LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
@interface CreatFleetView()<UITableViewDelegate ,UITableViewDataSource>
{
    UIView *bkV;
    NSInteger isSortJob;//sortBtn
    NSInteger isSortActive;//sortBtn
    NSInteger isSortSex;//sortBtn
    
    NSInteger creatType;
}
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UITableView *tableView;
//用来判断是否选中cell，未选中就是-1
@property(nonatomic)NSInteger isSelectCell;


@property(nonatomic,strong)NSMutableArray *BtnArr;

//用来填写当前选择的cell的row，如果未选中就是-1，使用于cell中的button
@property(nonatomic)NSInteger currentRow;


@end
@implementation CreatFleetView
-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataArr:(NSArray *)dataArr andType:(NSInteger)type{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataArr=(NSMutableArray *)dataArr;
        creatType=type;
//传入的值1为替换职位的view 2为创建舰队的view
        [self initView];
        self.isSelectCell=-1;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self setBackView];
    }
    return self;
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    isSortJob=0;
    isSortActive=0;
    isSortSex=0;
    self.currentRow=-1;
    [self createHudView];
}
-(void)setBackView{
    UIImageView *shadowV=[[UIImageView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(bkV)-130*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 30*DEF_Adaptation_Font*0.5)];
    shadowV.image=[UIImage imageNamed:@"CreateFleet_shadow.png"];
    [bkV addSubview:shadowV];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==5000){
        [self removeFromSuperview];
    }
    if(button.tag==5001){
        if (isSortJob==0) {
            isSortJob=1;
            [self sortReverseArr];
            self.currentRow=-1;
            _isSelectCell=-1;
            [self.tableView reloadData];
        }else{
            isSortJob=0;
            self.currentRow=-1;
            _isSelectCell=-1;
            [self sortReverseArr];
            [self.tableView reloadData];
        }
    }
    if (button.tag==5002) {
//在这里添加修改职位的方法
        if (self.currentRow!=-1) {
            if (creatType==1) {
            NSDictionary *currentDic=self.dataSource[self.currentRow];
            [self.obj ChangeJobToSailorWithUserId:[currentDic objectForKey:@"userid"] andRole:self.shouldChangeRole andOriginalRole:nil];
            [self removeFromSuperview];
            }else{
            [self removeFromSuperview];
        NSDictionary *currentDic=self.dataSource[self.currentRow];
#warning -在这里添加成为队长的接口
                     }
        }
    }
    if (button.tag>=0&&button.tag<1000) {
        if (button.selected==YES) {
            button.selected=NO;
            self.currentRow=-1;
            _isSelectCell=-1;
            [self.tableView reloadData];
        }else{
            button.selected=YES;
            self.currentRow=button.tag;
            _isSelectCell=button.tag;
            [self.tableView reloadData];
            for (UIButton *btn in self.BtnArr) {
                if (btn.tag!=button.tag&&btn.selected==YES) {
                    btn.selected=NO;
                }
            }
        }
    }
  
}
-(NSMutableArray *)BtnArr{
    if (!_BtnArr) {
        _BtnArr=[[NSMutableArray alloc]init];
    }
    return _BtnArr;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        if (creatType==1) {
//变更职位
            _dataSource=[[NSMutableArray alloc]init];
        for (NSDictionary *dataDic in self.dataArr) {
            if ([[dataDic objectForKey:@"role"]integerValue]!=1&&[[dataDic objectForKey:@"role"]integerValue]!=6&&[[dataDic objectForKey:@"role"]integerValue]!=5) {
                [_dataSource addObject:dataDic];
            }
        }
        }else{
//新建舰队
        _dataSource=[[NSMutableArray alloc]initWithArray:self.dataArr];
        }
    }
    return _dataSource;
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
    if (creatType==1) {
    headerLB.text=@"替换职位";
    }else{
    headerLB.text=@"新建舰队";
    }
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10*DEF_Adaptation_Font*0.5) andTag:5000 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    UILabel *presentMemberLB=[[UILabel alloc]initWithFrame:CGRectMake(0, 68*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 60*DEF_Adaptation_Font*0.5)];
    presentMemberLB.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    presentMemberLB.textAlignment=NSTextAlignmentCenter;
    presentMemberLB.textColor=ColorRGB(255, 255, 255, 0.7);
    presentMemberLB.text=@"选择成员";
    presentMemberLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    [bkV addSubview:presentMemberLB];
    
    [self createBtnLabel:CGRectMake(103*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:101 andStr:@"名称"];
    UIButton *sortBtn=[LooperToolClass createBtnImageNameReal:@"familyMember_sort.png" andRect:CGPointMake(210*DEF_Adaptation_Font*0.5, 155*DEF_Adaptation_Font*0.5) andTag:5001 andSelectImage:@"familyMember_sort.png" andClickImage:@"familyMember_sort.png" andTextStr:nil andSize:CGSizeMake(15*DEF_Adaptation_Font*0.5, 15*DEF_Adaptation_Font*0.5) andTarget:self];
    [bkV addSubview:sortBtn];
    [self createBtnLabel:CGRectMake(303*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:100 andStr:@"活跃值"];
    [self createBtnLabel:CGRectMake(395*DEF_Adaptation_Font*0.5,146*DEF_Adaptation_Font*0.5,93*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) and:102 andStr:@"性别"];
    
    UIView *bottomV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(bkV)-100*DEF_Adaptation_Font*0.5, DEF_WIDTH(bkV), 100*DEF_Adaptation_Font*0.5)];
    bottomV.backgroundColor=ColorRGB(84, 71, 104, 1.0);
    [bkV addSubview:bottomV];
    UIButton *inviteBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(57*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andTag:5002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(471*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5) andTarget:self];
    if (creatType==1) {
    [inviteBtn setTitle:@"更改职位" forState:(UIControlStateNormal)];
    }else{
     [inviteBtn setTitle:@"成为队长" forState:(UIControlStateNormal)];
    }
    inviteBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [inviteBtn setTintColor:[UIColor whiteColor]];
    inviteBtn.layer.cornerRadius=10*DEF_Adaptation_Font*0.5;
    inviteBtn.layer.masksToBounds=YES;
    inviteBtn.backgroundColor=ColorRGB(136, 131, 149, 1.0);
    [bottomV addSubview:inviteBtn];

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
-(void)onClickBtn:(UITapGestureRecognizer*)tap{
    self.currentRow=-1;
    _isSelectCell=-1;
    if (tap.view.tag==101) {
        if (isSortJob==0) {
            isSortJob=1;
            [self sortReverseArr];
            [self.tableView reloadData];
        }else{
            isSortJob=0;
            [self sortReverseArr];
            [self.tableView reloadData];
        }
    }
    
    if (tap.view.tag==100) {
        if (isSortActive==1) {
            isSortActive=0;
            [self sortFromLargelToSmall:@"activepoints"];
            [self.tableView reloadData];
        }else{
            isSortActive=1;
            [self sortFromSmallToLarge:@"activepoints"];
            [self.tableView reloadData];
        }
    }
    if (tap.view.tag==102) {
        if (isSortSex==0) {
            isSortSex=1;
            [self sortFromLargelToSmall:@"sex"];
            [self.tableView reloadData];
        }else{
            isSortSex=0;
            [self sortFromSmallToLarge:@"sex"];
            [self.tableView reloadData];
        }
    }
    
    
}
-(void)sortReverseArr{
    if (_dataSource.count>1) {
        for (int i=0; i<_dataSource.count/2; i++) {
            NSDictionary *dic=_dataSource[i];
            _dataSource[i]=_dataSource[_dataSource.count-i-1];
            _dataSource[_dataSource.count-i-1]=dic;
        }
    }
    
}
-(void)sortFromSmallToLarge:(NSString *)type{
    if (_dataSource.count>1) {
        for (int i=0; i<_dataSource.count; i++) {
            for (int j=0; j<i; j++) {
                if ([_dataSource[i]objectForKey:type]==nil||[_dataSource[i]objectForKey:type]==[NSNull null]) {
                }else{
                    if ([[_dataSource[i]objectForKey:type]integerValue]<[[_dataSource[j]objectForKey:type]integerValue]) {
                        NSDictionary *dic=_dataSource[i];
                        _dataSource[i]=_dataSource[j];
                        _dataSource[j]=dic;
                    }
                }
            }
        }
    }
}
-(void)sortFromLargelToSmall:(NSString *)type{
    if (_dataSource.count>1) {
        for (int i=0; i<_dataSource.count; i++) {
            for (int j=0; j<i; j++) {
                if ([_dataSource[i]objectForKey:type]==nil||[_dataSource[i]objectForKey:type]==[NSNull null]) {
                }else{
                    if ([[_dataSource[i]objectForKey:type]integerValue]>[[_dataSource[j]objectForKey:type]integerValue]) {
                        NSDictionary *dic=_dataSource[i];
                        _dataSource[i]=_dataSource[j];
                        _dataSource[j]=dic;
                    }
                }
            }
        }
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,182*DEF_Adaptation_Font*0.5,DEF_WIDTH(self),696*DEF_Adaptation_Font*0.5)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=YES;
        _tableView.bounces=NO;
        
        [bkV addSubview:_tableView];
    }
    return _tableView;
}
#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
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
        NSDictionary *dataDic=_dataSource[indexPath.row];
    [self setTableViewCellView:cell andIndexPath:indexPath andDataDic:dataDic];
    cell.contentView.backgroundColor=[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0];
    cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BK_family_frame.png"]];
     cell.backgroundColor=[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0];

    return cell;
}
-(void)setTableViewCellView:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath andDataDic:(NSDictionary *)dataDic{
    UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"headimageurl"]]];
    headImage.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
    headImage.layer.masksToBounds=YES;
    [cell.contentView addSubview:headImage];
     if (creatType==1) {
         UILabel *headLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 12*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
         headLB.textColor=[UIColor whiteColor];
         headLB.font=[UIFont systemFontOfSize:14];
         headLB.text=[dataDic objectForKey:@"nickname"];
         [cell.contentView addSubview:headLB];
         UILabel *jobLB=[[UILabel alloc]initWithFrame:CGRectMake(100*DEF_Adaptation_Font*0.5, 51*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5)];
         jobLB.textColor=[UIColor whiteColor];
         jobLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:12.f];
         jobLB.text=[self jobnameForStatus:[[dataDic objectForKey:@"role"]intValue]];
         [cell.contentView addSubview:jobLB];
         jobLB.layer.cornerRadius=12*DEF_Adaptation_Font*0.5;
         jobLB.layer.masksToBounds=YES;
         jobLB.backgroundColor=[self jobColorForStatus:[[dataDic objectForKey:@"role"]intValue]];
         jobLB.textAlignment=NSTextAlignmentCenter;
         CGSize lblSize3 = [jobLB.text boundingRectWithSize:CGSizeMake(190*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:12.f]} context:nil].size;
         CGRect frame3=jobLB.frame;
         lblSize3.width+=32*DEF_Adaptation_Font*0.5;
         frame3.size=lblSize3;
         jobLB.frame=frame3;
     }else{
    UILabel *nickName=[[UILabel alloc]initWithFrame:CGRectMake(126*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5, 190*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5)];
    nickName.textColor=[UIColor whiteColor];
    nickName.font=[UIFont systemFontOfSize:14];
    nickName.text=[dataDic objectForKey:@"nickname"];
    [cell.contentView addSubview:nickName];
     }
    UILabel *activeLB=[[UILabel alloc]initWithFrame:CGRectMake(303*DEF_Adaptation_Font*0.5, 0, 93*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
    activeLB.textColor=[UIColor whiteColor];
    activeLB.font=[UIFont systemFontOfSize:14];
    
    if ([dataDic objectForKey:@"activepoints"]==[NSNull null]) {
        activeLB.text=@"0";
    }else{
        activeLB.text=[dataDic objectForKey:@"activepoints"];
    }
    activeLB.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:activeLB];
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
    UIButton *selectBtn=[LooperToolClass createBtnImageNameReal:@"CreateFleet_disagree.png" andRect:CGPointMake(DEF_WIDTH(bkV)-66*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andTag:(int)indexPath.row andSelectImage:@"CreateFleet_agree.png" andClickImage:@"CreateFleet_agree.png" andTextStr:nil andSize:CGSizeMake(36*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5) andTarget:self];
    self.BtnArr[indexPath.row]=selectBtn;
    [cell.contentView addSubview:selectBtn];
    if (self.currentRow==indexPath.row) {
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition: UITableViewScrollPositionNone];
        selectBtn.selected=YES;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  92*DEF_Adaptation_Font*0.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在这里进行更改职位操作
    NSDictionary *dataDic=self.dataSource[indexPath.row];
     UIButton *selectBtn=self.BtnArr[indexPath.row];
    if (_isSelectCell==indexPath.row) {
        self.currentRow=-1;
        _isSelectCell=-1;
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.selected=NO;
        selectBtn.selected=NO;
    }else{
        _isSelectCell=indexPath.row;
         self.currentRow=indexPath.row;
        for (UIButton *button in self.BtnArr) {
            if (button.tag!=indexPath.row) {
                NSLog(@"tag:%ld",button.tag);
                button.selected=NO;
            }
        }
        selectBtn.selected=YES;
        
    }
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
