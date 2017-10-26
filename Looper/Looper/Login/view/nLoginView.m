//
//  nLoginView.m
//  Looper
//
//  Created by lujiawei on 2/5/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nLoginView.h"
#import "LoginViewModel.h"
#import "LooperConfig.h"
#import "AdScrollView.h"
#import "AdDataModel.h"

#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialNetwork/UMSocialNetwork.h>
#import <UShareUI/UShareUI.h>
#import "LooperToolClass.h"
#import "DataHander.h"

@implementation nLoginView{

    NSTimer *scrollTimer;
    UIScrollView *scrollV;
    UIButton *wechatBtn;

    UITextField *textFieldIphone;
    
    UITextField *textFieldCode;
    
    UIImageView *codeIcon;
    
    UIButton *sendCode;
    
    NSTimer *downTimer;
    
    int downTime;
    
    UILabel *downNum;
    
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


-(void)createScrollView{


    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, 836*DEF_Adaptation_Font*0.5)];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageName:nil];
    NSLog(@"%@",dataModel.adTitleArray);
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleCenter;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.48];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:scrollView];

     
}


-(void)moveScrollView{
    int num_x = scrollV.contentOffset.x;
    if(num_x<(DEF_SCREEN_WIDTH*4-DEF_SCREEN_WIDTH)){
        num_x = num_x +DEF_SCREEN_WIDTH;
        [scrollV setContentOffset:CGPointMake(num_x, 0) animated:true];
    }else{
        [scrollV setContentOffset:CGPointMake(0, 0) animated:false];
    }
}

-(void)initView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setBackgroundColor:[UIColor colorWithRed:22/255.0 green:11/255.0 blue:28/255.0 alpha:1.0]];
    [self createScrollView];
    [self createHudView];
    
}


-(void)downTimer{
    downTime  =  downTime - 1;
    downNum.text = [NSString stringWithFormat: @"%d秒后可重发",downTime];
    if(downTime == 1){
    
        [downNum removeFromSuperview];
        sendCode.hidden= NO;
    }
    
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    [self.obj hudOnClick:button.tag];
    
    if(button.tag == 400){
        downTime = 60;
        [_obj requestDataCode:textFieldIphone.text];
        
        sendCode.hidden= YES;
        
        downTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(downTimer) userInfo:nil repeats:YES];
        
        downNum = [LooperToolClass createLableView:CGPointMake(456*DEF_Adaptation_Font*0.5, 908*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(126*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5) andText:[NSString stringWithFormat: @"%d秒后可重发",downTime] andFontSize:10 andColor:[UIColor colorWithRed:46/255.0 green:94/255.0 blue:116/255.0 alpha:1.0] andType:NSTextAlignmentRight];
        [self addSubview:downNum];
    }
}


-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    bgView.tag=num;
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(3,0,  rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor whiteColor];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    if(num==1001){
          textField.returnKeyType = UIReturnKeyNext;
    
    }else{
         textField.returnKeyType = UIReturnKeyJoin;
    }
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    return textField;
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息

    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.frame = CGRectMake(0, -1*frame.size.height, self.frame.size.width, self.frame.size.height);
 
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if([textField.text length]>0){
        wechatBtn.hidden = YES;
        codeIcon.hidden = NO;
        textFieldCode.hidden = NO;
        [self viewWithTag:1002].hidden=NO;
    }
    

}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    

    wechatBtn.hidden = YES;
    codeIcon.hidden = NO;
    textFieldCode.hidden = NO;
    [self viewWithTag:1002].hidden=NO;
    
    return YES;
}


-(void)keyboardWillHidden:(NSNotification *)notification
{
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    wechatBtn.hidden = NO;
    codeIcon.hidden = YES;
    textFieldCode.hidden = YES;
     [self viewWithTag:1002].hidden=YES;

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

     [self endEditing:YES];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if(textField.tag==1001){
        [textFieldCode becomeFirstResponder];
    }
    
    if(textField.tag == 1002){
         [_obj login:textFieldIphone.text andCode:textFieldCode.text];
        [self endEditing:YES];
    }
    
    return YES;
}




-(void)createHudView{
    
    UIImageView *loginLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 763*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 73*DEF_Adaptation_Font*0.5)];
    [loginLine setImage:[UIImage imageNamed:@"login_line.png"]];
    [self addSubview:loginLine];
    
    
    
    if([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]==true){
        wechatBtn = [LooperToolClass createBtnImageName:@"icon_wechat_login.png" andRect:CGPointMake(241, 1026) andTag:500 andSelectImage:@"icon_wechat_login.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
        [self addSubview:wechatBtn];
    }

    UIImageView *phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 885*DEF_Adaptation_Font*0.5,  68*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    [phoneIcon setImage:[UIImage imageNamed:@"icon_phone_login.png"]];
    [self addSubview:phoneIcon];
    
    
    textFieldIphone=[self createTextField:@"请输入手机号" andImg:@"login_x_line.png" andRect:CGRectMake(116*DEF_Adaptation_Font*0.5, 885*DEF_Adaptation_Font*0.5, 476*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5) andTag:1001];
    
    
    codeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30*DEF_Adaptation_Font*0.5, 982*DEF_Adaptation_Font*0.5,  68*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    [codeIcon setImage:[UIImage imageNamed:@"icon_code_login.png"]];
    [self addSubview:codeIcon];
    codeIcon.hidden = YES;
    
    textFieldCode=[self createTextField:@"请输入验证码" andImg:@"login_x_line.png" andRect:CGRectMake(116*DEF_Adaptation_Font*0.5, 982*DEF_Adaptation_Font*0.5, 476*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5) andTag:1002];

    textFieldCode.hidden=YES;
    [self viewWithTag:1002].hidden=YES;
    
    sendCode = [LooperToolClass createBtnImageName:@"sendCode.png" andRect:CGPointMake(478, 908) andTag:400 andSelectImage:@"sendCode.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:sendCode];

}



@end
