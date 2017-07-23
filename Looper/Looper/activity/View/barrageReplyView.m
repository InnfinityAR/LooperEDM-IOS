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
@interface barrageReplyView()<UITableViewDelegate,UITableViewDataSource>
{
    UITextField *_textField;
    UIButton *_sendButton;
    BOOL isHeader;
    UILabel *numberLB;
}
@property(nonatomic)NSInteger index;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *headerView;
//设置高度
@property(nonatomic,strong)NSMutableArray *heightArr;

@end
@implementation barrageReplyView

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andIndex:(NSInteger)index andViewModel:(id)viewModel
{
    if (self = [super initWithFrame:frame]) {
        isHeader=NO;
        self.index=index;
        self.viewModel=(ActivityViewModel *)viewModel;
        [self.viewModel setReplyView:self];
        self.obj=(ActivityBarrageView *)idObject;
        self.backgroundColor=[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
        self.dataArr=[self.obj barrageInfo];
        [self addHeaderViewInView:self.headerView andFirstHeight:110 andIndex:self.index];
         self.replyArr=[[self.obj publishCellDic]objectForKey:@(self.index)];
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
-(void)addReplyData:(NSInteger)index andArray:(NSArray *)dataArr{
    self.replyArr=dataArr;
    numberLB.text=[NSString stringWithFormat:@"共%ld条回复",self.replyArr.count];
    [self.tableView reloadData];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    NSLog(@"%ld",button.tag);
    if(button.tag==-2){
        [self removeFromSuperview];
    }
    if (button.tag==-1) {
        //刷新replyArr的数据，同时更新tableView
        [_textField becomeFirstResponder];
        _textField.tag=button.tag;
    }
    if (button.tag>=0) {
        [_textField becomeFirstResponder];
        _textField.tag=button.tag;
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
              [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:_textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES];
        }
        if (_textField.tag>=0) {
            buddleDic=_replyArr[_textField.tag];
           [self.viewModel pustDataForActivityID:[[buddleDic  objectForKey:@"activityid"]intValue] andMessageID:[[buddleDic  objectForKey:@"messageid"]intValue] andContent:_textField.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue]) andIndex:self.index andIsReplyView:YES];
        }
        
    }
        [_textField resignFirstResponder];
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
        isHeader=YES;
    }else{
        buddleDic=_replyArr[index];
    }
     UIImageView  *userImageView =[[UIImageView alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, firstY*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5)];
    userImageView.layer.cornerRadius =40*DEF_Adaptation_Font*0.5;
    userImageView.layer.masksToBounds=YES;
    //加入点击事件
    userImageView.userInteractionEnabled=YES;
    [userImageView sd_setImageWithURL:[NSURL URLWithString:[buddleDic objectForKey:@"userimage"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [view addSubview:userImageView];
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, firstY*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
     nameLB.text=[buddleDic objectForKey:@"username"];
    nameLB.textColor=[UIColor whiteColor];
    [view addSubview:nameLB];
    
    UILabel *timeLB=[[UILabel alloc]initWithFrame:CGRectMake(120*DEF_Adaptation_Font*0.5, (firstY+50)*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    timeLB.text=buddleDic[@"creationdate"];
    timeLB.font=[UIFont systemFontOfSize:13];
    timeLB.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    [view addSubview:timeLB];

    UIButton *commendBtn= [LooperToolClass createBtnImageNameReal:@"commendNO1.png" andRect:CGPointMake(420*DEF_Adaptation_Font*0.5, firstY*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"commendYES1.png" andClickImage:@"commendYES1.png" andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
    [view addSubview:commendBtn];
  UILabel  *commendLB=[[UILabel alloc]initWithFrame:CGRectMake(475*DEF_Adaptation_Font*0.5,(firstY+10)*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
    commendLB.font=[UIFont boldSystemFontOfSize:12];
    commendLB.textColor=[UIColor whiteColor];
    commendLB.text=[NSString stringWithFormat:@"%@",buddleDic[@"thumbupcount"]];
    [view addSubview:commendLB];
   UIButton *shareBtn= [LooperToolClass createBtnImageNameReal:@"replyBtn.png" andRect:CGPointMake(530*DEF_Adaptation_Font*0.5, (firstY-10)*DEF_Adaptation_Font*0.5) andTag:(int)index andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(90*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5) andTarget:self];
    shareBtn.tag=index;
    [view addSubview:shareBtn];
    UILabel *contentLB=[[UILabel alloc]init];
    float height=[self heightForString:buddleDic[@"messagecontent"] andWidth:DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5 andText:contentLB];
    [contentLB setFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, (firstY+90)*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5, height)];
    contentLB.textColor=[UIColor whiteColor];
    [view addSubview:contentLB];
    CGRect frame=view.frame;
    frame.size.height=(firstY+120)*DEF_Adaptation_Font*0.5+height;
    view.frame=frame;
    
    [self.heightArr addObject:@((firstY+120)*DEF_Adaptation_Font*0.5+height)];
    
}
-(void)addBottomView{
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(self)-100*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 1*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    [self addSubview:lineV];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, DEF_HEIGHT(self)-80*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)- 200*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
    _textField.placeholder = @"快来回复我";
    // 设置了占位文字内容以后, 才能设置占位文字的颜色
    [_textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _textField.backgroundColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:89/255.0 alpha:1.0];
    _textField.returnKeyType = UIReturnKeySearch; //设置按键类型
    _textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
    _textField.clearsOnBeginEditing = YES;
     [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    _textField.textColor = [UIColor whiteColor];
    [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self addSubview:_textField];
    _sendButton=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(self)- 160*DEF_Adaptation_Font*0.5, DEF_HEIGHT(self)-80*DEF_Adaptation_Font*0.5) andTag:-3 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake( 140*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
    _sendButton.backgroundColor=[UIColor colorWithRed:68/255.0 green:68/255.0 blue:89/255.0 alpha:1.0];
    [_sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    _sendButton.layer.cornerRadius=4.0;
    _sendButton.layer.masksToBounds=YES;
    [self addSubview:_sendButton];
    
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
    numberLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, DEF_HEIGHT(_headerView)+20*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-40*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5)];
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
        _tableView.alwaysBounceVertical=NO;
        _tableView.bounces=NO;
        [self addSubview:_tableView];
    }
    return _tableView;
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _sendButton.frame = CGRectMake(_sendButton.frame.origin.x, DEF_SCREEN_HEIGHT- frame.size.height-_sendButton.frame.size.height-15*DEF_Adaptation_Font*0.5, _sendButton.frame.size.width, _sendButton.frame.size.height);
    
    _textField.frame = CGRectMake(_textField.frame.origin.x, DEF_SCREEN_HEIGHT -frame.size.height-_textField.frame.size.height-15*DEF_Adaptation_Font*0.5, _textField.frame.size.width, _textField.frame.size.height);
}
-(void)keyboardWillHide:(NSNotification *)notification{
    
    _sendButton.frame = CGRectMake(_sendButton.frame.origin.x, DEF_SCREEN_HEIGHT-_sendButton.frame.size.height-15*DEF_Adaptation_Font*0.5, _sendButton.frame.size.width, _sendButton.frame.size.height);
    
    _textField.frame = CGRectMake(_textField.frame.origin.x, DEF_SCREEN_HEIGHT -_textField.frame.size.height-15*DEF_Adaptation_Font*0.5, _textField.frame.size.width, _textField.frame.size.height);
    
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self endEditing:YES];
    return YES;
}
#pragma -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.replyArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellStyleDefault;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self addHeaderViewInView:cell.contentView andFirstHeight:150*DEF_Adaptation_Font*0.5 andIndex:indexPath.row];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(cell)-1*DEF_Adaptation_Font*0.5, DEF_WIDTH(cell), 1*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    [cell.contentView addSubview:lineV];
    cell.contentView.backgroundColor=[UIColor colorWithRed:36/255.0 green:34/255.0 blue:60/255.0 alpha:1.0];
        return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.heightArr.firstObject floatValue];
//    return [self.heightArr[indexPath.row]floatValue];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}
@end
