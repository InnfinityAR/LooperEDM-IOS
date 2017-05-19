//
//  PhoneView.m
//  Looper
//
//  Created by lujiawei on 1/3/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhoneView.h"
#import "PhoneViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "XDRefresh.h"
@implementation PhoneView{
    
    UIButton *backBtn;
    UIButton *meBtn;
    UIButton *inboxBtn;
    UIButton *commentBtn;
    UIButton *noticeBtn;
    UIImageView *lineView;
    
    UIButton *messageBtn;
    UIButton *ContactBtn;
    
    UIButton *followBtn;
    UIButton *fansBtn;
    UIImageView *maxLineView;
    
    NSDictionary *_fanFollowData;
    NSMutableArray *_messageData;
    NSDictionary *_sourceData;
    
    
    NSMutableArray *_tableArray;
    
    UITableView *tableView;
    
    XDRefreshHeader *_header;
    XDRefreshFooter *_footer;
    
    UILabel *labelNotification;
    
    
    UILabel * labelReplay;
    
    int selectBtnTag;
    
    
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (PhoneViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
}


-(void)initWithData:(NSDictionary*)fansFollowData andMessageData:(NSMutableArray*)messageData{
    
    _fanFollowData =[[NSMutableDictionary alloc] initWithCapacity:50];
    _messageData =[[NSMutableArray alloc] initWithCapacity:50];
    _tableArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    [self createTableView];
    
}


-(void)createActionView{
    
    [labelNotification removeFromSuperview];
    [labelReplay removeFromSuperview];
    
    if([[_sourceData objectForKey:@"NotificationCount"] intValue]!=0){
        labelNotification = [[UILabel alloc] initWithFrame:CGRectMake(574*0.5*DEF_Adaptation_Font, 109*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font)];
        labelNotification.font = [UIFont fontWithName:looperFont size:12*0.5*DEF_Adaptation_Font];
        labelNotification.text=[_sourceData objectForKey:@"NotificationCount"];
        labelNotification.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        [labelNotification setBackgroundColor:[UIColor colorWithRed:255/255.0 green:56/255.0 blue:56/255.0 alpha:1.0]];
        labelNotification.textAlignment =  NSTextAlignmentCenter;
        labelNotification.layer.cornerRadius=25*0.5*DEF_Adaptation_Font/2;
        labelNotification.layer.masksToBounds = YES;
        [self addSubview:labelNotification];
        
    }
    
    if([[_sourceData objectForKey:@"ReplayCount"] intValue]!=0){
        labelReplay = [[UILabel alloc] initWithFrame:CGRectMake(418*0.5*DEF_Adaptation_Font, 109*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font)];
        labelReplay.font = [UIFont fontWithName:looperFont size:12*0.5*DEF_Adaptation_Font];
        labelReplay.text=[_sourceData objectForKey:@"ReplayCount"];
        labelReplay.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        [labelReplay setBackgroundColor:[UIColor colorWithRed:255/255.0 green:56/255.0 blue:56/255.0 alpha:1.0]];
        labelReplay.textAlignment =  NSTextAlignmentCenter;
        labelReplay.layer.cornerRadius=25*0.5*DEF_Adaptation_Font/2;
        labelReplay.layer.masksToBounds = YES;
        [self addSubview:labelReplay];
    }
}




-(void)updataData:(NSDictionary*)fansFollowData andMessageData:(NSMutableArray*)messageData andSourceData:(NSDictionary*)sourceData{
    _fanFollowData =fansFollowData;
    _messageData =messageData;
    _sourceData = sourceData;
    
    [self createActionView];

}


-(void)setUnAllBtn{
    [meBtn setSelected:false];
    [inboxBtn setSelected:false];;
    [commentBtn setSelected:false];;
    [noticeBtn setSelected:false];;
}

-(void)phoneViewWithTag:(int)tag{
    if(tag==100){
        _tableArray = [[NSMutableArray alloc] initWithCapacity:50];
        [tableView reloadData];
    
    }else if(tag==101){
        _tableArray = [[NSMutableArray alloc] initWithCapacity:50];
        [tableView reloadData];
    }else if(tag==102){
        [_obj readMessage:3];
        
        _tableArray = [[NSMutableArray alloc] initWithCapacity:50];
        for (NSDictionary *data in _messageData){
            if([[data objectForKey:@"MessageType"] intValue]==3 ){
                
                [_tableArray addObject:data];
            }
        }

        [tableView reloadData];
        
    }else if(tag==103){
        
        [_obj readMessage:1];
        [_obj readMessage:2];
        
          _tableArray = [[NSMutableArray alloc] initWithCapacity:50];
        for (NSDictionary *data in _messageData){
            if([[data objectForKey:@"MessageType"] intValue]==1 ||[[data objectForKey:@"MessageType"] intValue]==2 ){
            
                [_tableArray addObject:data];
            }
        }
    }
    [tableView reloadData];
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
     selectBtnTag = button.tag;
    
    if(button.tag ==100){
        [self setUnAllBtn];
        [meBtn setSelected:true];
        [self moveLine:button.tag];
    }else if(button.tag == 101){
        [self setUnAllBtn];
        [inboxBtn setSelected:true];
        [self moveLine:button.tag];
        
    }else if(button.tag ==102){
        [labelReplay removeFromSuperview];
        [self setUnAllBtn];
        [commentBtn setSelected:true];
        [self moveLine:button.tag];
        
    }else if(button.tag == 103){
        [labelNotification removeFromSuperview];
        [self setUnAllBtn];
        [noticeBtn setSelected:true];
        [self moveLine:button.tag];
        
    }else if(button.tag == 120){
        [messageBtn setSelected:true];
        [ContactBtn setSelected:false];
        [self removeALLBtn];
        [self createHudBtn];
        _tableArray = [[NSMutableArray alloc] initWithCapacity:50];
        [tableView reloadData];
    }else if(button.tag == 121){
        [messageBtn setSelected:false];
        [ContactBtn setSelected:true];
        [self removeALLBtn];
        [self createBtnFansAndFollow];
        _tableArray = [_fanFollowData objectForKey:@"follow"];
        [tableView reloadData];
    }else if(button.tag == 130){
        _tableArray = [_fanFollowData objectForKey:@"follow"];
        [followBtn setSelected:true];
        [fansBtn setSelected:false];
        [self moveLine:button.tag];
        [tableView reloadData];
    }else if(button.tag == 131){
        _tableArray = [_fanFollowData objectForKey:@"fans"];
        [followBtn setSelected:false];
        [fansBtn setSelected:true];
        [self moveLine:button.tag];
        [tableView reloadData];
    }else if(button.tag == 500){
        [self removeAllAction];
        [_obj popController];
    }
    
    [self phoneViewWithTag:button.tag];
}

-(void)removeAllAction{

    [self removeALLBtn];
    _header=nil;
    _footer=nil;
    [tableView removeFromSuperview];



}



-(void)moveLine:(int)Tag{
    
    NSNumber *num;
    if(Tag==100){
        num=[NSNumber numberWithFloat:0];
    }else if(Tag==101){
        num=[NSNumber numberWithFloat:162.0f*DEF_Adaptation_Font*0.5];
    }else if(Tag==102){
        num=[NSNumber numberWithFloat:320.0f*DEF_Adaptation_Font*0.5];
    }else if(Tag==103){
        num=[NSNumber numberWithFloat:478.0f*DEF_Adaptation_Font*0.5];
    }else if(Tag==130){
        num=[NSNumber numberWithFloat:0];
    }else if(Tag==131){
        num=[NSNumber numberWithFloat:320.0f*DEF_Adaptation_Font*0.5];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath : @"transform.translation.x" ]; ///.y 的话就向下移动。
    animation. toValue = num;
    
    animation. duration = 0.2;
    
    animation. removedOnCompletion = NO ; //yes 的话，又返回原位置了。
    
    animation. fillMode = kCAFillModeForwards ;
    if(Tag>=130){
        [maxLineView.layer  addAnimation:animation forKey:nil];
    }else{
        [lineView.layer  addAnimation:animation forKey:nil];
    }
}


-(void)removeALLBtn{
    [meBtn removeFromSuperview];
    [inboxBtn removeFromSuperview];
    [commentBtn removeFromSuperview];
    [noticeBtn removeFromSuperview];
    [lineView removeFromSuperview];
    [followBtn removeFromSuperview];
    [fansBtn removeFromSuperview];
    [maxLineView removeFromSuperview];
}


-(void)createHudBtn{
    
    meBtn =[LooperToolClass createBtnImageName:@"btn_phone_me.png" andRect:CGPointMake(4, 108) andTag:100 andSelectImage:@"btn_phone_unMe.png" andClickImage:@"btn_phone_me.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:meBtn];
    inboxBtn =[LooperToolClass createBtnImageName:@"btn_phone_Inbox.png" andRect:CGPointMake(162, 108) andTag:101 andSelectImage:@"btn_phone_unInbox.png" andClickImage:@"btn_phone_Inbox.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:inboxBtn];
    commentBtn =[LooperToolClass createBtnImageName:@"btn_phone_Comment.png" andRect:CGPointMake(320, 108) andTag:102 andSelectImage:@"btn_phone_unComment.png" andClickImage:@"btn_phone_Comment.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:commentBtn];
    noticeBtn =[LooperToolClass createBtnImageName:@"btn_phone_Notice.png" andRect:CGPointMake(478, 108) andTag:103 andSelectImage:@"btn_phone_unNotice.png" andClickImage:@"btn_phone_Notice.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:noticeBtn];
    
    
    UIImageView* lineBk = [LooperToolClass createImageView:@"bg_phone_bLine.png" andRect:CGPointMake(4, 156) andTag:110 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineBk];
    
    lineView = [LooperToolClass createImageView:@"line_phone.png" andRect:CGPointMake(4, 156) andTag:110 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineView];
    
    [meBtn setSelected:true];
}

-(void)addFooterAndHeader{
    
    __weak typeof(self) weakSelf = self;
    
    // 下拉加载数据的方法
    _header =  [XDRefreshHeader headerOfScrollView:tableView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello");
                [_footer resetNoMoreData];
                [_header endRefreshing];
            });
        });
    }];
    
    [_header beginRefreshing];
    
    _footer = [XDRefreshFooter footerOfScrollView:tableView refreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"hello2");
                
                [_footer endRefreshing];
            });
        });
    }];
    
}



