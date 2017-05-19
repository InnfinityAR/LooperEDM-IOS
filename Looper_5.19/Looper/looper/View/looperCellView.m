//
//  looperCellView.m
//  Looper
//
//  Created by lujiawei on 1/24/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperCellView.h"
#import "looperChatView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "DataHander.h"
#import "looperChatView.h"

@implementation looperCellView
{

    UIButton *zanBtn;
    NSDictionary *loopChatCellData;
    id vmobj;
    UILabel *zanNum;

}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperChatView*)idObject;
        
    }
    return self;
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
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{

    if(button.tag == 600){
        if([zanBtn isSelected]==true){
            [zanBtn setSelected:false];
            
            zanNum.text = [NSString stringWithFormat:@"%d",[zanNum.text intValue]-1];
             [(looperChatView*)vmobj addPreference:loopChatCellData[@"RongYunMessageID"] andTargetId:loopChatCellData[@"UserID"] andText:loopChatCellData[@"content"] andisLike:2];
            
        }else{
            [zanBtn setSelected:true];
             zanNum.text = [NSString stringWithFormat:@"%d",[zanNum.text intValue]+1];
            [(looperChatView*)vmobj addPreference:loopChatCellData[@"RongYunMessageID"] andTargetId:loopChatCellData[@"UserID"] andText:loopChatCellData[@"content"] andisLike:1];
        }
    }
}

-(void)createWithData:(NSDictionary*)cellData and:(id)obj{
    
    vmobj = obj;
    loopChatCellData = cellData;
 
    
    UIView *headView = [LooperToolClass createViewAndRect:CGPointMake(14, 20) andTag:100 andSize:CGSizeMake(53*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:cellData[@"head"]];
    [self addSubview:headView];
    
    UILabel *name = [LooperToolClass createLableView:CGPointMake(81*DEF_Adaptation_Font_x*0.5, 20*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(225*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:cellData[@"name"] andFontSize:13 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:name];
    
    UILabel *time = [LooperToolClass createLableView:CGPointMake(81*DEF_Adaptation_Font_x*0.5, 54*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(200*DEF_Adaptation_Font_x*0.5, 14*DEF_Adaptation_Font_x*0.5) andText:cellData[@"time"] andFontSize:8 andColor:[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:time];
    
    zanNum = [LooperToolClass createLableView:CGPointMake(531*DEF_Adaptation_Font_x*0.5, 43*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(60*DEF_Adaptation_Font_x*0.5, 18*DEF_Adaptation_Font_x*0.5) andText:cellData[@"zan"] andFontSize:11 andColor:[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [self addSubview:zanNum];
    
    

    zanBtn = [LooperToolClass createBtnImageNameReal:@"btn_unzan.png" andRect:CGPointMake(585*DEF_Adaptation_Font_x*0.5, 23*DEF_Adaptation_Font_x*0.5) andTag:600 andSelectImage:@"btn_zan.png" andClickImage:@"btn_zan.png" andTextStr:nil andSize:CGSizeMake(56*DEF_Adaptation_Font_x*0.5,53*DEF_Adaptation_Font_x*0.5) andTarget:self];
    [self addSubview:zanBtn];
    
    if([cellData[@"CurrentUserLike"] intValue]==0){
         [zanBtn setSelected:false];
    }else{
        [zanBtn setSelected:true];
    }

    UILabel *content;
    if([cellData[@"type"] intValue]==2){
        
        NSString *first = [NSString stringWithFormat:@"回复 %@",cellData[@"content"]];
         int num_y=[self getYWithForContentStr:first];
       content = [LooperToolClass createLableView:CGPointMake(81*DEF_Adaptation_Font_x*0.5, 86*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(530*DEF_Adaptation_Font_x*0.5, 34*DEF_Adaptation_Font_x*0.5*num_y) andText:first andFontSize:12 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        content.numberOfLines = 0;
        [self addSubview:content];
        
        
        
        NSString *second = [NSString stringWithFormat:@"@%@:%@",cellData[@"TargetName"],cellData[@"TargetMessageContent"]];
         int second_num_y=[self getYWithForContentStr:second] ;
        UIView *frame=[LooperToolClass createFrameView:CGPointMake(81*DEF_Adaptation_Font_x*0.5, content.frame.origin.y+content.frame.size.height+20*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(530*DEF_Adaptation_Font_x*0.5, 34*DEF_Adaptation_Font_x*0.5*second_num_y+40*DEF_Adaptation_Font_x*0.5) andFrameWide:1 andRadius:2];
        [self addSubview:frame];
        
        
         UILabel* secondContent = [LooperToolClass createLableView:CGPointMake(13*DEF_Adaptation_Font_x*0.5, 20*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(510*DEF_Adaptation_Font_x*0.5, 34*DEF_Adaptation_Font_x*0.5*second_num_y) andText:second andFontSize:12 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
         [frame addSubview:secondContent];
          secondContent.numberOfLines = 0;
        
        UIImageView *bk=[LooperToolClass createImageViewReal:@"line_looper_chat.png" andRect:CGPointMake(81*DEF_Adaptation_Font_x*0.5,frame.frame.origin.y+frame.frame.size.height+20*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 2*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
        [bk setAlpha:0.8];
        [self addSubview:bk];
        

        int start = 0;
        int end = 0;
        NSString *content = secondContent.text;
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
        
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:secondContent.text];
        [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:13*DEF_Adaptation_Font],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(start, end)];
        //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
        secondContent.attributedText = attributeString;

  

    }else{
        int num_y=[self getYWithForContentStr:cellData[@"content"]];
        content = [LooperToolClass createLableView:CGPointMake(81*DEF_Adaptation_Font_x*0.5, 86*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(530*DEF_Adaptation_Font_x*0.5, 34*DEF_Adaptation_Font_x*0.5*num_y) andText:cellData[@"content"] andFontSize:12 andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        content.numberOfLines = 0;
        [self addSubview:content];
        
        UIImageView *bk=[LooperToolClass createImageViewReal:@"line_looper_chat.png" andRect:CGPointMake(81*DEF_Adaptation_Font_x*0.5,content.frame.origin.y+content.frame.size.height+20*DEF_Adaptation_Font_x*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 2*DEF_Adaptation_Font_x*0.5) andIsRadius:false];
        [bk setAlpha:0.8];
        [self addSubview:bk];
    }
    
    

}



@end
