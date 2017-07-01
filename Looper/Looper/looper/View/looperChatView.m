//
//  looperChatView.m
//  Looper
//
//  Created by lujiawei on 1/20/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperChatView.h"
#import "looperViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "looperCellView.h"
#import "looperChatCellViewCollectionViewCell.h"
#import "XDRefresh.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"


@implementation looperChatView{
    
    UIButton *followBtn;
    UITextField *text;
    
    UICollectionView *_collectView;
    
    UITableView *chatTableView;
    
    NSDictionary *looperChatDicT;
    NSDictionary *chatlooperData;
    
    NSMutableArray *hotChatArray;
    
    int chatCount;
    
    XDRefreshHeader *_header;
    XDRefreshFooter *_footer;
    
    
    looperCellView *headcellV;
    
    NSDictionary *ReplyDic;
    
    
    int currentPage;
    int maxPage;
    //点赞按钮
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
        
    }
    return self;
}

-(void)reflashData:(NSDictionary*)looperData andPage:(int)page{
    
    if(page==1){
           looperChatDicT = looperData;
    
    }else{
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [tempDic setObject:[looperChatDicT objectForKey:@"data"] forKey:@"data"];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[looperChatDicT objectForKey:@"message"]];
        for (NSDictionary *data in [looperData objectForKey:@"message"]){
        
            [tempArray addObject:data];
        }
        
        [tempDic setObject:tempArray forKey:@"message"];
        
        
        looperChatDicT = tempDic;
    }
    [_collectView reloadData];
    [self refrashHeadView];
    
}


-(void)removeAction{

    _header=nil;
    _footer=nil;
    [_collectView removeFromSuperview];
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag == 600){
        [self removeAction];
        [_obj removeLoopChat];

    }else if(button.tag == 601){
        if(followBtn.selected==true){
            [_obj unfollowLoop];
            [followBtn setSelected:false];
        }
    }
        else if (button.tag<=10000+hotChatArray.count-1&&button.tag>=10000){
        //在这返回islike和thumbupcount的参数
            NSDictionary *dic = [hotChatArray objectAtIndex:button.tag-10000];
            if (!button.selected) {
                [button setSelected:YES];
                [self.obj addPreferenceToCommentMessageId:[dic objectForKey:@"yunxinid"] andlike:1 andTarget:[dic objectForKey:@"userid"] andMessageText:[dic objectForKey:@"messagecontent"]];
                NSLog(@"push的数据message:%@,targetId:%@,messageText:%@",[dic objectForKey:@"yunxinid"],[dic objectForKey:@"userid"],[dic objectForKey:@"messagecontent"]);
            }
            else{
                [button setSelected:NO];
                [self.obj addPreferenceToCommentMessageId:[dic objectForKey:@"yunxinid"] andlike:0 andTarget:[dic objectForKey:@"userid"] andMessageText:[dic objectForKey:@"messagecontent"]];
                 NSLog(@"push的数据%@,%@,%@",[dic objectForKey:@"yunxinid"],[dic objectForKey:@"userid"],[dic objectForKey:@"messagecontent"]);
            }
        }
        else if (button.tag<=20000+[[looperChatDicT objectForKey:@"data"] count]-1&&button.tag>=20000){
        NSDictionary *dic = [[looperChatDicT objectForKey:@"data"] objectAtIndex:button.tag-20000];
            if (!button.selected) {
                [button setSelected:YES];
                [self.obj addPreferenceToCommentMessageId:[dic objectForKey:@"yunxinid"] andlike:1 andTarget:[dic objectForKey:@"userid"] andMessageText:[dic objectForKey:@"messagecontent"]];
            }
            else{
                [button setSelected:NO];
                [self.obj addPreferenceToCommentMessageId:[dic objectForKey:@"yunxinid"] andlike:0 andTarget:[dic objectForKey:@"userid"] andMessageText:[dic objectForKey:@"messagecontent"]];
            }
        
        }
        else{
            [_obj followLoop];
            [followBtn setSelected:true];
        }
    
}


