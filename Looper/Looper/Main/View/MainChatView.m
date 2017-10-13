//
//  MainChatView.m
//  Looper
//
//  Created by lujiawei on 3/28/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MainChatView.h"
#import "nMainView.h"
#import "LooperConfig.h"
#import "TouchScrollView.h"
#import "TouchTableView.h"
#import "MainViewModel.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "RongCloudManger.h"
#import "LooperScorllLayer.h"

@implementation MainChatView
{
    TouchScrollView *srollview;
    TouchTableView *tableView1;
    
    CGPoint startPoint;
    CGPoint movePoint;
    
    NSArray *loopArray;
    
    
    
    int selectIndexNum;
    int selectIndex;
    UITableViewCell *moveViewCell;
    BOOL isfristTouch;
    
    UIButton *chatBtn;
    UIButton *loopBtn;
    UIButton *communityBtn;
    UIImageView* moveline;
    UIImageView* communityImage;
    
    BOOL isEnd;


}
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andLoopData:(NSDictionary*)loopData
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (nMainView*)idObject;
        [self initView:loopData];
       
       

    }
    return self;
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    if(button.tag==900){
        [loopBtn setSelected:false];
        [chatBtn setSelected:true];
        selectIndexNum =2;
        [tableView1 reloadData];
        
        if([[[RongCloudManger sharedManager] getSessionArray]count]>0){
            communityImage.hidden=true;
            communityBtn.hidden=true;
        }else{
            [communityBtn setHidden:false];
            [communityImage setHidden:false];
        
        }
        [UIView animateWithDuration:0.5 animations:^{
            
            moveline.frame =CGRectMake(393*0.5*DEF_Adaptation_Font, 148*0.5*DEF_Adaptation_Font, moveline.frame.size.width, moveline.frame.size.height);
        }];
    }else if(button.tag==901){
        [chatBtn setSelected:false];
        [loopBtn setSelected:true];
        selectIndexNum =1;
        [tableView1 reloadData];
        [communityBtn setHidden:true];
        [communityImage setHidden:true];
        [UIView animateWithDuration:0.5 animations:^{
            
            moveline.frame =CGRectMake(206*0.5*DEF_Adaptation_Font, 148*0.5*DEF_Adaptation_Font, moveline.frame.size.width, moveline.frame.size.height);
        }];
        
    }
    [_obj MainChatEvent:button.tag];
}

-(void)updataLoopFollowData:(NSDictionary *)loopData{

    loopArray = [[NSArray alloc] initWithArray:[loopData objectForKey:@"FollowLoop"]];
    [tableView1 reloadData];
}


