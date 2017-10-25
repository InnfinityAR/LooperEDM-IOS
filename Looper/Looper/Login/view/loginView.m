//
//  loginView.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "loginView.h"
#import "LooperConfig.h"
#import "LoginViewModel.h"
#import <CoreMotion/CoreMotion.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialNetwork/UMSocialNetwork.h>
#import <UShareUI/UShareUI.h>


@implementation loginView{

    CMMotionManager *motionManager;
    
    NSOperationQueue *quene;
    
    
    UIImageView *bk;
    UIImageView *bkMid;
    UIImageView *bk1;
    UIImageView *moon;
    UIImageView *backV;
    UIImageView *frontV;
    
    
    UITextField *code;
    UITextField *phoneNum;
    
    NSTimer *updataTimer;
    
    


    int updataNum;
    
    int countNum;

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



-(void)removeAllView{
    
    [motionManager stopAccelerometerUpdates];
    [motionManager stopGyroUpdates];



}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
   
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    

}





-(void)initView{
    self.userInteractionEnabled= YES;
    
    updataNum = rand()%50;
    countNum = 0;
    [self initMotion];
    [self createBackGround];
    [self createTextView];
    
    updataTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updataView) userInfo:nil repeats:YES];
}


-(void)updataView{
    countNum++;
    if(countNum>=updataNum){
        countNum=0;
        updataNum = rand()%60;
        [self createMeteor];
    }
}

-(void)createMeteor{
//流星效果
    UIImage *meteor = [UIImage imageNamed:@"meteor.png"];
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(315 * (M_PI /180.0f));
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(rand()%300,rand()%30,meteor.size.width*0.3*DEF_Adaptation_Font,meteor.size.height*0.3*DEF_Adaptation_Font)];
    imageV.image = meteor;
    [self addSubview:imageV];
    imageV.transform = endAngle;
    imageV.transform = CGAffineTransformScale(imageV.transform,0.2,0.2);
    imageV.alpha=0.2;

    [UIView animateWithDuration:2.0 animations:^{
        imageV.frame = CGRectMake(imageV.frame.origin.x+50, imageV.frame.origin.y+50,imageV.frame.size.height*3.0,imageV.frame.size.width*3.0);
        imageV.alpha=1.0;
        imageV.transform = CGAffineTransformScale(imageV.transform,5.0,5.0);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 animations:^{
                imageV.frame = CGRectMake(imageV.frame.origin.x+100, imageV.frame.origin.y+100,imageV.frame.size.height*4.0, imageV.frame.size.width*4.0);
                imageV.alpha=0.1;
                imageV.transform = CGAffineTransformScale(imageV.transform,0.2,0.2);
            
        }completion:^(BOOL finished) {
            
            [imageV removeFromSuperview];
        }];
    }];
}


-(void)createTextView{
    [self createBtnImageName:@"btn_login.png" andRect:CGPointMake(115,1003) andTag:AccountBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil];
    
    if([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]==true){
        [self createBtnImageName:@"btn_loginWechat.png" andRect:CGPointMake(115, 911) andTag:WECHATBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil];
    }
    [self createImage:@"LOGO.png" andRect:CGPointMake(355, 242)andTag:900];
}

-(void)createImage:(NSString*)imageName andRect:(CGPoint)rect andTag:(int)tag{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(rect.x*DEF_Adaptation_Font*0.5, rect.y*DEF_Adaptation_Font*0.5, image.size.width*0.3*DEF_Adaptation_Font, image.size.height*0.3*DEF_Adaptation_Font)];
    imageV.tag = tag;
    [imageV setImage:image];
    [self addSubview:imageV];

}

-(void)setBtnStatus{
    for (int i=0;i<[[self subviews] count];i++){
        UIButton *btn = [[self subviews] objectAtIndex:i];
        if(btn.tag==107 || btn.tag==108){
            [btn setSelected:false];
        }
    }
}

-(void)moveLine:(int)Tag{
    for (int i=0;i<[[self subviews] count];i++){
        UIImageView *view = [[self subviews] objectAtIndex:i];
        if(view.tag==109){
            NSNumber *num;
            if(Tag==107){
                num=[NSNumber numberWithFloat:155.0f*DEF_Adaptation_Font];
            }else if(Tag==108){
                num=[NSNumber numberWithFloat:0];
            }
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath : @"transform.translation.x"]; ///.y 的话就向下移动。
            animation. toValue = num;
            
            animation. duration = 0.2;
            
            animation. removedOnCompletion = NO ; //yes 的话，又返回原位置了。
            
            animation. fillMode = kCAFillModeForwards ;
            
            [view.layer  addAnimation:animation forKey:nil];
        }
    }
}