-(void)createHudView{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    UIImageView *chat_bg=[LooperToolClass createImageViewReal:@"bg_chat_back.png" andRect:CGPointMake(0,0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:chat_bg];
    
    UIImageView *titleBg=[LooperToolClass createImageViewReal:@"bg_title_chat.png" andRect:CGPointMake(293*DEF_Adaptation_Font*0.5,53*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(54*DEF_Adaptation_Font*0.5,27*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:titleBg];

    
    
    UIImageView *chatbK=[LooperToolClass createImageViewReal:@"bg_chat_bk.png" andRect:CGPointMake(0,DEF_SCREEN_HEIGHT-67*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 67*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:chatbK];
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:600 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    followBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_follow.png" andRect:CGPointMake(DEF_SCREEN_WIDTH-186/2, 59/2) andTag:601 andSelectImage:@"btn_looper_followed.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(104/2, 45/2) andTarget:self];
    [self addSubview:followBtn];
    
    if([_obj isFollow]==true){
        [followBtn setSelected:true];
    }
    
    UIImageView *localUser = [[UIImageView alloc] initWithFrame:CGRectMake(28*DEF_Adaptation_Font*0.5, 1083*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5)];
    localUser.layer.cornerRadius =42*DEF_Adaptation_Font*0.5*0.5;
    localUser.layer.masksToBounds = YES;
    
    [localUser sd_setImageWithURL:[[NSURL alloc] initWithString:[LocalDataMangaer sharedManager].HeadImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self addSubview:localUser];
    
    
     text=[self createTextField:@"  想什么呢 来聊聊" andImg:@"bg_looper_chat.png" andRect:CGRectMake(88*DEF_Adaptation_Font*0.5,1083*DEF_Adaptation_Font*0.5,392*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTag:1001];
    

    UIButton *chatList = [LooperToolClass createBtnImageNameReal:@"btn_chatList.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,1069*DEF_Adaptation_Font*0.5) andTag:600 andSelectImage:@"btn_chatList.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(56*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:chatList];
    
    
}


-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(3,0,  rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor grayColor];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.enablesReturnKeyAutomatically = YES;
    textField.returnKeyType = UIReturnKeySend;
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    return textField;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.frame = CGRectMake(0, -frame.size.height, self.frame.size.width, self.frame.size.height);
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self endEditing:YES];
    
    NSString *TargetId;
    NSString *MessageId;
    NSString *MessageText;
    
    if(ReplyDic!=nil){
        TargetId = [ReplyDic objectForKey:@"userid"];
        MessageId = [ReplyDic objectForKey:@"yunxinid"];
        MessageText = [ReplyDic objectForKey:@"messagecontent"];
    }
    
    
    [_obj sendMessage:textField.text andTarget:TargetId andReplyMessageId:MessageId andReplayMessageText:MessageText];
    textField.text = @"";
    return YES;
}

-(void)updataChatDic:(NSDictionary*)looperChatDic{
    looperChatDicT =looperChatDic;
    [hotChatArray removeAllObjects];
    for (int i =0;i<[[looperChatDicT objectForKey:@"data"] count];i++){
        NSDictionary *dic = [[looperChatDic objectForKey:@"data"] objectAtIndex:i];
        if([[dic objectForKey:@"thumbupcount"] intValue]>0){
            [hotChatArray addObject:dic];
        }
    }
    [chatTableView reloadData];
}

//用于评论的数据
-(void)initWithData:(NSDictionary *)looperCharDic andLooperData:(NSDictionary*)looperData{
    
    looperChatDicT =looperCharDic;
    hotChatArray = [[NSMutableArray alloc] initWithCapacity:50];
    [hotChatArray removeAllObjects];
    for (int i =0;i<[[looperChatDicT objectForKey:@"data"] count];i++){
        NSDictionary *dic = [[looperChatDicT objectForKey:@"data"] objectAtIndex:i];
        if([[dic objectForKey:@"thumbupcount"] intValue]>0){
            [hotChatArray addObject:dic];
        }
    }
    chatlooperData = looperData;
    currentPage = 1;
    maxPage = 2;
    [self createHudView];
    
    [self createTableView];
    //[self FeaturedView];
}


-(void)createTableView{
    
    chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 113*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, 955*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    chatTableView.dataSource = self;
    chatTableView.delegate = self;
    chatTableView.separatorStyle = NO;
    [chatTableView setBackgroundColor:[UIColor clearColor]];
    
    
   // UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
   // [chatTableView addGestureRecognizer:myTap];

    
    // [chatTableView setEditing:true animated:YES];
    [self addSubview:chatTableView];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic;
    
    if(indexPath.section==0){
        
        dic = [hotChatArray objectAtIndex:indexPath.row];
    }else{
        dic = [[looperChatDicT objectForKey:@"data"] objectAtIndex:indexPath.row];
        
    }
    
    
    if([[dic objectForKey:@"userid"] intValue]!=[[LocalDataMangaer sharedManager].uid intValue]){
        ReplyDic = dic;
        
        if([text.text length]==0){
            text.text = [NSString stringWithFormat:@"@%@:",[dic objectForKey:@"nickname"]];
            [text becomeFirstResponder];
            
        }else{
            text.text = @"";
            [self endEditing:true];
            
            
        }
    }else{
        text.text = @"";
        [self endEditing:true];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  151*DEF_Adaptation_Font*0.5;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section==0){
        return [hotChatArray count];
    }else if(section==1){
    
        return [[looperChatDicT objectForKey:@"data"] count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60*DEF_Adaptation_Font*0.5;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEF_SCREEN_WIDTH, 60*DEF_Adaptation_Font*0.5)];
    [v setBackgroundColor:[UIColor clearColor]];
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(22*DEF_Adaptation_Font*0.5, 5*DEF_Adaptation_Font*0.5, 200.0f, 20*DEF_Adaptation_Font*0.5)];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    [labelTitle setFont:[UIFont fontWithName:looperFont size:13]];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    if(section==0){
        labelTitle.text = @"热门弹幕";
    }else{
        labelTitle.text = @"最新弹幕";
    }
    
    [v addSubview:labelTitle];
    UIImageView* line=[LooperToolClass createImageView:@"chatline.png" andRect:CGPointMake(0, 58*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 2*DEF_Adaptation_Font*0.5) andIsRadius:false];

    [v addSubview:line];

    return v;
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 取出要拖动的模型数据
  
    
    
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
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    if(indexPath.section==0){
    
        NSDictionary *dic = [hotChatArray objectAtIndex:indexPath.row];
        //点赞
        UIButton *likeBtn=[LooperToolClass createBtnImageNameReal:@"btn_unfollowMusic.png" andRect:CGPointMake(DEF_WIDTH(tableView)-69*0.5*DEF_Adaptation_Font, 19*0.5*DEF_Adaptation_Font) andTag:10000+(int)indexPath.row andSelectImage:@"btn_followMusic.png" andClickImage:@"btn_followMusic.png" andTextStr:nil andSize:CGSizeMake(50*0.5*DEF_Adaptation_Font, 60*0.5*DEF_Adaptation_Font) andTarget:self];
        [cell.contentView addSubview:likeBtn];
        if ([[dic objectForKey:@"islike"]intValue]!=0) {
            [likeBtn setSelected:YES];
        }
        UILabel *likeLB=[[UILabel alloc] initWithFrame:CGRectMake(DEF_WIDTH(tableView)-175*0.5*DEF_Adaptation_Font, 35*0.5*DEF_Adaptation_Font, 100*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font)];
        likeLB.text =[dic objectForKey:@"thumbupcount"];
        likeLB.textAlignment=NSTextAlignmentRight;
        [likeLB setTextColor:[UIColor whiteColor]];
        [likeLB  setFont:[UIFont boldSystemFontOfSize:14]];
        [cell.contentView addSubview:likeLB];

        
        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(23*0.5*DEF_Adaptation_Font,19*0.5*DEF_Adaptation_Font, 54*0.5*DEF_Adaptation_Font, 54*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =54*DEF_Adaptation_Font*0.5/2;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font, 150*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font)];
        label.text =[dic objectForKey:@"nickname"];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:looperFont size:12]];
        [cell.contentView addSubview:label];
        
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(100*0.5*DEF_Adaptation_Font, 48*0.5*DEF_Adaptation_Font, 514*0.5*DEF_Adaptation_Font, 73*0.5*DEF_Adaptation_Font)];
        labelContent.text =[dic objectForKey:@"messagecontent"];
        [labelContent setTextColor:[UIColor whiteColor]];
        [labelContent setFont:[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font]];
        [cell.contentView addSubview:labelContent];
        
        
        if([dic objectForKey:@"targetid"]!=[NSNull null]){
            if([[dic objectForKey:@"targetid"] isEqualToString:[LocalDataMangaer sharedManager].uid]==true){
                int start = 0;
                int end = 0;
                NSString *content = labelContent.text;
                for (int i = 0; i < content.length; i ++) {
                    //这里的小技巧，每次只截取一个字符的范围
                    NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
                    //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
                    if ([a isEqualToString:@"@"]==true) {
                        start = i;
                    }
                    if ([a isEqualToString:@":"]==true) {
                        end = i;
                    }
                    
                }
                
                NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:labelContent.text];
                [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:12*DEF_Adaptation_Font],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(start, end)];
                //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
                labelContent.attributedText = attributeString;
            }
        
        }
        

        UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(240*0.5*DEF_Adaptation_Font, 27*0.5*DEF_Adaptation_Font, 514*0.5*DEF_Adaptation_Font, 20*0.5*DEF_Adaptation_Font)];
        labelTime.text =[dic objectForKey:@"yunxindate"];
        [labelTime setTextColor:[UIColor whiteColor]];
        [labelTime setFont:[UIFont fontWithName:looperFont size:8]];
        [cell.contentView addSubview:labelTime];

        
    }else if(indexPath.section==1){
        NSDictionary *dic = [[looperChatDicT objectForKey:@"data"] objectAtIndex:indexPath.row];
        //点赞
        UIButton *likeBtn=[LooperToolClass createBtnImageNameReal:@"btn_unfollowMusic.png" andRect:CGPointMake(DEF_WIDTH(tableView)-69*0.5*DEF_Adaptation_Font, 19*0.5*DEF_Adaptation_Font) andTag:20000+(int)indexPath.row andSelectImage:@"btn_followMusic.png" andClickImage:@"btn_followMusic.png" andTextStr:nil andSize:CGSizeMake(50*0.5*DEF_Adaptation_Font, 60*0.5*DEF_Adaptation_Font) andTarget:self];
        [cell.contentView addSubview:likeBtn];
        if ([[dic objectForKey:@"islike"]intValue]!=0) {
            [likeBtn setSelected:YES];
        }
        UILabel *likeLB=[[UILabel alloc] initWithFrame:CGRectMake(DEF_WIDTH(tableView)-175*0.5*DEF_Adaptation_Font, 35*0.5*DEF_Adaptation_Font, 100*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font)];
        likeLB.text =[dic objectForKey:@"thumbupcount"];
        likeLB.textAlignment=NSTextAlignmentRight;
        [likeLB setTextColor:[UIColor whiteColor]];
        [likeLB  setFont:[UIFont boldSystemFontOfSize:14]];
        [cell.contentView addSubview:likeLB];
    
        
        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(23*0.5*DEF_Adaptation_Font,19*0.5*DEF_Adaptation_Font, 54*0.5*DEF_Adaptation_Font, 54*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =54*DEF_Adaptation_Font*0.5/2;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font, 150*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font)];
        label.text =[dic objectForKey:@"nickname"];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:looperFont size:12]];
        [cell.contentView addSubview:label];
        
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(100*0.5*DEF_Adaptation_Font, 48*0.5*DEF_Adaptation_Font, 514*0.5*DEF_Adaptation_Font, 73*0.5*DEF_Adaptation_Font)];
        labelContent.text =[dic objectForKey:@"messagecontent"];
        [labelContent setTextColor:[UIColor whiteColor]];
        [labelContent setFont:[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font]];
        [cell.contentView addSubview:labelContent];
        
        
        if([dic objectForKey:@"targetid"]!=[NSNull null]){
            if([[dic objectForKey:@"targetid"] isEqualToString:[LocalDataMangaer sharedManager].uid]==true){
                int start = 0;
                int end = 0;
                NSString *content = labelContent.text;
                for (int i = 0; i < content.length; i ++) {
                    //这里的小技巧，每次只截取一个字符的范围
                    NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
                    //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
                    if ([a isEqualToString:@"@"]==true) {
                        start = i;
                    }
                    if ([a isEqualToString:@":"]==true) {
                        end = i;
                    }
                    
                }
                
                NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:labelContent.text];
                [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:12*DEF_Adaptation_Font],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(start, end)];
                //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
                labelContent.attributedText = attributeString;
            }
            
        }
        
    
        UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(240*0.5*DEF_Adaptation_Font, 27*0.5*DEF_Adaptation_Font, 514*0.5*DEF_Adaptation_Font, 20*0.5*DEF_Adaptation_Font)];
        labelTime.text =[dic objectForKey:@"yunxindate"];
        [labelTime setTextColor:[UIColor whiteColor]];
        [labelTime setFont:[UIFont fontWithName:looperFont size:8]];
        [cell.contentView addSubview:labelTime];
        
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}


