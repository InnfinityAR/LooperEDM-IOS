//
//  MessageView.m
//  Looper
//
//  Created by lujiawei on 29/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nMessageView.h"
#import "MessageViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"


@implementation nMessageView{

    UITableView *messageTableView;
    
    NSMutableArray *barrageArray;
    
    NSMutableArray *notifiArray;
    
    int selectNum;
    

}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MessageViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
    
}


-(void)setAllBtnUnSel{

    UIButton *btn =[self viewWithTag:2001];
    [btn setSelected:false];

    UIButton *btn1 =[self viewWithTag:2002];
    [btn1 setSelected:false];

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag==2001){
        [self setAllBtnUnSel];
        selectNum = 1;
        [button setSelected:true];
         [messageTableView reloadData];
    
    }else if(button.tag==2002){
        [self setAllBtnUnSel];
        selectNum = 2;
        [button setSelected:true];
        
        [messageTableView reloadData];
    }else if(button.tag==1999){
        

        [ _obj popController];
    
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if(selectNum==1){
        NSDictionary *dic = [barrageArray objectAtIndex:indexPath.row];
        if([[dic objectForKey:@"messagetype"] intValue]==1){
            
        }
    }else if(selectNum==2){
        NSDictionary *dic = [notifiArray objectAtIndex:indexPath.row];

        UIImageView *imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(29*DEF_Adaptation_Font*0.5, 0*DEF_Adaptation_Font*0.5,56*DEF_Adaptation_Font*0.5,56*DEF_Adaptation_Font*0.5)];
        [imageHead sd_setImageWithURL:[dic objectForKey:@"userimage"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        imageHead.layer.cornerRadius =56*DEF_Adaptation_Font*0.5/2;
        imageHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:imageHead];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(114*0.5*DEF_Adaptation_Font, 5*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
        label.text =[dic objectForKey:@"username"];
        [label setTextColor:[UIColor colorWithRed:195/255.0 green:184/255.0 blue:239/255.0 alpha:1.0]];
        [label setFont:[UIFont fontWithName:looperFont size:12]];
        [cell.contentView addSubview:label];
        
        if([[dic objectForKey:@"messagetype"] intValue]==2){
            UILabel *zanLabel = [[UILabel alloc] initWithFrame:CGRectMake(270*0.5*DEF_Adaptation_Font, 5*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
            zanLabel.text =@"赞了你的弹幕";
            [zanLabel setTextColor:[UIColor colorWithRed:189/255.0 green:191/255.0 blue:203/255.0 alpha:1.0]];
            [zanLabel setFont:[UIFont fontWithName:looperFont size:12]];
            [cell.contentView addSubview:zanLabel];
            
            if([dic objectForKey:@"messagecontent"]!=[NSNull null]){
            
            UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(114*0.5*DEF_Adaptation_Font, 35*0.5*DEF_Adaptation_Font, 500*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
            messageLabel.text = [dic objectForKey:@"messagecontent"];
            [messageLabel setTextColor:[UIColor colorWithRed:189/255.0 green:191/255.0 blue:203/255.0 alpha:1.0]];
            [messageLabel setFont:[UIFont fontWithName:looperFont size:12]];
            [cell.contentView addSubview:messageLabel];
            }

        }else if([[dic objectForKey:@"messagetype"] intValue]==3){
            UILabel *zanLabel = [[UILabel alloc] initWithFrame:CGRectMake(270*0.5*DEF_Adaptation_Font, 5*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
            zanLabel.text =@"分享你的loop到微信";
            [zanLabel setTextColor:[UIColor colorWithRed:189/255.0 green:191/255.0 blue:203/255.0 alpha:1.0]];
            [zanLabel setFont:[UIFont fontWithName:looperFont size:12]];
            [cell.contentView addSubview:zanLabel];

            
        }else if([[dic objectForKey:@"messagetype"] intValue]==4){
            UILabel *zanLabel = [[UILabel alloc] initWithFrame:CGRectMake(270*0.5*DEF_Adaptation_Font, 5*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
            zanLabel.text =@"收藏了你的loop";
            [zanLabel setTextColor:[UIColor colorWithRed:189/255.0 green:191/255.0 blue:203/255.0 alpha:1.0]];
            [zanLabel setFont:[UIFont fontWithName:looperFont size:12]];
            [cell.contentView addSubview:zanLabel];

            
        }else if([[dic objectForKey:@"messagetype"] intValue]==5){
            UILabel *zanLabel = [[UILabel alloc] initWithFrame:CGRectMake(270*0.5*DEF_Adaptation_Font, 5*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
            zanLabel.text =@"关注了你";
            [zanLabel setTextColor:[UIColor colorWithRed:189/255.0 green:191/255.0 blue:203/255.0 alpha:1.0]];
            [zanLabel setFont:[UIFont fontWithName:looperFont size:12]];
            [cell.contentView addSubview:zanLabel];
        }
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selectNum==1){
         return  218*DEF_Adaptation_Font*0.5;
    }else if(selectNum==2){
         return  120*DEF_Adaptation_Font*0.5;
        
    }
     return  0;
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(selectNum==1){
        return  [barrageArray count];
    }else if(selectNum==2){
        return  [notifiArray count];
    }
    return 0;
}

-(void)createTableView{
    selectNum = 1;
    messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 197*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 941*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
    messageTableView.dataSource = self;
    messageTableView.delegate = self;
    [self addSubview:messageTableView];
    [messageTableView setBackgroundColor:[UIColor clearColor]];
    messageTableView.separatorStyle = NO;
}


-(void)CollateData{
    
    for (int i=0;i<[[[_obj messageData] objectForKey:@"data"] count];i++){
        NSDictionary *dic = [[[_obj messageData] objectForKey:@"data"] objectAtIndex:i];
        if([[dic objectForKey:@"messagetype"] intValue]==1){
            [barrageArray addObject:dic];
        }else{
            [notifiArray addObject:dic];
        }
    }
}


-(void)initView{

    barrageArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    notifiArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    
    [self CollateData];
    
    
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    
    UIButton *backBtn =[LooperToolClass createBtnImageName:@"btn_looper_back.png" andRect:CGPointMake(15, 65) andTag:1999 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: backBtn];
    
    UILabel *title = [LooperToolClass createLableView:CGPointMake(247*DEF_Adaptation_Font_x*0.5, 59*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(160*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"我的消息" andFontSize:13 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:title];
    
    UIButton *barrageBtn =[LooperToolClass createBtnImageName:@"barrage.png" andRect:CGPointMake(149, 101) andTag:2001 andSelectImage:@"unbarrage.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: barrageBtn];
    
    UIButton *messageBtn =[LooperToolClass createBtnImageName:@"notify.png" andRect:CGPointMake(362, 101) andTag:2002 andSelectImage:@"unNotify.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: messageBtn];
    
    [self createTableView];
    
}


@end