-(void)updateBtnLableText:(int)tag and:(NSString*)str{

    UIButton *btn =[self viewWithTag:tag];
    UILabel *label = [btn viewWithTag:1000];
    label.text = str;

}

-(IBAction)buttonDrag:(UIButton *)button withEvent:(UIEvent *)event {

    if(button.tag==107){
        [self setBtnStatus];
        [button setSelected:true];
        [self moveLine:107];
        [self updateBtnLableText:LoginBtnTag and:@"登入"];
    }else if(button.tag ==108){
        [self setBtnStatus];
        [button setSelected:true];
         [self moveLine:108];
        [self updateBtnLableText:LoginBtnTag and:@"注册"];
    }else if(button.tag==201){
        
    
    
    }
    else if(button.tag ==105){
        [self.obj requestData:button.tag andIphone:phoneNum.text andCode:code.text];

    }else {
         [self.obj requestData:(int)button.tag andIphone:phoneNum.text andCode:nil];
    }
}

- (void)tableViewTapped
{
    [self endEditing:YES];
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




-(void)initMotion{
    motionManager = [[CMMotionManager alloc]init];
    
    // 初始化 NSOperationQueue
    quene = [[NSOperationQueue alloc]init];
    
    
    // 调用陀螺仪
    
       [self configureGrro];

}


-(void)updatePositionAllSprite:(CMGyroData*)gyroData and:(UIView*)view and:(int)min_x and:(int)max_x and:(int)min_y and:(int)max_y andSpeed:(float)speed{
    if(gyroData.rotationRate.x>0.4){
        if( (view.frame.origin.y+gyroData.rotationRate.x*speed)>=min_y){
            [view setFrame:CGRectMake(view.frame.origin.x,min_y, view.frame.size.width,  view.frame.size.height)];
        }else{
            [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y+gyroData.rotationRate.x*speed, view.frame.size.width,  view.frame.size.height)];
        }
    }else if(gyroData.rotationRate.x<-0.4){
        if( (view.frame.origin.y+gyroData.rotationRate.x*speed)>=max_y){
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+gyroData.rotationRate.x*speed, view.frame.size.width,  view.frame.size.height)];
        }else{
            [view setFrame:CGRectMake(view.frame.origin.x,max_y, view.frame.size.width,  view.frame.size.height)];
        }
    }
    
    if(gyroData.rotationRate.y>0.4){
        if( (view.frame.origin.x+gyroData.rotationRate.y*speed)>=max_x){
            [view setFrame:CGRectMake(max_x,view.frame.origin.y, view.frame.size.width,view.frame.size.height)];
        }else{
            [view setFrame:CGRectMake(view.frame.origin.x+gyroData.rotationRate.y*speed,view.frame.origin.y, view.frame.size.width,  view.frame.size.height)];
        }
    }else if(gyroData.rotationRate.y<-0.4){
        if( (view.frame.origin.x+gyroData.rotationRate.y*speed)>=min_x){
            [view setFrame:CGRectMake( view.frame.origin.x+gyroData.rotationRate.y*speed,view.frame.origin.y, view.frame.size.width,  view.frame.size.height)];
        }else{
            [view setFrame:CGRectMake(min_x,view.frame.origin.y, view.frame.size.width,  view.frame.size.height)];
        }
    }
}

- (void)configureGrro
{
    
    if ([motionManager isGyroAvailable]) {
        [motionManager startGyroUpdatesToQueue:quene withHandler:^(CMGyroData *gyroData, NSError *error) {

             dispatch_async(dispatch_get_main_queue(), ^{
            
                UIImage *bkFrontBk = [UIImage imageNamed:@"bk_front_login.png"];
                
                [self updatePositionAllSprite:gyroData and:bk and:-76*DEF_Adaptation_Font*0.3 and:0 and:0 and:-133*DEF_Adaptation_Font*0.3 andSpeed:0.5];
                [self updatePositionAllSprite:gyroData and:bk1 and:-76*DEF_Adaptation_Font*0.3 and:0 and:DEF_SCREEN_HEIGHT-bkFrontBk.size.height*DEF_Adaptation_Font*0.3+133*DEF_Adaptation_Font*0.3 and:DEF_SCREEN_HEIGHT-bkFrontBk.size.height*DEF_Adaptation_Font*0.3  andSpeed:0.3];
                [self updatePositionAllSprite:gyroData and:bkMid and:-76*DEF_Adaptation_Font*0.3 and:0 and:850*DEF_Adaptation_Font*0.3+66*DEF_Adaptation_Font*0.3 and:850*DEF_Adaptation_Font*0.3-66*DEF_Adaptation_Font*0.3  andSpeed:0.4];
             });
        }];
    }else{
        NSLog(@"陀螺仪不能使用");
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    
  }

// 触摸结束的时候
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CMAcceleration acceleration = motionManager.accelerometerData.acceleration;
    NSLog(@"%.2f__%.2f__%.2f",acceleration.x,acceleration.y,acceleration.z);
}