-(int)getYWithForContentStr:(NSString*)contentStr{
    
    float num_x =0;
    NSString *perchar;
    int alength = [contentStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [contentStr characterAtIndex:i];
        NSString *temp = [contentStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x+26*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +23*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }
    }
    int num_y = num_x/(530*DEF_Adaptation_Font_x*0.5);
    
    if(num_x>(530*DEF_Adaptation_Font_x*0.5)){
        return num_y+1;
        
    }else{
        return 1;
    }
    
    return num_y+1;
}


- (void)scrollTap:(id)sender {
    [self endEditing:YES];
}


-(void)CollectionView:(int)num_y{
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,num_y+5,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-num_y-98/2) collectionViewLayout:layout];
    [_collectView registerClass:[looperChatCellViewCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    _collectView.dataSource = self;
    _collectView.delegate = self;
    _collectView.scrollsToTop =YES;
    _collectView.scrollEnabled = YES;
    _collectView.showsVerticalScrollIndicator = FALSE;
    _collectView.showsHorizontalScrollIndicator = FALSE;
    [_collectView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_collectView];
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [_collectView addGestureRecognizer:myTap];
    myTap.cancelsTouchesInView =NO;
  
    //[self addFooterAndHeader];
}


-(NSArray *)loadData:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *datas = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:datas options:0 error:nil];
    
    return dataArray;
}



