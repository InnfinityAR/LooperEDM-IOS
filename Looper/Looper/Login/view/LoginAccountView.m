//
//  AccuntView.m
//  Looper
//
//  Created by lujiawei on 3/24/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LoginAccountView.h"
#import "LooperConfig.h"
#import "LoginViewModel.h"
#import "LooperToolClass.h"
#import "DataHander.h"

@implementation LoginAccountView{
    UITextField *phoneText;
    UITextField *codeText;
    
    UIButton *sendBtn;

    
    NSTimer *downTimer;
    UILabel *downNum;

    
    int downTime;
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (LoginViewModel*)idObject;
        [self initView];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        
    }
    return self;
}


-(void)initView{
      
    
    phoneText=[self createTextField:@"手机号" andImg:@"bg_textFiled.png" andRect:CGRectMake(106, 240, 428, 50) andTag:100];
    codeText=[self createTextField:@"验证码" andImg:@"bg_textFiled.png" andRect:CGRectMake(106, 390, 300, 50) andTag:100];
    [self createBtnImageName:@"btn_loginV.png" andRect:CGPointMake(115, 545) andTag:joinBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil];
    [self createBtnImageName:@"btn_looper_back.png" andRect:CGPointMake(40, 40) andTag:backBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil];
    
    sendBtn = [self createBtnImageName:@"sendCode.png" andRect:CGPointMake(403,386) andTag:sendBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped)];
    tap.cancelsTouchesInView = NO; //(这步很重要,保证其他的UIControl能够正常接受到消息)
    [self addGestureRecognizer:tap];

    
}

-(void)downTimer{
    downTime  =  downTime - 1;
    downNum.text = [NSString stringWithFormat: @"%d秒后可重发",downTime];
    if(downTime == 1){
        
        [downNum removeFromSuperview];
        sendBtn.hidden= NO;
    }
    
}



- (IBAction)buttonDrag:(UIButton *)button withEvent:(UIEvent *)event{
    [_obj requestData:button.tag andIphone:phoneText.text andCode:codeText.text];
    if(button.tag==sendBtnTag){
        if([[self securityForTelephone:phoneText.text]intValue]){
            [_obj requestDataCode:phoneText.text];
            
            sendBtn.hidden= YES;
            downTime = 60;
            
            [downTimer invalidate];
            
            downTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(downTimer) userInfo:nil repeats:YES];
            
            downNum = [LooperToolClass createLableView:CGPointMake(403*DEF_Adaptation_Font*0.5, 400*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(126*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5) andText:[NSString stringWithFormat: @"%d秒后可重发",downTime] andFontSize:10 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.55] andType:NSTextAlignmentRight];
            [self addSubview:downNum];
        }else{
        
             [[DataHander sharedDataHander] showViewWithStr:@"输入手机号码错误" andTime:1 andPos:CGPointZero];
        
        }
    }
}
//验证 ：验证请求的是手机号
-(NSNumber*)securityForTelephone:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return 0;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return @1;
        }else{
            return 0;
        }
    }
    
}



#pragma mark -----点击空白处隐藏键盘
- (void)tableViewTapped
{
    [self endEditing:YES];
}

-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x*DEF_Adaptation_Font*0.5, rect.origin.y*DEF_Adaptation_Font*0.5, rect.size.width*DEF_Adaptation_Font*0.5, rect.size.height*DEF_Adaptation_Font*0.5)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(5*DEF_Adaptation_Font,0*DEF_Adaptation_Font,  rect.size.width*DEF_Adaptation_Font*0.5, rect.size.height*DEF_Adaptation_Font*0.5)];
    [textField setPlaceholder:string];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor whiteColor];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    return textField;
    
}

-(UIButton*)createBtnImageName:(NSString*)imageName andRect:(CGPoint)point andTag:(int)tag andSelectImage:(NSString*)SelimageN andClickImage:(NSString*)clickImageN andTextStr:(NSString*)TStr{
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selImage;
    if(SelimageN!=nil){
        selImage = [UIImage imageNamed:SelimageN];
    }
    UIImage *clickImage;
    if(clickImageN!=nil){
        clickImage = [UIImage imageNamed:clickImageN];
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(point.x*DEF_Adaptation_Font*0.5, point.y*DEF_Adaptation_Font*0.5, image.size.width*0.3*DEF_Adaptation_Font, image.size.height*0.3*DEF_Adaptation_Font)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setImage:clickImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(buttonDrag:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = tag;
    
    if(TStr!=nil){
        UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(0,0,image.size.width*0.3*DEF_Adaptation_Font,image.size.height*0.3*DEF_Adaptation_Font)];
        lable.text = TStr;
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setTextColor:[UIColor whiteColor]];
        lable.font = [UIFont fontWithName:looperFont size:10*DEF_Adaptation_Font];
        lable.tag = 1000;
        [btn addSubview:lable];
        
    }
    
    if(tag==108){
        [btn setSelected:true];
    }
    
    [self addSubview:btn];
    return btn;
}





@end
