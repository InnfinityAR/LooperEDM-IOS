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
#import "ActivityViewModel.h"
#import "LocalDataMangaer.h"
#import "DataHander.h"
#import "UITextField+LooperTextField.h"
#define TAGBUTTON 10000
@interface barrageReplyView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UIButton *_sendButton;
    BOOL isHeader;
    //总共有多少回复
    UILabel *numberLB;
    //总共输入多少字
    UILabel *countLB;
    UILabel *_commendLB;
    
    UIView *bottomView;
}
@property(nonatomic)NSInteger index;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *headerView;
//设置高度
@property(nonatomic,strong)NSMutableArray *heightArr;
@property(nonatomic,strong)NSString *sendPerson;
@end
@implementation barrageReplyView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andIndex:(NSInteger)index andViewModel:(id)viewModel andActivityID:(NSString *)activityID
{
    if (self = [super initWithFrame:frame]) {
        isHeader=NO;
        self.index=index;
        self.activityID=activityID;
        self.sendPerson=nil;
        self.viewModel=(ActivityViewModel *)viewModel;
        [self.viewModel setReplyView:self];
        self.obj=(ActivityBarrageView *)idObject;
        self.backgroundColor=[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
        self.dataArr=[self.obj barrageInfo];
        [self addHeaderViewInView:self.headerView andFirstHeight:110 andIndex:self.index];
//         self.replyArr=[[self.obj publishCellDic]objectForKey:@(self.index)];
        __block NSDictionary *buddleDic=[NSDictionary dictionary];
        //从第二个cell开始算的
        if (self.index==0) {
            buddleDic=self.dataArr[0];
        }else{
            buddleDic=self.dataArr[self.index-1];
        }
         [self.viewModel getReplyDataForMessageID:[[buddleDic objectForKey:@"messageid"]intValue] andIndex:self.index];
        [self calculateHeightArr];
        [self initView];
        [self addBottomView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(NSMutableArray *)heightArr{
    if (!_heightArr) {
        _heightArr=[[NSMutableArray alloc]init];
    }
    return _heightArr;
}
-(void)updateCommendLB:(NSArray *)dataArr{
    __block NSDictionary *buddleDic=[NSDictionary dictionary];
    //从第二个cell开始算的
    if (self.index==0) {
        buddleDic=dataArr[0];
    }else{
        buddleDic=dataArr[self.index-1];
    }
    _commendLB.text=[NSString stringWithFormat:@"%@",buddleDic[@"thumbupcount"]];
}
-(void)addReplyData:(NSInteger)index andArray:(NSArray *)dataArr andSendPerson:(NSString *)sendPerson{
    self.replyArr=dataArr;
    [self calculateHeightArr];
    self.sendPerson=sendPerson;
    self.textField.text=@"";
    numberLB.text=[NSString stringWithFormat:@"共%ld条回复",self.replyArr.count];
    [self.tableView reloadData];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSLog(@"%ld",button.tag);
    
    if (button.tag>=TAGBUTTON) {
        NSDictionary *buddleDic=[NSDictionary dictionary];
        buddleDic=_replyArr[button.tag-TAGBUTTON];
        if (button.selected==YES) {
            button.selected=NO;
              [self.viewModel thumbActivityMessageLike:@(0) andUserId:[LocalDataMangaer sharedManager].uid andReplyID:[buddleDic objectForKey:@"replyid"] MessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andIndex:self.index andIsReplyView:YES];
        }else{
            button.selected=YES;
            [self.viewModel thumbActivityMessageLike:@(1) andUserId:[LocalDataMangaer sharedManager].uid andReplyID:[buddleDic objectForKey:@"replyid"] MessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andIndex:self.index andIsReplyView:YES];
        }
    }
    if (button.tag==-4) {
        __block NSDictionary *buddleDic=[NSDictionary dictionary];
//从第二个cell开始算的
        if (self.index==0) {
            buddleDic=_dataArr[0];
        }else{
            buddleDic=_dataArr[self.index-1];
        }
        if (button.selected==YES) {
            [button setSelected:NO];
            [self.viewModel thumbActivityMessage:@"0" andUserId:[LocalDataMangaer sharedManager].uid andMessageId:[buddleDic objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:YES];
        }
        else{
            [button setSelected:YES];
            [self.viewModel thumbActivityMessage:@"1" andUserId: [LocalDataMangaer sharedManager].uid andMessageId:[buddleDic objectForKey:@"messageid"] andActivityID:self.activityID andCommendForReply:YES];
        }
    }
    if(button.tag==-2){
        [self.viewModel setIsReplyV:NO];
//        NSDictionary *buddleDic=[NSDictionary dictionary];
//        if (self.index==0) {
//            buddleDic=_dataArr[0];
//        }else{
//            buddleDic=_dataArr[self.index-1];
//        }
//        [self.viewModel getActivityInfoById:self.activityID andUserId:[LocalDataMangaer sharedManager].uid];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

        [self removeFromSuperview];
    }
    if (button.tag==-1) {
        //刷新replyArr的数据，同时更新tableView
        [_textField becomeFirstResponder];
        _textField.tag=button.tag;
    }
    if (button.tag>=0&&button.tag<=self.replyArr.count+1) {
        [_textField becomeFirstResponder];
        _textField.tag=button.tag;
        NSDictionary *buddleDic=_replyArr[_textField.tag];
        _textField.text=[NSString stringWithFormat:@"@%@",[buddleDic  objectForKey:@"username"]];
        
    }
    
    if (button.tag==-3) {
        NSLog(@"%@",_textField.text);
        if (_textField.tag>=-1&&![_textField.text isEqualToString:@""]) {
        NSDictionary *buddleDic=[NSDictionary dictionary];
        if (_textField.tag==-1) {
                if (self.index==0) {
                    buddleDic=_dataArr[0];
                }else{
                    buddleDic=_dataArr[self.index-1];
                }
              [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:_textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES andSendPerson:nil];
        }
        if (_textField.tag>=0) {
            
            buddleDic=_replyArr[_textField.tag];
            if ([[buddleDic  objectForKey:@"username"]isEqualToString:@""]) {
                _textField.text=[_textField.text substringFromIndex:1];
            }else{
                if (_textField.text.length>[[buddleDic  objectForKey:@"username"]length]+1&&[[_textField.text substringToIndex:[[buddleDic  objectForKey:@"username"]length]+1]isEqualToString:[NSString stringWithFormat:@"@%@",[buddleDic  objectForKey:@"username"]]]) {
                _textField.text=[_textField.text substringFromIndex:[[buddleDic  objectForKey:@"username"]length]+1];
                }
            [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:_textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES andSendPerson:[buddleDic  objectForKey:@"userid"]];
            }
        }
        }
        if ([_textField.text isEqualToString:@""]) {
              [[DataHander sharedDataHander] showViewWithStr:@"地球人你发不了空评论" andTime:1 andPos:CGPointZero];
        }
        if (_textField.text.length>=100) {
              [[DataHander sharedDataHander] showViewWithStr:@"地球人你发评论超过100字了" andTime:1 andPos:CGPointZero];
        }
        [_textField resignFirstResponder];
    }
}
-(void)calculateHeightArr{
    for (NSDictionary *replyDic in self.replyArr) {
        NSString *content=[replyDic objectForKey:@"messagecontent"];
        CGSize lblSize2 = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
         [self.heightArr addObject:@((270)*DEF_Adaptation_Font*0.5+lblSize2.height)];
    }
}
-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)/2)];
        _headerView.image=[UIImage imageNamed:@"bottomIV.png"];
        _headerView.userInteractionEnabled=YES;
        _headerView.backgroundColor=[self.obj randomColorAndIndex:(int)self.index%5];
        [self addSubview:_headerView];

    }
    return _headerView;
}
-(void)addHeaderViewInView:(UIView *)view andFirstHeight:(CGFloat)firstY andIndex:(NSInteger)index{
    NSDictionary *buddleDic=[NSDictionary dictionary];
    if (isHeader==NO) {
    if (index==0) {
    buddleDic=_dataArr[0];
    }else{
    buddleDic=_dataArr[index-1];
    }
         index=-1;
     
    }else{
        buddleDic=_replyArr[index];
    }
     UIImageView  *userImageView =[[UIImageView alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, firstY*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    userImageView.layer.cornerRadius =40*DEF_Adaptation_Font*0.5;
    userImageView.layer.masksToBounds=YES;
    //加入点击事件
    userImageView.userInteractionEnabled=YES;
    if ([buddleDic objectForKey:@"userimage"]==[NSNull null]) {
    }else{
    [userImageView sd_setImageWithURL:[NSURL URLWithString:[buddleDic objectForKey:@"userimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];}
    [view addSubview:userImageView];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(140*DEF_Adaptation_Font*0.5, firstY*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
     nameLB.text=[buddleDic objectForKey:@"username"];
    nameLB.textColor=[UIColor whiteColor];
    [view addSubview:nameLB];
    
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(140*DEF_Adaptation_Font*0.5, (firstY+50)*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    timeLB.text=buddleDic[@"creationdate"];
     timeLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    timeLB.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [view addSubview:timeLB];

    UIButton *commendBtn= [LooperToolClass createBtnImageNameReal:@"praiseNO.png" andRect:CGPointMake(440*DEF_Adaptation_Font*0.5, firstY*DEF_Adaptation_Font*0.5) andTag:(int)index+TAGBUTTON andSelectImage:@"praiseYES.png" andClickImage:@"praiseYES.png" andTextStr:nil andSize:CGSizeMake(66*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    if (isHeader==NO) {
        commendBtn.tag=-4;
            }
    if ([buddleDic[@"isthumb"]intValue]==1) {
        [commendBtn setSelected:YES];
    }else{
        [commendBtn setSelected:NO];
    }
    [view addSubview:commendBtn];
  UILabel  *commendLB=[[UILabel alloc]initWithFrame:CGRectMake(495*DEF_Adaptation_Font*0.5,(firstY+10)*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    commendLB.font=[UIFont boldSystemFontOfSize:12];
    commendLB.textColor=[UIColor whiteColor];
    
    if (isHeader==NO) {
        commendLB.text=[NSString stringWithFormat:@"%@",buddleDic[@"thumbupcount"]];
        _commendLB= commendLB;
    }else{
    commendLB.text=[NSString stringWithFormat:@"%@",buddleDic[@"thumbcount"]];
    }
    [view addSubview:commendLB];
   UIButton *shareBtn= [LooperToolClass createBtnImageNameReal:@"replyBtn.png" andRect:CGPointMake(550*DEF_Adaptation_Font*0.5, (firstY)*DEF_Adaptation_Font*0.5) andTag:(int)index andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(66*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    shareBtn.tag=index;
    [view addSubview:shareBtn];
    UILabel *contentLB=[[UILabel alloc]initWithFrame:CGRectMake(40*DEF_Adaptation_Font*0.5, (firstY+100)*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5, 240)];
    contentLB.numberOfLines=0;
      contentLB.textColor=[UIColor whiteColor];
    contentLB.text=[buddleDic objectForKey:@"messagecontent"];
//用来完成@功能
    if ([buddleDic objectForKey:@"targetname"]!=[NSNull null]&&isHeader&&![[buddleDic objectForKey:@"targetname"]isEqualToString:@""]) {
    contentLB.text=[NSString stringWithFormat:@"@%@ %@",[buddleDic objectForKey:@"targetname"], buddleDic[@"messagecontent"]];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:contentLB.text];
        //更改字体
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16] range:NSMakeRange(0, [[buddleDic objectForKey:@"targetname"]length]+2)];
        //修改颜色
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:68/255.0 green:130/255.0 blue:173/255.0 alpha:1.0] range:NSMakeRange(0,[[buddleDic objectForKey:@"targetname"]length]+2)];
        contentLB.attributedText = string;
        self.sendPerson=nil;
    }
    CGSize lblSize2 = [contentLB.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
    float height=lblSize2.height;
    CGRect contentFrame=contentLB.frame;
    contentFrame.size.height=lblSize2.height;
    contentLB.frame=contentFrame;
    [view addSubview:contentLB];
    if (isHeader==NO) {
        isHeader=YES;
    }else{
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0,  (firstY+110)*DEF_Adaptation_Font*0.5+height+70*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 1*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    [view addSubview:lineV];
    }
    CGRect frame=view.frame;
    frame.size.height=(firstY+130)*DEF_Adaptation_Font*0.5+height;
    view.frame=frame;
    
}
-(void)addBottomView{
//    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(self)-100*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 1*DEF_Adaptation_Font*0.5)];
//    lineV.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
//    [self addSubview:lineV];
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(self)-115*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 115*DEF_Adaptation_Font*0.5)];
    bottomView=contentView;
    contentView.backgroundColor=[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
    [self addSubview:contentView];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)- 200*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    _textField.placeholder = @"快来回复我";
    _textField.tag=-1;
    // 设置了占位文字内容以后, 才能设置占位文字的颜色
    _textField.font=[UIFont systemFontOfSize:14];
    _textField.layer.masksToBounds=YES;
//    _textField.leftView=[[UIView alloc]initWithFrame:CGRectMake(-10*DEF_Adaptation_Font*0.5, 0, 30*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
//    _textField.leftViewMode=UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _textField.backgroundColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:89/255.0 alpha:1.0];
    _textField.returnKeyType = UIReturnKeySend; //设置按键类型
    _textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
    _textField.clearsOnBeginEditing = YES;
    _textField.delegate=self;
     [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    _textField.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
    _textField.textColor = [UIColor whiteColor];
//    _textField.clipsToBounds=NO;
    [contentView addSubview:_textField];
    countLB=[[UILabel alloc]initWithFrame:CGRectMake(559*DEF_Adaptation_Font*0.5, -3*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 38*DEF_Adaptation_Font*0.5)];
    countLB.text=@"0/100";
    countLB.textColor=[UIColor whiteColor];
    countLB.font=[UIFont systemFontOfSize:10];
    [contentView addSubview:countLB];
    _sendButton=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(self)- 160*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5) andTag:-3 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 140*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    _sendButton.backgroundColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:89/255.0 alpha:1.0];
    [_sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    _sendButton.layer.cornerRadius=4.0;
    _sendButton.layer.masksToBounds=YES;
    [contentView addSubview:_sendButton];
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
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:-2 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    numberLB=[[UILabel alloc]initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, DEF_HEIGHT(_headerView)+40*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    [self addSubview:numberLB];
    numberLB.text=[NSString stringWithFormat:@"共%ld条回复",self.replyArr.count];
    numberLB.font=[UIFont systemFontOfSize:20];
    numberLB.textColor=[UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,DEF_HEIGHT(_headerView)+100*DEF_Adaptation_Font*0.5,DEF_WIDTH(self),DEF_HEIGHT(self)-DEF_HEIGHT(_headerView)-200*DEF_Adaptation_Font*0.5)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //不出现滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        [_tableView setBackgroundColor:[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0]];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=YES;
//        _tableView.bounces=NO;

        [self addSubview:_tableView];
    }
    return _tableView;
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    bottomView.frame = CGRectMake(bottomView.frame.origin.x, DEF_SCREEN_HEIGHT -frame.size.height-bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);

}
-(void)keyboardWillHide:(NSNotification *)notification{

    bottomView.frame = CGRectMake(bottomView.frame.origin.x, DEF_SCREEN_HEIGHT -bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
if (range.location>=99) {
        textField.text=[textField.text substringToIndex:99];
    }
    countLB.text=[NSString stringWithFormat:@"%ld/100",_textField.text.length];
    if (range.location==0) {
         countLB.text=@"0/100";
    }
    if (range.location==99) {
        countLB.text=@"100/100";
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    countLB.text=@"0/100";
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag>=-1&&![textField.text isEqualToString:@""]) {
        NSDictionary *buddleDic=[NSDictionary dictionary];
        if (textField.tag==-1) {
            if (self.index==0) {
                buddleDic=_dataArr[0];
            }else{
                buddleDic=_dataArr[self.index-1];
            }
            [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES andSendPerson:nil];
        }
        if (_textField.tag>=0) {
            buddleDic=_replyArr[_textField.tag];
            if ([[buddleDic  objectForKey:@"username"]isEqualToString:@""]) {
                _textField.text=[_textField.text substringFromIndex:1];
            }else{
                if (_textField.text.length>[[buddleDic  objectForKey:@"username"]length]+1&&[[_textField.text substringToIndex:[[buddleDic  objectForKey:@"username"]length]+1]isEqualToString:[NSString stringWithFormat:@"@%@",[buddleDic  objectForKey:@"username"]]]) {
                    _textField.text=[_textField.text substringFromIndex:[[buddleDic  objectForKey:@"username"]length]+1];
                }
                [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:_textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES andSendPerson:[buddleDic  objectForKey:@"userid"]];
            }
        }
    }
    if ([textField.text isEqualToString:@""]) {
        [[DataHander sharedDataHander] showViewWithStr:@"地球人你发不了空评论" andTime:1 andPos:CGPointZero];
    }
    if (textField.text.length>100) {
        [[DataHander sharedDataHander] showViewWithStr:@"地球人你发评论超过100字了" andTime:1 andPos:CGPointZero];
    }
    [self endEditing:YES];
    return YES;
}
#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.replyArr.count;
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
    [self addHeaderViewInView:cell.contentView andFirstHeight:110*DEF_Adaptation_Font*0.5 andIndex:indexPath.row];
    cell.contentView.backgroundColor=[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
    cell.layer.masksToBounds=YES;
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
    else{
        [self endEditing:false];
         [_textField becomeFirstResponder];
        if (![_textField.text isEqualToString:@""]) {
            NSDictionary *buddleDic=[NSDictionary dictionary];
            buddleDic=_replyArr[indexPath.row];
            _textField.text=[NSString stringWithFormat:@"@%@",[buddleDic objectForKey:@"username" ]];
            _textField.tag=indexPath.row;
//            NSDictionary *buddleDic=[NSDictionary dictionary];
//                buddleDic=_replyArr[indexPath.row];
//                [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:_textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES andSendPerson:[buddleDic  objectForKey:@"userid"]];
        }else{
            NSDictionary *buddleDic=[NSDictionary dictionary];
            buddleDic=_replyArr[indexPath.row];
            _textField.text=[NSString stringWithFormat:@"@%@",[buddleDic objectForKey:@"username" ]];
            _textField.tag=indexPath.row;
        }

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.heightArr.firstObject floatValue];
    return [self.heightArr[indexPath.row]floatValue];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//CGFloat moveY=[scrollView.panGestureRecognizer translationInView:self].y;
     CGFloat yOffset  = scrollView.contentOffset.y;
//    NSLog(@"yOffset===%f,panPoint===%f",yOffset,moveY);
    if (yOffset>0) {
        //往上滑
        CGRect frame=self.tableView.frame;
        frame=CGRectMake(0,DEF_HEIGHT(_headerView)+100*DEF_Adaptation_Font*0.5-yOffset,DEF_WIDTH(self),DEF_HEIGHT(self)-DEF_HEIGHT(_headerView)-200*DEF_Adaptation_Font*0.5+yOffset);
        if (frame.origin.y<DEF_HEIGHT(_headerView)) {
            frame.origin.y=DEF_HEIGHT(_headerView);
            frame.size.height=DEF_HEIGHT(self)-DEF_HEIGHT(_headerView)-100*DEF_Adaptation_Font*0.5;
        }
        self.tableView.frame=frame;
        CGRect frame1=numberLB.frame;
        frame1.origin.y-=yOffset*0.2;
        if (frame1.origin.y<DEF_HEIGHT(_headerView)+4*DEF_Adaptation_Font*0.5) {
            frame1.origin.y=DEF_HEIGHT(_headerView);
            frame1.size.height=0;
            numberLB.alpha=0;
        }
        numberLB.frame=frame1;
        
    }
    if (yOffset<=0) {
        //往下滑
        CGRect frame=self.tableView.frame;
        frame.origin.y=DEF_HEIGHT(_headerView)+frame.origin.y-yOffset;
        frame.size.height-=DEF_HEIGHT(self)-DEF_HEIGHT(_headerView)-100*DEF_Adaptation_Font*0.5+yOffset;
        if (frame.origin.y>DEF_HEIGHT(_headerView)+100*DEF_Adaptation_Font*0.5) {
            frame.origin.y=DEF_HEIGHT(_headerView)+100*DEF_Adaptation_Font*0.5;
            frame.size.height=DEF_HEIGHT(self)-DEF_HEIGHT(_headerView)-200*DEF_Adaptation_Font*0.5;
        }
//          NSLog(@"frameY: %f,biggestY: %f",frame.origin.y,DEF_HEIGHT(_headerView)+100*DEF_Adaptation_Font*0.5);
        self.tableView.frame=frame;
        numberLB.alpha=1;
        CGRect frame1=numberLB.frame;
         frame1.origin.y=DEF_HEIGHT(_headerView)+40*DEF_Adaptation_Font*0.5;
            frame1.size.height=60*DEF_Adaptation_Font*0.5;
        numberLB.frame=frame1;
      
    }

}
@end