-(void)addFooterAndHeader{
    
    __weak typeof(self) weakSelf = self;
    
    // 下拉加载数据的方法
    _header =  [XDRefreshHeader headerOfScrollView:_collectView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_obj getThumbUpCount:0 andPage:1];
                
                [_footer resetNoMoreData];
                [_header endRefreshing];
            });
        });
    }];
    
    [_header beginRefreshing];
    
    _footer = [XDRefreshFooter footerOfScrollView:_collectView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(maxPage>=currentPage+1){
                    currentPage = currentPage +1;
                    [_obj getThumbUpCount:1 andPage:currentPage];
                }
                [_footer endRefreshing];
            });
        });
    }];
    
}



- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
}


#pragma UICollectionViewDelegateFlowLayout 代理方法------
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"RongYunMessageContent"] forKey:@"content"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"TargetMessageContent"] forKey:@"TargetMessageContent"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"TargetName"] forKey:@"TargetName"];
    if([[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"TargetMessageContent"]==[NSNull null]){
        [dic setObject:@"1" forKey:@"type"];
    }else{
        [dic setObject:@"2" forKey:@"type"];
    }
    int num_y = 140*DEF_Adaptation_Font*0.5;
    if([[dic objectForKey:@"type"] intValue]==2){
        NSString *first = [NSString stringWithFormat:@"回复 @clarencelu:%@",dic[@"content"]];
        num_y = num_y + ([self getYWithForContentStr:first]-1)*34*DEF_Adaptation_Font*0.5;
        NSString *second = [NSString stringWithFormat:@"%@:%@",dic[@"TargetName"],dic[@"TargetMessageContent"]];
        num_y = num_y + ([self getYWithForContentStr:second])*34*DEF_Adaptation_Font*0.5 +(40*DEF_Adaptation_Font*0.5);
    }else{
        num_y = num_y + ([self getYWithForContentStr:[dic objectForKey:@"content"]]-1)*34*DEF_Adaptation_Font*0.5;
        
    }
    return CGSizeMake(DEF_SCREEN_WIDTH,num_y);
}