-(void)createBackGround{

    UIImage *bkImage = [UIImage imageNamed:@"bk_login.png"];
    bk = [[UIImageView alloc] initWithFrame:CGRectMake(-38*DEF_Adaptation_Font*0.5,-66*DEF_Adaptation_Font*0.5, bkImage.size.width*DEF_Adaptation_Font*0.3, bkImage.size.height*DEF_Adaptation_Font*0.3)];
   
    [bk setImage:bkImage];
    [self addSubview:bk];

    UIImage *bkMidImage = [UIImage imageNamed:@"bk_mid_login.png"];
    bkMid = [[UIImageView alloc] initWithFrame:CGRectMake(-38*DEF_Adaptation_Font*0.5,850*DEF_Adaptation_Font*0.3, bkMidImage.size.width*DEF_Adaptation_Font*0.3, bkMidImage.size.height*DEF_Adaptation_Font*0.3)];
    
    [bkMid setImage:bkMidImage];
    [self addSubview:bkMid];

    
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    backV = [[UIImageView alloc] initWithFrame:CGRectMake(-1350*DEF_Adaptation_Font*0.3,0,backImage.size.width*DEF_Adaptation_Font*0.3, backImage.size.height*DEF_Adaptation_Font*0.3)];
    [backV setImage:backImage];
    [self addSubview:backV];
    
    UIImage *frontImage = [UIImage imageNamed:@"front.png"];
    frontV = [[UIImageView alloc] initWithFrame:CGRectMake(-1350*DEF_Adaptation_Font*0.3,0,backImage.size.width*DEF_Adaptation_Font*0.3, backImage.size.height*DEF_Adaptation_Font*0.3)];
    [frontV setImage:frontImage];
    [self addSubview:frontV];
    
    UIImage *bkFrontBk = [UIImage imageNamed:@"bk_front_login.png"];
    bk1 = [[UIImageView alloc] initWithFrame:CGRectMake(-38*DEF_Adaptation_Font*0.5, DEF_SCREEN_HEIGHT-bkFrontBk.size.height*DEF_Adaptation_Font*0.3,bkFrontBk.size.width*DEF_Adaptation_Font*0.3, bkFrontBk.size.height*DEF_Adaptation_Font*0.3)];
    [bk1 setImage:bkFrontBk];
    [self addSubview:bk1];
    

    
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped)];
    tap.cancelsTouchesInView = NO; //(这步很重要,保证其他的UIControl能够正常接受到消息)
    [self addGestureRecognizer:tap];
    
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: -M_PI *2];
    animation.duration  = 390;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = 500;
    animation.removedOnCompletion = NO;
    [frontV.layer addAnimation:animation forKey:nil];
    
    
    CABasicAnimation *animationback =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animationback.fromValue = [NSNumber numberWithFloat:0.f];
    animationback.toValue =  [NSNumber numberWithFloat: -M_PI *2];
    animationback.duration  = 530;
    animationback.autoreverses = NO;
    animationback.fillMode =kCAFillModeForwards;
    animationback.repeatCount = 500;
    animationback.removedOnCompletion = NO;
    [backV.layer addAnimation:animationback forKey:nil];

    UIImage *moonImage = [UIImage imageNamed:@"bk_moon.png"];
    moon = [[UIImageView alloc] initWithFrame:CGRectMake(52*DEF_Adaptation_Font*0.5, 285*DEF_Adaptation_Font*0.5,moonImage.size.width*DEF_Adaptation_Font*0.3, moonImage.size.height*DEF_Adaptation_Font*0.3)];
    [moon setImage:moonImage];
    [self addSubview:moon];
    

}


@end
