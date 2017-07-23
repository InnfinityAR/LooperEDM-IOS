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
#import "MBProgressHUD.h"
#import "DataHander.h"
#import "LocalDataMangaer.h"
@implementation sendMessageActivityView{

    UIButton* sendBtn;
    UIButton* sendPicBtn;

    
    
    UITextView *textview;
    NSMutableArray *tempImageArray;
    NSMutableArray *ImageArray;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)barrageView andIndexPath:(NSInteger)indexPath{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (ActivityViewModel*)idObject;
        self.barrageView=self.barrageView;
        self.cellIndexPath=indexPath;
        [self initView];
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{


    if(button.tag==101){
        NSLog(@"我是send按钮");
        if ([textview.text isEqualToString:@""]) {
            [[DataHander sharedDataHander] showViewWithStr:@"地球人你确定不写评论吗" andTime:2 andPos:CGPointZero];
        }
        else if(textview.text.length>=100){
        [[DataHander sharedDataHander] showViewWithStr:@"地球人你评论超过100字了" andTime:2 andPos:CGPointZero];
        }
        else{
            if (self.cellIndexPath>=0) {
//给涛哥发送消息
                NSDictionary *barrageDic=nil;
                if (self.cellIndexPath==0) {
                 barrageDic= [self.barrageView barrageInfo][0];
                }else{
                barrageDic= [self.barrageView barrageInfo][self.cellIndexPath-1];
                }
                [self.obj pustDataForActivityID:[[barrageDic  objectForKey:@"activityid"]intValue] andMessageID:[[barrageDic  objectForKey:@"messageid"]intValue] andContent:textview.text andUserID:@([[LocalDataMangaer sharedManager].uid intValue])  andIndex:self.cellIndexPath andIsReplyView:NO];
                NSLog(@"发送信息%@",barrageDic);
            }
            else{
        [self.obj sendActivityMessage: [self.barrageView activityID] and:textview.text and:tempImageArray];
            }
        [self removeFromSuperview];
        }
       
    }else if(button.tag==102){
        [_obj LocalPhoto];
    
    }else if(button.tag==103){
         [self removeFromSuperview];
        
    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textview resignFirstResponder];
}
-(void)createHudView{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:103 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    
    
    sendBtn =[LooperToolClass createBtnImageName:@"send_comment.png" andRect:CGPointMake(34, 621) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: sendBtn];
    
    sendPicBtn =[LooperToolClass createBtnImageName:@"send_picture.png" andRect:CGPointMake(538, 619) andTag:102 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: sendPicBtn];
    self.commentLB=[LooperToolClass createLableView:CGPointMake(DEF_WIDTH(self)/2-80*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5, 40) andText:@"评论" andFontSize:16 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter ];
    [self addSubview:self.commentLB];

    if (self.cellIndexPath>=0) {
        [sendPicBtn setHidden:YES];
        self.commentLB.text=@"回复评论";
        CGRect frame=sendBtn.frame;
        frame.origin.x=80*DEF_Adaptation_Font*0.5;
        sendBtn.frame=frame;
    }else{
        [sendPicBtn setHidden:NO];
    }
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(34*DEF_Adaptation_Font_x*0.5, 122*DEF_Adaptation_Font_x*0.5, 572*DEF_Adaptation_Font_x*0.5, 368*DEF_Adaptation_Font*0.5)];
    textview.backgroundColor=[UIColor clearColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.font=[UIFont fontWithName:looperFont size:10*DEF_Adaptation_Font]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll;
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
        UIImageView *imagev=[LooperToolClass createImageViewReal:[tempImageArray objectAtIndex:i] andRect:CGPointMake(num_x*DEF_Adaptation_Font*0.5,400*DEF_Adaptation_Font*0.5) andTag:i andSize:CGSizeMake(128*DEF_Adaptation_Font*0.5, 128*DEF_Adaptation_Font*0.5) andIsRadius:false];
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

-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    sendBtn.frame = CGRectMake(sendBtn.frame.origin.x, DEF_SCREEN_HEIGHT- frame.size.height-sendBtn.frame.size.height-15*DEF_Adaptation_Font*0.5, sendBtn.frame.size.width, sendBtn.frame.size.height);
    
    sendPicBtn.frame = CGRectMake(sendPicBtn.frame.origin.x, DEF_SCREEN_HEIGHT -frame.size.height-sendPicBtn.frame.size.height-15*DEF_Adaptation_Font*0.5, sendPicBtn.frame.size.width, sendPicBtn.frame.size.height);
}
-(void)keyboardWillHide:(NSNotification *)notification{
    
    sendBtn.frame = CGRectMake(sendBtn.frame.origin.x, DEF_SCREEN_HEIGHT-sendBtn.frame.size.height-15*DEF_Adaptation_Font*0.5, sendBtn.frame.size.width, sendBtn.frame.size.height);
    
    sendPicBtn.frame = CGRectMake(sendPicBtn.frame.origin.x, DEF_SCREEN_HEIGHT -sendPicBtn.frame.size.height-15*DEF_Adaptation_Font*0.5, sendPicBtn.frame.size.width, sendPicBtn.frame.size.height);

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