-(void)initView:(NSDictionary*)loopData{
    selectIndexNum=2;

    UIView *bkV = [[UIView alloc] initWithFrame:CGRectMake(0, 101*0.5*DEF_Adaptation_Font, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    bkV.layer.cornerRadius = 16*DEF_Adaptation_Font*0.5;
    [bkV setBackgroundColor:[UIColor colorWithRed:56/255.0 green:49/255.0 blue:82/255.0 alpha:1.0]];
    [self addSubview:bkV];
    
    UIButton *serach =[LooperToolClass createBtnImageName:@"chatlist_serach.png" andRect:CGPointMake(0, 31) andTag:SearchBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: serach];
    
    UIButton *back =[LooperToolClass createBtnImageName:@"chatlist_back.png" andRect:CGPointMake(555, 32) andTag:mainChatBackTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    
    chatBtn =[LooperToolClass createBtnImageName:@"btn_selchat.png" andRect:CGPointMake(355, 101) andTag:900 andSelectImage:@"btn_unchat.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: chatBtn];
    
    loopBtn =[LooperToolClass createBtnImageName:@"btn_selLoop.png" andRect:CGPointMake(167, 101) andTag:901 andSelectImage:@"btn_unLoop.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:loopBtn];
    [chatBtn setSelected:true];
    
    moveline=[LooperToolClass createImageView:@"moveline.png" andRect:CGPointMake(393, 148) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:moveline];
    
    [self createListView];
    [self updataLoopFollowData:loopData];
    
    if([[[RongCloudManger sharedManager] getSessionArray]count]==0){
        communityImage=[LooperToolClass createImageView:@"bg_TextChat.png" andRect:CGPointMake(134, 377) andTag:100 andSize:CGSizeMake(382*DEF_Adaptation_Font_x*0.5, 100*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [self addSubview:communityImage];

        communityBtn =[LooperToolClass createBtnImageName:@"btn_community.png" andRect:CGPointMake(160, 612) andTag:9008 andSelectImage:@"btn_community.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
        [self addSubview: communityBtn];
    }
}

-(void)createListView{
    tableView1 = [[TouchTableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 195*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-195*0.5*DEF_Adaptation_Font) style:UITableViewStylePlain];
    tableView1.touchDelegate = self;
    tableView1.delegate=self;
    tableView1.dataSource=self;
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView1.backgroundColor = [UIColor clearColor];
    tableView1.delaysContentTouches=NO;
    [self addSubview:tableView1];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selectIndexNum==1){
        
        if(self.frame.origin.x==0){
            if(isEnd==false){
                [_obj toLoopView:[loopArray objectAtIndex:indexPath.row]];
            }

        }
    }else if(selectIndexNum==2){
        if(self.frame.origin.x==0){
            if(isEnd==false){
                //NIMRecentSession *session = (NIMRecentSession*)[[[NIMCloudMander sharedManager]getSessionArray] objectAtIndex:indexPath.row];
                  RCConversation *session = (RCConversation*)[[[RongCloudManger sharedManager]getSessionArray] objectAtIndex:indexPath.row];
                [_obj chatView:session.targetId];

            }
            
        }
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(selectIndexNum==1){
        return  160*DEF_Adaptation_Font*0.5;
    }else if(selectIndexNum==2){
        return  100*DEF_Adaptation_Font*0.5;
    }
    return 0;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(selectIndexNum==1){
        return 0;
    }else if(selectIndexNum==2){
        
        if([[[RongCloudManger sharedManager] getSessionArray]count]>0){
            communityImage.hidden=true;
            communityBtn.hidden=true;
        }
        
        
        return [[[RongCloudManger sharedManager] getSessionArray]count];
    }
    return 0;
}


- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
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
    
    if(selectIndexNum==1){

        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(31*0.5*DEF_Adaptation_Font,10*0.5*DEF_Adaptation_Font, 111*0.5*DEF_Adaptation_Font, 111*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString:[[loopArray objectAtIndex:indexPath.row] objectForKey:@"loopcover"]] placeholderImage:[UIImage imageNamed:@"btn_looper.png"]options:SDWebImageRetryFailed];
        loopHead.layer.cornerRadius =12*DEF_Adaptation_Font*0.5;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(170*0.5*DEF_Adaptation_Font, 10*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font)];
        label.text =[[loopArray objectAtIndex:indexPath.row] objectForKey:@"looptitle"];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:looperFont size:17]];
        [cell.contentView addSubview:label];

        UIImageView* line=[LooperToolClass createImageView:@"chatline.png" andRect:CGPointMake(32, 150) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
        
        [cell.contentView addSubview:line];
        if([[loopArray objectAtIndex:indexPath.row] objectForKey:@"news_tag"]!=[NSNull null]){
            
            LooperScorllLayer *sildeV = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(160*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5, 470*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5) and:self];
            [cell.contentView addSubview:sildeV];
            
            [sildeV initView:CGRectMake(0,0, 470*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5) andStr:[[[loopArray objectAtIndex:indexPath.row] objectForKey:@"news_tag"] componentsSeparatedByString:@","] andType:1];
        }
        
    }else if(selectIndexNum==2){
        
        NSLog(@"%@",[[RongCloudManger sharedManager] getSessionArray]);
        
        RCConversation *session = (RCConversation*)[[[RongCloudManger sharedManager]getSessionArray] objectAtIndex:indexPath.row];
        

        [[RongCloudManger sharedManager] getUserData:session.targetId success:^(id responseObject){
        
            UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(20*0.5*DEF_Adaptation_Font,16*0.5*DEF_Adaptation_Font, 74*0.5*DEF_Adaptation_Font, 74*0.5*DEF_Adaptation_Font)];
            [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString:[responseObject objectForKey:@"headimageurl"]] placeholderImage:[UIImage imageNamed:@"btn_looper.png"]options:SDWebImageRetryFailed];
            loopHead.layer.cornerRadius =74*DEF_Adaptation_Font*0.5*0.5;
            loopHead.layer.masksToBounds = YES;
            [cell.contentView addSubview:loopHead];
            
            UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(131*0.5*DEF_Adaptation_Font, 26*0.5*DEF_Adaptation_Font, 480*0.5*DEF_Adaptation_Font, 27*0.5*DEF_Adaptation_Font)];
            [labelName setTextColor:[UIColor whiteColor]];
            labelName.text =[responseObject objectForKey:@"nickname"];
            
            [labelName setFont:[UIFont fontWithName:looperFont size:16]];
            [cell.contentView addSubview:labelName];
            
            UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(131*0.5*DEF_Adaptation_Font, 65*0.5*DEF_Adaptation_Font, 480*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font)];
            [labelText setTextColor:[UIColor colorWithRed:117/255.0 green:118/255.0 blue:148/255.0 alpha:1.0]];
            
            RCTextMessage *message  =(RCTextMessage *)session.lastestMessage;
            
            labelText.text =message.content;
            
            [labelText setFont:[UIFont fontWithName:looperFont size:14]];
            [cell.contentView addSubview:labelText];
            UIImageView* line=[LooperToolClass createImageView:@"chatline.png" andRect:CGPointMake(32, 100) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
            
            [cell.contentView addSubview:line];
            
            UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(460*0.5*DEF_Adaptation_Font, 30*0.5*DEF_Adaptation_Font, 200*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font)];
            [labelTime setTextColor:[UIColor colorWithRed:117/255.0 green:118/255.0 blue:148/255.0 alpha:1.0]];
            labelTime.text =[self timeWithTimeIntervalString:[NSString stringWithFormat:@"%lld", session.sentTime]];
           
            
            [labelTime setFont:[UIFont fontWithName:looperFont size:11]];
            [cell.contentView addSubview:labelTime];
        }];
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event{
        isEnd =true;
    [self touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    startPoint = point;
    movePoint= point;
    isfristTouch=true;
    
}

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if(isEnd==true){
        isEnd=false;
        [self touchesEnded:touches withEvent:event];

        //[self moveViewCell];
    }

}

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    if(moveViewCell==nil){
        
        if(isfristTouch==true){
            if(startPoint.x<point.x){
                float num_y= point.y-195*0.5*DEF_Adaptation_Font;
                float num = (num_y+tableView.contentOffset.y)/(160*DEF_Adaptation_Font*0.5);
                int selectNum=(int)ceil(num);
                selectNum= selectNum-1;
                selectIndex=selectNum;
                UITableViewCell *cell = [tableView1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
                moveViewCell = cell;
                isfristTouch=false;
            }else{
                [tableView1 setScrollEnabled:false];
                [self touchesMoved:touches withEvent:event];
                isfristTouch=false;
            }
        }else{
            [tableView1 setScrollEnabled:false];
            [self touchesMoved:touches withEvent:event];
        }
        
    }else{
        [tableView1 setScrollEnabled:false];
       // moveViewCell.frame = CGRectMake(moveViewCell.frame.origin.x-(movePoint.x-point.x), moveViewCell.frame.origin.y, moveViewCell.frame.size.width, moveViewCell.frame.size.height);
    }
    movePoint =point;
    
}


- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
}


-(void)moveViewCell{
    [tableView1 setScrollEnabled:true];
    if(moveViewCell!=nil){
        if(moveViewCell.frame.origin.x>DEF_SCREEN_WIDTH/2){
            [UIView animateWithDuration:0.2 animations:^{
                moveViewCell.frame= CGRectMake(DEF_SCREEN_WIDTH, moveViewCell.frame.origin.y, moveViewCell.frame.size.width, moveViewCell.frame.size.height);
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                moveViewCell.frame= CGRectMake(0, moveViewCell.frame.origin.y, moveViewCell.frame.size.width, moveViewCell.frame.size.height);
            }];
        }
    }
    moveViewCell=nil;

}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [srollview setContentOffset:CGPointMake(0, srollview.contentOffset.y) animated:NO];
    [_obj touchesBegan:touches withEvent:event];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [_obj touchesMoved:touches withEvent:event];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [_obj touchesEnded:touches withEvent:event];
}





@end
