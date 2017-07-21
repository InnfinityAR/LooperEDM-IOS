//
//  barrageReplyView.m
//  Looper
//
//  Created by 工作 on 2017/7/21.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "barrageReplyView.h"
#import "ActivityBarrageView.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "ActivityCell.h"
@interface barrageReplyView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)NSInteger index;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *headerView;
@end
@implementation barrageReplyView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andIndex:(NSInteger)index
{
    if (self = [super initWithFrame:frame]) {
        self.index=index;
        self.obj=(ActivityBarrageView *)idObject;
        self.dataArr=[self.obj barrageInfo];
        [self addHeaderView];
        [self initView];
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        [self removeFromSuperview];
    }
    if (button.tag==101) {
    }
}
-(void)addHeaderView{
    self.headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)/2)];
    _headerView.image=[UIImage imageNamed:@"bottomIV.png"];
    _headerView.userInteractionEnabled=YES;
    [self addSubview:_headerView];
    _headerView.backgroundColor=[self.obj randomColorAndIndex:(int)self.index%5];
    NSDictionary *buddleDic=[NSDictionary dictionary];
    if (_index==0) {
    buddleDic=_dataArr[0];
    }else{
    buddleDic=_dataArr[_index-1];
    }
     UIImageView  *userImageView =[[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    userImageView.layer.cornerRadius =40*DEF_Adaptation_Font*0.5;
    userImageView.layer.masksToBounds=YES;
    //加入点击事件
    userImageView.userInteractionEnabled=YES;
    [userImageView sd_setImageWithURL:[NSURL URLWithString:[buddleDic objectForKey:@"userimage"]]];
    [self addSubview:userImageView];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
     nameLB.text=[buddleDic objectForKey:@"username"];
    nameLB.textColor=[UIColor whiteColor];
    [_headerView addSubview:nameLB];
    UIButton *commendBtn= [LooperToolClass createBtnImageNameReal:@"commendNO1.png" andRect:CGPointMake(420*DEF_Adaptation_Font*0.5, 110*DEF_Adaptation_Font*0.5) andTag:1 andSelectImage:@"commendYES1.png" andClickImage:@"commendYES1.png" andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
    [_headerView addSubview:commendBtn];
  UILabel  *commendLB=[[UILabel alloc]initWithFrame:CGRectMake(475*DEF_Adaptation_Font*0.5,120*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    commendLB.font=[UIFont boldSystemFontOfSize:12];
    commendLB.textColor=[UIColor whiteColor];
    commendLB.text=[NSString stringWithFormat:@"%@",buddleDic[@"thumbupcount"]];
    [_headerView addSubview:commendLB];
   UIButton *shareBtn= [LooperToolClass createBtnImageNameReal:@"replyBtn.png" andRect:CGPointMake(530*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5) andTag:2 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5) andTarget:self];
    [_headerView addSubview:shareBtn];
    UILabel *contentLB=[[UILabel alloc]init];
    float height=[self heightForString:buddleDic[@"messagecontent"] andWidth:DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5 andText:contentLB];
    [contentLB setFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5, height)];
    contentLB.textColor=[UIColor whiteColor];
    [_headerView addSubview:contentLB];
    CGRect frame=_headerView.frame;
    frame.size.height=230*DEF_Adaptation_Font*0.5+height;
    _headerView.frame=frame;
}
- (float) heightForString:(NSString *)value andWidth:(float)width andText:(UILabel *)label{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    label.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height+16.0;
}

-(void)initView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,104*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,DEF_HEIGHT(_headerView),DEF_WIDTH(self),DEF_HEIGHT(self)-DEF_HEIGHT(_headerView)-100*DEF_Adaptation_Font*0.5)style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=NO;
        _tableView.bounces=NO;
        _tableView.backgroundColor=[UIColor redColor];
        [self addSubview:_tableView];
    }
    return _tableView;
}
#pragma -tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        return cell;
    
}

@end
