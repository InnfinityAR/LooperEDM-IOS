//
//  sendPhotoWall.m
//  Looper
//
//  Created by lujiawei on 12/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "sendPhotoWall.h"
#import "PhotoWallViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "PKRecordShortVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+PKShortVideoPlayer.h"
#import "DataHander.h"

@implementation sendPhotoWall{

    UITextView *textview;
    UIButton* addPicVideo;
    NSString *videoStr;
    UILabel *locationStr;
    UIImageView *videoImg;
    NSMutableArray *_photoArray;

}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView];
    }
    return self;
    
    
}


-(void)playVideo{

    
    


}

-(void)setLocationStr:(NSString*)str{
    locationStr.text= str;


}


-(void)ImageFileSave:(UIImage*)imageFile{

    
    [_photoArray addObject:imageFile];
    
    videoImg = [[UIImageView alloc] initWithFrame:CGRectMake(38*DEF_Adaptation_Font*0.5,427*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5)];
    videoImg.image=imageFile;
    videoImg.layer.cornerRadius = 15*DEF_Adaptation_Font_x*0.5;
    videoImg.layer.masksToBounds = YES;
    [self addSubview:videoImg];
  
}


-(void)videoFileSave:(NSString*)videoFile{

    NSLog(@"%@",videoFile);
    videoStr = videoFile;
    
    AVPlayer*_player=[AVPlayer playerWithURL:[[NSURL alloc] initWithString:videoFile]];
    AVPlayerLayer*playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    [self.layer addSublayer:playerLayer];
    [_player play];
    
    [addPicVideo removeFromSuperview];
 
    videoImg = [[UIImageView alloc] initWithFrame:CGRectMake(38*DEF_Adaptation_Font*0.5,427*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5)];
    videoImg.image=[UIImage pk_previewImageWithVideoURL:[NSURL fileURLWithPath:videoFile]];
    videoImg.layer.cornerRadius = 15*DEF_Adaptation_Font_x*0.5;
    videoImg.layer.masksToBounds = YES;
    [self addSubview:videoImg];
    
    UIButton *videoPlay = [LooperToolClass createBtnImageNameReal:@"icon_play.png" andRect:CGPointMake(76*DEF_Adaptation_Font*0.5,465*DEF_Adaptation_Font*0.5) andTag:109 andSelectImage:@"icon_play.png" andClickImage:@"icon_play.png" andTextStr:nil andSize:CGSizeMake(68*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:videoPlay];

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==106){
        
    }else if (button.tag==101){
        [self removeFromSuperview];
    }else if (button.tag==102){
        if(videoStr==nil){
              [[DataHander sharedDataHander] showViewWithStr:@"请上传图片" andTime:1 andPos:CGPointZero];
        }else{
             [_obj createImageBoardText:textview.text and:nil andVideoPath:videoStr andVideoImage:videoImg.image];
        }
    }else if(button.tag == 900){
        
        [_obj createRecordVideo];
    }else if(button.tag == 109){
        [_obj playVideoFile:videoStr];
    }else if(button.tag == 119){
        
        [_obj getOfflineInformationByIP];
        
        // [[DataHander sharedDataHander] showViewWithStr:@"coming soon....." andTime:1 andPos:CGPointZero];
    }
}

-(void)createHudView{
    
    UILabel* titleStr = [LooperToolClass createLableView:CGPointMake(280*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(80*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:@"发动态" andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [self addSubview:titleStr];

     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];

    UIButton *selLocationBtn = [LooperToolClass createBtnImageNameReal:@"selLocation.png" andRect:CGPointMake(38*DEF_Adaptation_Font*0.5,624*DEF_Adaptation_Font*0.5) andTag:119 andSelectImage:@"selLocation.png" andClickImage:@"selLocation.png" andTextStr:nil andSize:CGSizeMake(605*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:selLocationBtn];
    
    locationStr = [LooperToolClass createLableView:CGPointMake(106*DEF_Adaptation_Font*0.5,660*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(280*DEF_Adaptation_Font_x*0.5, 22*DEF_Adaptation_Font_x*0.5) andText:@"选择所在现场" andFontSize:10 andColor:[UIColor colorWithRed:43/255.0 green:207/255.0 blue:214/255.0 alpha:0.7] andType:NSTextAlignmentLeft];
    
    [self addSubview:locationStr];
    
    
    UIButton *sendBtn = [LooperToolClass createBtnImageNameReal:@"btn_sendPhoto.png" andRect:CGPointMake(528*DEF_Adaptation_Font*0.5,34*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_sendPhoto.png" andClickImage:@"btn_sendPhoto.png" andTextStr:nil andSize:CGSizeMake(97*DEF_Adaptation_Font*0.5, 72*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:sendBtn];
    
    UIImageView *text_bg = [[UIImageView alloc] initWithFrame:CGRectMake(38*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5, 562*DEF_Adaptation_Font*0.5, 230*DEF_Adaptation_Font*0.5)];
    text_bg.image=[UIImage imageNamed:@"text_input.png"];
    [self addSubview:text_bg];
    
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(48*DEF_Adaptation_Font_x*0.5, 150*DEF_Adaptation_Font_x*0.5, 562*DEF_Adaptation_Font_x*0.5, 220*DEF_Adaptation_Font*0.5)];
    textview.backgroundColor=[UIColor clearColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.font=[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll;
    textview.textColor = [UIColor colorWithRed:161/255.0 green:171/255.0 blue:181/255.0 alpha:1.0];
    textview.text = @"说说 现场如何";//设置显示的文本内容
    [self addSubview:textview];
    
    [textview becomeFirstResponder];
    
    addPicVideo = [LooperToolClass createBtnImageNameReal:@"icon_addPic.png" andRect:CGPointMake(38*DEF_Adaptation_Font*0.5,427*DEF_Adaptation_Font*0.5) andTag:900 andSelectImage:@"icon_addPic.png" andClickImage:@"icon_addPic.png" andTextStr:nil andSize:CGSizeMake(144*DEF_Adaptation_Font*0.5, 144*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:addPicVideo];

    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textview resignFirstResponder];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if([textView.text isEqualToString:@"说说 现场如何"]){
    
         textview.text = @"";
        
       
         textview.textColor = [UIColor colorWithRed:218/255.0 green:228/255.0 blue:238/255.0 alpha:1.0];
    }
     return true;

}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

    if([textView.text length]==0){
    
        
        textview.text = @"说说 现场如何";
        textview.textColor = [UIColor colorWithRed:161/255.0 green:171/255.0 blue:181/255.0 alpha:1.0];
    
    }
    return true;
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
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
      _photoArray = [[NSMutableArray alloc] initWithCapacity:50];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self setBackgroundColor: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    [self createHudView];

}


@end
