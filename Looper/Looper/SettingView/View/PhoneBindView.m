//
//  PhoneBindView.m
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhoneBindView.h"
#import "SettingViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "DataHander.h"




@implementation PhoneBindView{

    UIButton *nextBtn;
    UITextField *phoneText;
    NSString *phoneNum;
    
    int statusNum;

}
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (SettingViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
    
}


-(UITextField*)createTextField:(NSString*)string andRect:(CGRect)rect andTag:(int)num{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(rect.origin.x,rect.origin.y,rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor whiteColor];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.enablesReturnKeyAutomatically = YES;
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    return textField;
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==3000){
        [_obj removePhoneBindView];
    }else if(button.tag==4000){
        
        if(statusNum==1){
            if([phoneText.text length]==11){
                [_obj requestDataCode:phoneText.text];
                phoneNum = phoneText.text;
                statusNum=2;
                phoneText.placeholder=@"请输入验证码";
                phoneText.text=@"";
                [nextBtn setSelected:true];
            }else{
                phoneText.text=@"";
                [[DataHander sharedDataHander] showViewWithStr:@"手机号码错误" andTime:1 andPos:CGPointZero];
                
            }
        }else if(statusNum==2){
            [_obj bindMobile:phoneNum andCode:phoneText.text];
        }
        
    }
}




-(void)initView{
    statusNum = 1;
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    

    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:3000 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    
    
    
    UIImageView * title=[LooperToolClass createImageView:@"bg_account_title.png" andRect:CGPointMake(224, 54) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:title];

    UIImageView * iconPhone=[LooperToolClass createImageView:@"icon_iphone.png" andRect:CGPointMake(38, 168) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:iconPhone];
    
    UIImageView * line=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(43, 255) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:line];

    nextBtn =[LooperToolClass createBtnImageName:@"btn_next.png" andRect:CGPointMake(46, 323) andTag:4000 andSelectImage:@"btn_commit.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: nextBtn];

    phoneText = [self createTextField:@"请输入手机号" andRect:CGRectMake(117*DEF_Adaptation_Font*0.5, 178*DEF_Adaptation_Font*0.5, 460*DEF_Adaptation_Font*0.5, 38*DEF_Adaptation_Font*0.5) andTag:100];
    [self addSubview:phoneText];
    
    
    
    
    
    
    
}



@end
