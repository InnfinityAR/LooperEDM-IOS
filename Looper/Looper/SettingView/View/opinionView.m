//
//  opinionView.m
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "opinionView.h"
#import "SettingViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@implementation opinionView{
    UITextView *textview;
    NSString *bugPath;
    UIButton *uploadBtn;
    UILabel *lbl;

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
        
        NSLog(@"%@",textview.text);
        
        [_obj removeOpinionView];
    }else if(button.tag==3001){
    
         NSLog(@"%@",textview.text);
        [_obj bugReport:textview.text and:bugPath];
        
    
    }else if(button.tag==3002){
        
        
        
        
        [_obj LocalPhoto];
        

    }
}


-(void)onClickImage:(UITapGestureRecognizer *)tap{
    
    
}


-(void)updataHeadView:(NSString*)imageStr{
    
    
    bugPath= imageStr;
    [uploadBtn removeFromSuperview];

    UIImageView* bugPathPic = [[UIImageView alloc] initWithFrame:CGRectMake(49*DEF_Adaptation_Font*0.5, 670*DEF_Adaptation_Font*0.5, 140*DEF_Adaptation_Font*0.5, 140*DEF_Adaptation_Font*0.5)];
    bugPathPic.image=[UIImage imageNamed:imageStr];
    [self addSubview:bugPathPic];
    
    
}



-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    
    
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


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        [lbl setHidden:NO];
    }else{
        [lbl setHidden:YES];
    }
}


-(void)initView{
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    

    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:3000 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    
    UIImageView * title=[LooperToolClass createImageView:@"btn_opinion_title.png" andRect:CGPointMake(252, 54) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:title];
    
    uploadBtn =[LooperToolClass createBtnImageName:@"btn_upPic.png" andRect:CGPointMake(49, 670) andTag:3002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: uploadBtn];
    
    UIButton *commitBtn =[LooperToolClass createBtnImageName:@"btn_commit.png" andRect:CGPointMake(46, 916) andTag:3001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: commitBtn];
    
    
    UIImageView * upLoadPic=[LooperToolClass createImageView:@"icon_upPic.png" andRect:CGPointMake(52, 626) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [self addSubview:upLoadPic];
    
    UIImageView * text_bg=[LooperToolClass createImageView:@"text_opinion.png" andRect:CGPointMake(46, 128) andTag:100 andSize:CGSizeMake(51,23) andIsRadius:false];
    [self addSubview:text_bg];

    textview = [[UITextView alloc] initWithFrame:CGRectMake(70*DEF_Adaptation_Font_x*0.5, 158*DEF_Adaptation_Font_x*0.5, 499*DEF_Adaptation_Font_x*0.5, 409*DEF_Adaptation_Font*0.5)];
    textview.backgroundColor=[UIColor clearColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.font=[UIFont fontWithName:looperFont size:10*DEF_Adaptation_Font]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    [self addSubview:textview];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self addGestureRecognizer:singleTap];
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(70*DEF_Adaptation_Font_x*0.5, 158*DEF_Adaptation_Font_x*0.5,  499*DEF_Adaptation_Font_x*0.5, 80*DEF_Adaptation_Font*0.5)];
    lbl.enabled = NO;
    lbl.numberOfLines=0;
    lbl.text = @"我们非常重视您给我们提供的宝贵意见，帮助我们不断完善产品，谢谢！";
    lbl.font =  [UIFont systemFontOfSize:15];
    lbl.textColor = [UIColor lightGrayColor];
    [self addSubview:lbl];
    
    

}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self endEditing:YES];
    

}

@end