-(void)addPreference:(NSString*)messageId andTargetId:(NSString*)targetId andText:(NSString*)text andisLike:(int)like{
    
    [_obj addPreferenceToCommentMessageId:messageId andlike:like andTarget:targetId andMessageText:text];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.frame.origin.y<0){
        [self endEditing:true];
    }else{
        NSDictionary *dic = [[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row];
        
        if([[dic objectForKey:@"UserID"] intValue]!=[[LocalDataMangaer sharedManager].uid intValue]){
            ReplyDic = dic;
            NSLog(@"%@",ReplyDic);
            
            text.text = [NSString stringWithFormat:@"@%@:",[dic objectForKey:@"NickName"]];
            [text becomeFirstResponder];
        }else{
            text.text = @"";
        }
    }
}


//设置每个item与上左下右四个方向的间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(0,0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma UICollectionViewDataSource  代理方法----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    chatCount =[[looperChatDicT objectForKey:@"message"] count];
    
    return chatCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HomeCellView";
    looperChatCellViewCollectionViewCell * cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[looperChatCellViewCollectionViewCell alloc]init];
    }else{
        
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"HeadImageUrl"] forKey:@"head"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"NickName"] forKey:@"name"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"RongYunCreationDate"] forKey:@"time"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"RongYunMessageContent"] forKey:@"content"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"RongYunMessageID"] forKey:@"RongYunMessageID"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"ThumbUpCount"] forKey:@"zan"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"TargetMessageContent"] forKey:@"TargetMessageContent"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"TargetName"] forKey:@"TargetName"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"CurrentUserLike"] forKey:@"CurrentUserLike"];
    [dic setObject:[[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"UserID"] forKey:@"UserID"];
    
    if([[[looperChatDicT objectForKey:@"message"] objectAtIndex:indexPath.row] objectForKey:@"TargetMessageContent"]==[NSNull null]){
        [dic setObject:@"1" forKey:@"type"];
    }else{
        [dic setObject:@"2" forKey:@"type"];
    }
    [cell initCellWithData:dic and:self];
    return cell;
}