-(void)createBtnFansAndFollow{
    
    followBtn =[LooperToolClass createBtnImageName:@"btn_phone_unfollow.png" andRect:CGPointMake(0, 108) andTag:130 andSelectImage:@"btn_phone_follow.png" andClickImage:@"btn_phone_unfollow.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    
    [self addSubview:followBtn];
    
    fansBtn =[LooperToolClass createBtnImageName:@"btn_phone_unfans.png" andRect:CGPointMake(320, 108) andTag:131 andSelectImage:@"btn_phone_fans.png" andClickImage:@"btn_phone_unfans.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:fansBtn];
    
    [followBtn setSelected:true];
    
    maxLineView = [LooperToolClass createImageView:@"bg_phone_line.png" andRect:CGPointMake(4, 156) andTag:110 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:maxLineView];
    
}

-(void)createDownHudBtn{
    messageBtn = [LooperToolClass createBtnImageName:@"btn_phone_unmessage.png" andRect:CGPointMake(0, 1060) andTag:120 andSelectImage:@"btn_phone_message.png" andClickImage:@"btn_phone_message.png" andTextStr:nil andSize:CGSizeZero andTarget:self ];
    
    [self addSubview:messageBtn];
    ContactBtn = [LooperToolClass createBtnImageName:@"btn_phone_unContact.png" andRect:CGPointMake(320, 1060) andTag:121 andSelectImage:@"btn_phone_Contact.png" andClickImage:@"btn_phone_Contact.png" andTextStr:nil andSize:CGSizeZero andTarget:self ];
    [self addSubview:ContactBtn];
    [messageBtn setSelected:true];
}


-(void)initView{
    selectBtnTag = 100;
    backBtn =[LooperToolClass createBtnImageName:@"btn_phone_back.png" andRect:CGPointMake(32, 52) andTag:500 andSelectImage:@"btn_phone_back.png" andClickImage:@"btn_phone_back.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:backBtn];
    [self setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:35.0/255.0 alpha:1.0]];
    [self createHudBtn];
    [self createDownHudBtn];
    
}


-(void)createTableView{
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 165*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, 890*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
    [self addFooterAndHeader];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [_tableArray objectAtIndex:indexPath.row];
    NSLog(@"%@",dic);
    
    [_obj JumpToSimpleChat:dic];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(selectBtnTag==121 ||selectBtnTag==130||selectBtnTag==131){
    
         return  90*DEF_Adaptation_Font*0.5;
        
    }else if(selectBtnTag==103){
    
         return  110*DEF_Adaptation_Font*0.5;
    }else if(selectBtnTag==102){
        
        return  171*DEF_Adaptation_Font*0.5;
    }
    return 0;

}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableArray count];
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
    
    if(selectBtnTag==121 ||selectBtnTag==130||selectBtnTag==131){
        UIImageView *imageHeadV = [[UIImageView alloc] initWithFrame:CGRectMake(30*0.5*DEF_Adaptation_Font,10*0.5*DEF_Adaptation_Font, 70*0.5*DEF_Adaptation_Font,70*0.5*DEF_Adaptation_Font)];
        [imageHeadV sd_setImageWithURL:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"HeadImageUrl"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        imageHeadV.layer.cornerRadius = 34*0.5*DEF_Adaptation_Font;
        imageHeadV.layer.masksToBounds = YES;
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(120*DEF_Adaptation_Font_x*0.5, 30*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"NickName"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:titleNum];
          [cell.contentView addSubview:imageHeadV];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
  
    }else if(selectBtnTag==103){
        UIImageView *imageHeadV = [[UIImageView alloc] initWithFrame:CGRectMake(12*0.5*DEF_Adaptation_Font,16*0.5*DEF_Adaptation_Font, 76*0.5*DEF_Adaptation_Font,76*0.5*DEF_Adaptation_Font)];
        [imageHeadV sd_setImageWithURL:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"HeadImageUrl"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        imageHeadV.layer.cornerRadius = 38*0.5*DEF_Adaptation_Font;
        imageHeadV.layer.masksToBounds = YES;
        [cell.contentView addSubview:imageHeadV];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(101*DEF_Adaptation_Font_x*0.5, 23*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"NickName"] andFontSize:12 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:titleNum];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
        
        
        UILabel *zanLable = [LooperToolClass createLableView:CGPointMake(255*DEF_Adaptation_Font_x*0.5, 23*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"NickName"] andFontSize:12 andColor:[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:zanLable];
        
        if([[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"MessageType"] intValue]==1){
            zanLable.text = @"赞了你的发言";
            
            UILabel *contentV = [LooperToolClass createLableView:CGPointMake(101*DEF_Adaptation_Font_x*0.5, 60*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(400*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"MessageContent"] andFontSize:10 andColor:[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
            [cell.contentView addSubview:contentV];

            
        }else{
             zanLable.text = @"成为了你的粉丝";
        }
        
        UIImageView *bk=[LooperToolClass createImageViewReal:@"line_looper_chat.png" andRect:CGPointMake(109*DEF_Adaptation_Font_x*0.5,109*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 2*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
        [bk setAlpha:0.8];
        [cell.contentView addSubview:bk];
    }else if(selectBtnTag==102){
        UIImageView *imageHeadV = [[UIImageView alloc] initWithFrame:CGRectMake(12*0.5*DEF_Adaptation_Font,16*0.5*DEF_Adaptation_Font, 76*0.5*DEF_Adaptation_Font,76*0.5*DEF_Adaptation_Font)];
        [imageHeadV sd_setImageWithURL:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"HeadImageUrl"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        imageHeadV.layer.cornerRadius = 38*0.5*DEF_Adaptation_Font;
        imageHeadV.layer.masksToBounds = YES;
        [cell.contentView addSubview:imageHeadV];
        
        UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(100*DEF_Adaptation_Font_x*0.5, 22*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"NickName"] andFontSize:12 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:titleNum];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];

        UILabel *timeNum = [LooperToolClass createLableView:CGPointMake(100*DEF_Adaptation_Font_x*0.5, 50*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"CreationDate"] andFontSize:9 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:timeNum];

        UILabel *replayNum = [LooperToolClass createLableView:CGPointMake(100*DEF_Adaptation_Font_x*0.5, 86*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(500*DEF_Adaptation_Font_x*0.5, 28*DEF_Adaptation_Font_x*0.5) andText:[[_tableArray objectAtIndex:indexPath.row] objectForKey:@"MessageContent"] andFontSize:12 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [cell.contentView addSubview:replayNum];

        UIImageView *bk=[LooperToolClass createImageViewReal:@"line_looper_chat.png" andRect:CGPointMake(0*DEF_Adaptation_Font_x*0.5,170*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 2*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
        [bk setAlpha:0.8];
        [cell.contentView addSubview:bk];
        
    
    
    }
    return cell;
}







@end
