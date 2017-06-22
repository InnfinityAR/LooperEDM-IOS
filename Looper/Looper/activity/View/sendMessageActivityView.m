//
//  sendMessageActivityView.m
//  Looper
//
//  Created by lujiawei on 20/06/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "sendMessageActivityView.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "ActivityBarrageView.h"
@implementation sendMessageActivityView{

    UIButton* sendBtn;
    UIButton* sendPicBtn;
    UITextView *textview;
    NSMutableArray *tempImageArray;
    NSMutableArray *ImageArray;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)barrageView{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (ActivityViewModel*)idObject;
        self.barrageView=self.barrageView;
        
        [self initView];
    }
    return self;
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{


    if(button.tag==101){
        NSLog(@"我是send按钮");
        [self.obj sendActivityMessage: [self.barrageView activityID] and:textview.text and:tempImageArray];
        [self removeFromSuperview];
       
    }else if(button.tag==102){
        [_obj LocalPhoto];
    
    }else if(button.tag==103){
         [self removeFromSuperview];
        
    }

}

-(void)createHudView{
    
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:103 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    sendBtn =[LooperToolClass createBtnImageName:@"send_comment.png" andRect:CGPointMake(34, 621) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: sendBtn];
    
    sendPicBtn =[LooperToolClass createBtnImageName:@"send_picture.png" andRect:CGPointMake(538, 619) andTag:102 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: sendPicBtn];
    
    
    UIImageView* labelComment=[LooperToolClass createImageView:@"label_Comment.png" andRect:CGPointMake(294, 56) andTag:100 andSize:CGSizeZero andIsRadius:false];
    
    [self addSubview:labelComment];

    textview = [[UITextView alloc] initWithFrame:CGRectMake(34*DEF_Adaptation_Font_x*0.5, 122*DEF_Adaptation_Font_x*0.5, 572*DEF_Adaptation_Font_x*0.5, 368*DEF_Adaptation_Font*0.5)];
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
    textview.text = @"";//设置显示的文本内容
    [self addSubview:textview];
    
    [textview becomeFirstResponder];
}

-(void)removeAllImage{
    for (int i=0;i<[ImageArray count];i++){
        [[ImageArray objectAtIndex:i] removeFromSuperview];
    }
}

-(void)createSelectImage{
    [self removeAllImage];
    for(int i =0;i<[tempImageArray count];i++){
      int num_x;
        if(i==0){
            num_x=480;
        }else if(i==1){
            num_x=316;
        }else if(i==2){
            num_x=152;
        }else{
        
        }
        UIImageView *imagev=[LooperToolClass createImageViewReal:[tempImageArray objectAtIndex:i] andRect:CGPointMake(num_x*DEF_Adaptation_Font*0.5,466*DEF_Adaptation_Font*0.5) andTag:i andSize:CGSizeMake(128*DEF_Adaptation_Font*0.5, 128*DEF_Adaptation_Font*0.5) andIsRadius:false];
        imagev.layer.cornerRadius = 8*DEF_Adaptation_Font*0.5;
        imagev.layer.masksToBounds = YES;
        [imagev setBackgroundColor:[UIColor redColor]];
        [self addSubview:imagev];
        [ImageArray addObject:imagev];
    }
}


-(void)showSelectImage:(NSString*)selectImage{
    [textview becomeFirstResponder];
    [tempImageArray addObject:selectImage];
    [self createSelectImage];
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

-(void)initView{
    tempImageArray = [[NSMutableArray alloc] initWithCapacity:50];
    ImageArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:35.0/255.0 green:33.0/255.0 blue:57.0/255.0 alpha:1.0]];
    [self createHudView];
    
}



@end