-(int)refrashHeadView{
    [headcellV removeFromSuperview];
     int num_y = 80;
    if([[looperChatDicT objectForKey:@"data"]count]!=0){
        if([[looperChatDicT objectForKey:@"data"] objectAtIndex:0]!=nil){
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"HeadImageUrl"] forKey:@"head"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"NickName"] forKey:@"name"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"RongYunCreationDate"] forKey:@"time"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"MessageContent"] forKey:@"content"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"ThumbUpCount"] forKey:@"zan"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"CurrentUserLike"] forKey:@"CurrentUserLike"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"MessageID"] forKey:@"RongYunMessageID"];
            [dic setObject:[[[looperChatDicT objectForKey:@"data"] objectAtIndex:0] objectForKey:@"UserID"] forKey:@"UserID"];
            [dic setObject:@"1" forKey:@"type"];
            num_y = 140*DEF_Adaptation_Font*0.5 + ([self getYWithForContentStr:[dic objectForKey:@"content"]]-1)*34*DEF_Adaptation_Font*0.5;
            
            headcellV = [[looperCellView alloc] initWithFrame:CGRectMake(0, 104*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, num_y) and:self];
            [headcellV createWithData:dic and:self];
            [self addSubview: headcellV];
        }
    }
    return num_y;
}


-(void)FeaturedView{
    
    int num_y = [self refrashHeadView];
    
    
    UIButton *showAll = [LooperToolClass createBtnImageNameReal:@"btn_looper_all.png" andRect:CGPointMake(250*DEF_Adaptation_Font*0.5,104*DEF_Adaptation_Font*0.5+num_y+20*DEF_Adaptation_Font*0.5) andTag:607 andSelectImage:@"btn_looper_all.png" andClickImage:@"btn_looper_all.png" andTextStr:nil andSize:CGSizeMake(140*DEF_Adaptation_Font*0.5,20*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:showAll];
    
    UIImageView *line=[LooperToolClass createImageViewReal:@"line_looper_big.png" andRect:CGPointMake(0,showAll.frame.origin.y+showAll.frame.size.height+20*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 5*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:line];
    
    [self CollectionView:line.frame.origin.y];
    
}


@end
