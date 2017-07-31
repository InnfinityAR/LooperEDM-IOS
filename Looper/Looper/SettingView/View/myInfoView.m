//
//  myInfoView.m
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "myInfoView.h"
#import "SettingViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"
#import "UIImageView+WebCache.h"




@implementation myInfoView{


    UIImageView *head;
    UITextField *nickNameText;
    UILabel *sexText;
    UITextField *bornText;
    
    
    NSString *_headUrl;
    int isUpdataPhoto;

    
    UIButton *manBtn;
    UIButton *womenBtn;
    

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

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==3000){
        int sexNum = [[LocalDataMangaer sharedManager].sex intValue];
        if([sexText.text isEqualToString:@"男"]){
            sexNum = 1;
        }else if([sexText.text isEqualToString:@"女"]){
            sexNum = 2;
        }
            if(_headUrl==nil){
                [_obj updateUserInfo:nickNameText.text andSex:sexNum andHeadImage:nil andAge:bornText.text];
            }else{
                [_obj updateUserInfo:nickNameText.text andSex:sexNum andHeadImage:_headUrl andAge:bornText.text];
            }
            
        [_obj removeInfoView];
        }else if(button.tag==3001){
            
            [_obj LocalPhoto];
        }else if(button.tag==3008){
            
            sexText.text=@"男";
            [manBtn removeFromSuperview];
            [womenBtn removeFromSuperview];

            
        }else if(button.tag==3009){
             sexText.text=@"女";
            [manBtn removeFromSuperview];
            [womenBtn removeFromSuperview];

        }
}
    




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [manBtn removeFromSuperview];
    [womenBtn removeFromSuperview];
    
    
}
    

-(void)updataHeadView:(NSString*)headStr{
     isUpdataPhoto = 2;
    _headUrl =headStr;
    [head removeFromSuperview];

    head = [[UIImageView alloc] initWithFrame:CGRectMake(43*DEF_Adaptation_Font*0.5, 137*DEF_Adaptation_Font*0.5, 89*DEF_Adaptation_Font*0.5, 89*DEF_Adaptation_Font*0.5)];
    head.image=[UIImage imageNamed:headStr];
    head.layer.cornerRadius = 89*DEF_Adaptation_Font*0.5/2;
    head.layer.masksToBounds = YES;

    [self addSubview:head];
}


-(UITextField*)createTextField:(NSString*)string andRect:(CGRect)rect andTag:(int)num{

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(rect.origin.x,rect.origin.y,rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor colorWithRed:192/255.0 green:245/255.0 blue:55/255.0 alpha:1.0];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.enablesReturnKeyAutomatically = YES;
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    return textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [self endEditing:true];
    
    
    return true;
}



-(void)onClickImage:(UITapGestureRecognizer *)tap{
    
    
   }


-(void)initView{
     isUpdataPhoto = 1;
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    
    UIButton *backBtn =[LooperToolClass createBtnImageName:@"btn_looper_back.png" andRect:CGPointMake(15, 65) andTag:3000 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];

    
    [self addSubview: backBtn];
    
    UIImageView * title=[LooperToolClass createImageView:@"myInfo_Title.png" andRect:CGPointMake(266, 54) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:title];
    
    UIButton *updateHead =[LooperToolClass createBtnImageName:@"btn_updateHead.png" andRect:CGPointMake(178, 134) andTag:3001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: updateHead];
    
    UIImageView * baseInfo=[LooperToolClass createImageView:@"bg_baseInfo.png" andRect:CGPointMake(0, 264) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:baseInfo];

    UILabel *nickname = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 345*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"昵称" andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] andType:NSTextAlignmentLeft];
    [self addSubview:nickname];
    
    UILabel *sex = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 430*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"性别" andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] andType:NSTextAlignmentLeft];
    [self addSubview:sex];
    
    UILabel *age = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 515*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"年龄" andFontSize:14 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] andType:NSTextAlignmentLeft];
    [self addSubview:age];
    
    UIImageView * lineV1=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(0, 398) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineV1];

    UIImageView * lineV2=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(0, 484) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineV2];
    
    UIImageView * lineV3=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(0, 570) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:lineV3];

    
     head =[LooperToolClass createBtnImage:[LocalDataMangaer sharedManager].HeadImageUrl andRect:CGPointMake(43, 137) andTag:900 andSize:CGSizeMake(89, 89) andTarget:self];
     [self addSubview:head];
    
    head.layer.cornerRadius = 89*DEF_Adaptation_Font*0.5/2;
    head.layer.masksToBounds = YES;
    
    
    nickNameText = [self createTextField:[LocalDataMangaer sharedManager].NickName andRect:CGRectMake(154*DEF_Adaptation_Font*0.5, 335*DEF_Adaptation_Font*0.5, 452*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5) andTag:100];
    [self addSubview:nickNameText];
    
    NSString *sexStr;
    
    if([[LocalDataMangaer sharedManager].sex intValue]==1){
        sexStr =@"男";
    }else{
        sexStr =@"女";
    }

    sexText = [LooperToolClass createLableView:CGPointMake(162*DEF_Adaptation_Font*0.5, 421*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(452*DEF_Adaptation_Font*0.5,  42*DEF_Adaptation_Font*0.5) andText:sexStr andFontSize:13 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5] andType:NSTextAlignmentLeft];
    sexText.userInteractionEnabled=true;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createSelectView)];
    [sexText addGestureRecognizer:singleTap];

    
    [self addSubview:sexText];

    bornText = [self createTextField:[LocalDataMangaer sharedManager].age andRect:CGRectMake(154*DEF_Adaptation_Font*0.5, 506*DEF_Adaptation_Font*0.5, 452*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5) andTag:100];
    [self addSubview:bornText];
    
    bornText.keyboardType=UIKeyboardTypeNumberPad;
    
}

-(void)createSelectView{
    [manBtn removeFromSuperview];
    [womenBtn removeFromSuperview];
    
    
    manBtn =[LooperToolClass createBtnImageName:@"btn_Xman.png" andRect:CGPointMake(0, 900) andTag:3008 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: manBtn];
    womenBtn =[LooperToolClass createBtnImageName:@"btn_Xwomen.png" andRect:CGPointMake(0,990) andTag:3009 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: womenBtn];

  
}





@end
