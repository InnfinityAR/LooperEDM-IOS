//
//  nMainView.m
//  Looper
//
//  Created by lujiawei on 3/15/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nMainView.h"
#import "MainViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UserInfoView.h"
#import "MainChatView.h"
#import "LocalDataMangaer.h"
#import "RongCloudManger.h"
#import "UIImageView+WebCache.h"
#import "LocationManagerData.h"

@implementation nMainView{
    
    
    NSTimer *updataTimer;
    BOOL isTimerRun;
    
    UIImageView *imageOne;
    UIImageView *imageTwo;
    
    UIImageView *frontView;
    UIImageView *backView;
    UIImageView *planeView;
    UIImageView *bg3V;
    UIImageView *bg4V;
    
    UIButton *looperBtn;
    UIButton *DjBtn;
    UIButton *activeBtn;
    UIButton *serachBtn;
    
    BOOL isLooperUp;
    BOOL isDJUp;
    BOOL isActiveUp;
    BOOL planeUp;
    
    
    CGPoint startLocation;
    CGPoint moveLocation;
    CGPoint endLocation;
    
    UIView *moveView;
    int directionNum;           //1 横向  2 纵向
    
    
    long int startDate;
    
    UIView *backViewColor;
    
    
    UIVisualEffectView *_effectView;
    
    UserInfoView *userInfoView;
    MainChatView *mainChatV;
    
    UIImageView *looperImage;
    
}


@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]){
        self.obj = (MainViewModel*)idObject;
        dispatch_async(dispatch_get_main_queue(), ^{
             [self initView];
        });
    }
    return self;
}


-(void)updataView:(NSDictionary*)data{

    [mainChatV updataLoopFollowData:[[_obj MainData] objectForKey:@"data"]];
    
    if( isTimerRun==true){
    
        [userInfoView updataView:data];
        
    }

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
 
    
    [_obj hudOnClick:(int)button.tag];
}


-(void)chatView:(NSString*)targetId{
    
    [[RongCloudManger sharedManager] getUserData:targetId success:^(id responseObject){
        
        [_obj pushControllerToUser:responseObject];
    }];
}

-(void)toLoopView:(NSDictionary*)loopData{
    
    [_obj JumpLooperView:loopData];
}


-(void)MainChatEvent:(int)EventTag{
    
    if(EventTag==mainChatBackTag){
        [UIView animateWithDuration:0.3 animations:^{
            [moveView setFrame:CGRectMake(-DEF_SCREEN_WIDTH,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
            moveView=nil;
            backViewColor.alpha=0.0f;
            _effectView.alpha=0.0f;
        }];
    }else if(EventTag==mainAccountBackTag){
        [UIView animateWithDuration:0.3 animations:^{
            [moveView setFrame:CGRectMake(0,-DEF_SCREEN_HEIGHT, moveView.frame.size.width, moveView.frame.size.height)];
            moveView=nil;
            backViewColor.alpha=0.0f;
            _effectView.alpha=0.0f;
            [updataTimer invalidate];
            isTimerRun=true;
            updataTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updataMoveView) userInfo:nil repeats:YES];

        }];
    }
     [_obj hudOnClick:EventTag];
}


-(void)updataHeadImage{
    [looperImage  sd_setImageWithURL:[NSURL URLWithString:[LocalDataMangaer sharedManager].HeadImageUrl]];
}


-(void)createBackGround{
    
    isTimerRun=true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataHeadImage) name:@"updateHeadImage" object:nil];
    
    
    UIImage *mainBk = [UIImage imageNamed:@"mainBk.png"];
    imageOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mainBk.size.width*0.3*DEF_Adaptation_Font, mainBk.size.height*0.3*DEF_Adaptation_Font)];
    imageOne.image=mainBk;
    [self addSubview:imageOne];
    
    imageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(-1*mainBk.size.width*0.3*DEF_Adaptation_Font, 0, mainBk.size.width*0.3*DEF_Adaptation_Font, mainBk.size.height*0.3*DEF_Adaptation_Font)];
    imageTwo.image=mainBk;
    [self addSubview:imageTwo];
    
    UIImage *frontV = [UIImage imageNamed:@"mainFront.png"];
    frontView = [[UIImageView alloc] initWithFrame:CGRectMake(-frontV.size.width*0.3*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, frontV.size.width*0.3*DEF_Adaptation_Font, frontV.size.height*0.3*DEF_Adaptation_Font)];
    frontView.image = frontV;
    [self addSubview:frontView];
    
    UIImage *backV = [UIImage imageNamed:@"mainBack.png"];
    backView = [[UIImageView alloc] initWithFrame:CGRectMake(-backV.size.width*0.3*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, backV.size.width*0.3*DEF_Adaptation_Font, backV.size.height*0.3*DEF_Adaptation_Font)];
    backView.image = backV;
    [self addSubview:backView];
    
    UIImage *sideV = [UIImage imageNamed:@"icon_Side.png"];
    UIImageView * sideView = [[UIImageView alloc] initWithFrame:CGRectMake(0,997*0.3*DEF_Adaptation_Font, sideV.size.width*0.3*DEF_Adaptation_Font, sideV.size.height*0.3*DEF_Adaptation_Font)];
    sideView.image = sideV;
    [self addSubview:sideView];
    
    
    UIImage *bg1 = [UIImage imageNamed:@"bk_1.png"];
    UIImageView *bg1V = [[UIImageView alloc] initWithFrame:CGRectMake(0*0.3*DEF_Adaptation_Font,119*0.3*DEF_Adaptation_Font, bg1.size.width*0.3*DEF_Adaptation_Font, bg1.size.height*0.3*DEF_Adaptation_Font)];
    bg1V.image = bg1;
    [self addSubview:bg1V];
    
    UIImage *bg3 = [UIImage imageNamed:@"bk_3.png"];
    bg3V = [[UIImageView alloc] initWithFrame:CGRectMake(300*0.3*DEF_Adaptation_Font,996*0.3*DEF_Adaptation_Font, bg3.size.width*0.3*DEF_Adaptation_Font, bg3.size.height*0.3*DEF_Adaptation_Font)];
    bg3V.image = bg3;
    [self addSubview:bg3V];
    
    UIImage *bg4 = [UIImage imageNamed:@"bk_4.png"];
    bg4V = [[UIImageView alloc] initWithFrame:CGRectMake(85*0.3*DEF_Adaptation_Font,550*0.3*DEF_Adaptation_Font, bg4.size.width*0.3*DEF_Adaptation_Font, bg4.size.height*0.3*DEF_Adaptation_Font)];
    bg4V.image = bg4;
    [self addSubview:bg4V];

    looperBtn = [LooperToolClass createBtnImageName:@"btn_looper1.png" andRect:CGPointMake(217, 585) andTag:LopperBtnTag andSelectImage:nil andClickImage:nil
                                         andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:looperBtn];
    isLooperUp = true;

    DjBtn = [LooperToolClass createBtnImageName:@"icon_DJ.png" andRect:CGPointMake(384, 177) andTag:DJBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:DjBtn];
    isDJUp = false;
    activeBtn = [LooperToolClass createBtnImageName:@"btn_active.png" andRect:CGPointMake(26, 310) andTag:ActiveBtnTag andSelectImage:nil andClickImage:nil
                                         andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:activeBtn];
    isActiveUp = true;
#warning-在这里添加抽奖按钮
    UIButton *attendanceBtn = [LooperToolClass createBtnImageName:@"btn_attendance.png" andRect:CGPointMake(14, 948) andTag:55000 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(104, 98)  andTarget:self];
    [self addSubview:attendanceBtn];

    
    UIImage *bg2 = [UIImage imageNamed:@"bk_2.png"];
    UIImageView *bg2V = [[UIImageView alloc] initWithFrame:CGRectMake(93*0.3*DEF_Adaptation_Font,1200*0.3*DEF_Adaptation_Font, bg2.size.width*0.3*DEF_Adaptation_Font, bg2.size.height*0.3*DEF_Adaptation_Font)];
    bg2V.image = bg2;
    [self addSubview:bg2V];
    
    UIImage *planeV = [UIImage imageNamed:@"icon_plane.png"];
    planeView = [[UIImageView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2,DEF_SCREEN_HEIGHT/2, planeV.size.width*0.3*DEF_Adaptation_Font*0.7, planeV.size.height*0.3*DEF_Adaptation_Font*0.7)];
    planeView.image = planeV;
    [self addSubview:planeView];
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 40;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = 500;
    animation.removedOnCompletion = NO;
    [planeView.layer addAnimation:animation forKey:nil];
    
    planeUp = false;
    
    
    serachBtn = [LooperToolClass createBtnImageName:@"icon_serach.png" andRect:CGPointMake(0, 28) andTag:SearchBtnTag andSelectImage:nil andClickImage:nil
                                         andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:serachBtn];
    

    looperImage = [LooperToolClass createBtnImage:[LocalDataMangaer sharedManager].HeadImageUrl andRect:CGPointMake(532, 52) andTag:200 andSize:CGSizeMake(64, 64) andTarget:self];
    looperImage.layer.cornerRadius = 64*DEF_Adaptation_Font*0.5/2;
    looperImage.layer.masksToBounds = YES;
    [self addSubview:looperImage];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:120 animations:^{
            [frontView setFrame:CGRectMake(DEF_SCREEN_WIDTH, -frontView.frame.size.height, frontView.frame.size.width, frontView.frame.size.height)];
        } completion:^(BOOL finished) {
            [frontView setFrame:CGRectMake(-frontView.frame.size.width, DEF_SCREEN_WIDTH,  frontView.frame.size.width, frontView.frame.size.height)];
        }];
        
        
        [UIView animateWithDuration:160 animations:^{
            [backView setFrame:CGRectMake(DEF_SCREEN_WIDTH,-backView.frame.size.height, backView.frame.size.width,  backView.frame.size.height)];
        } completion:^(BOOL finished) {
            [backView setFrame:CGRectMake(-backView.frame.size.width, DEF_SCREEN_WIDTH,  backView.frame.size.width, backView.frame.size.height)];
        }];
    });
}


-(void)onClickImage:(UITapGestureRecognizer *)tap{
    
    
    [updataTimer invalidate];
    isTimerRun=false;
    
     directionNum = 3;
     moveView =userInfoView;
    [backViewColor setBackgroundColor:[UIColor colorWithRed:16/255.0 green:18/255.0 blue:30/255.0 alpha:1.0]];
    [UIView animateWithDuration:0.3 animations:^{
        [moveView setFrame:CGRectMake(0,0, moveView.frame.size.width, moveView.frame.size.height)];
        backViewColor.alpha=1.0f;
        _effectView.alpha=1.0f;
    }];
}


-(void)moveAction_Y:(UIView*)view andPosY:(int)num_y andisUp:(BOOL*)isUp andSpeed:(float)speed andHeight:(int)height{
    
    if(*isUp==true){
        view.frame = CGRectMake( view.frame.origin.x, view.frame.origin.y+speed, view.frame.size.width, view.frame.size.height);
        if(view.frame.origin.y+speed>num_y+height){
            *isUp = false;
        }
    }else if(*isUp==false){
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-speed, view.frame.size.width, view.frame.size.height);
        if(view.frame.origin.y-speed<num_y-height){
            *isUp = true;
        }
    }
}


-(void)initView{
    
    [self createBackGround];
    isTimerRun=true;
    updataTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updataMoveView) userInfo:nil repeats:YES];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _effectView.frame = CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    [self addSubview:_effectView];
    _effectView.alpha = 0.0f;
    
    
    backViewColor = [[UIView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    backViewColor.alpha=0.0f;
    [self addSubview:backViewColor];
   
    
    userInfoView =[[UserInfoView alloc] initWithFrame:CGRectMake(0,-DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andMyData:[[[_obj MainData] objectForKey:@"data"] objectForKey:@"User"]];
    [self addSubview:userInfoView];
    
    mainChatV =[[MainChatView alloc] initWithFrame:CGRectMake(-DEF_SCREEN_WIDTH,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andLoopData:[[_obj MainData] objectForKey:@"data"]];
    [self addSubview:mainChatV];
  
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    startLocation = [touch locationInView:self];
    moveLocation = startLocation;
    
    NSDate *now= [NSDate date];
    startDate = (long int)([now timeIntervalSince1970]*100);
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if(moveView!=nil){
        if(directionNum==1||directionNum==2){
            
            if(directionNum==1){
                if((moveView.frame.origin.x-(moveLocation.x-point.x))<0){
                    moveView.frame=CGRectMake(moveView.frame.origin.x-(moveLocation.x-point.x),moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height);
                }else{
                    moveView.frame=CGRectMake(0,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height);
                
                }
            }
            backViewColor.alpha = (moveView.frame.origin.x-(moveLocation.x-point.x) +DEF_SCREEN_WIDTH)/DEF_SCREEN_WIDTH;
            _effectView.alpha = ((moveView.frame.origin.x-(moveLocation.x-point.x) +DEF_SCREEN_WIDTH)/DEF_SCREEN_WIDTH) +0.3;
            
        }else if(directionNum==3||directionNum==4){
             if(moveView.frame.origin.y-(moveLocation.y-point.y)>0){
                  moveView.frame=CGRectMake( moveView.frame.origin.x, 0, moveView.frame.size.width, moveView.frame.size.height);
             }else{
              moveView.frame=CGRectMake( moveView.frame.origin.x, moveView.frame.origin.y-(moveLocation.y-point.y), moveView.frame.size.width, moveView.frame.size.height);
                 
             
             }

            backViewColor.alpha = (moveView.frame.origin.y-(moveLocation.y-point.y) +DEF_SCREEN_HEIGHT)/DEF_SCREEN_HEIGHT;
             _effectView.alpha =  ((moveView.frame.origin.y-(moveLocation.y-point.y) +DEF_SCREEN_HEIGHT)/DEF_SCREEN_HEIGHT) +0.3;
        }
    }else{
        double num_x =  fabs(startLocation.x-point.x);
        double num_y =  fabs(startLocation.y-point.y);
        if(num_y>5 || num_x>5){
            if(num_x>num_y){
                if(point.x>startLocation.x){
                    moveView =mainChatV;
                    directionNum = 1;
                    [backViewColor setBackgroundColor:[UIColor colorWithRed:133/255.0 green:92/255.0 blue:215/255.0 alpha:1.0]];
                    backViewColor.alpha=0.0f;
                    _effectView.alpha=0.0f;
                }else{
                    
                }
            }else{
                if(point.y>startLocation.y){
                    moveView =userInfoView;
                    directionNum = 3;
                    [backViewColor setBackgroundColor:[UIColor colorWithRed:16/255.0 green:18/255.0 blue:30/255.0 alpha:1.0]];
                     backViewColor.alpha=0.0f;
                     _effectView.alpha=0.0f;
                }else{
                
                }
                
            }
        }
    }
    moveLocation = point;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    endLocation = [touch locationInView:self];
    moveLocation= [touch locationInView:self];

    [self moveViewAction];
    
}

-(void)moveViewAction{
    
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]*100);
    NSLog(@"%ld",nowDate);
    NSLog(@"%ld",startDate);
    NSLog(@"%d",directionNum);
    NSLog(@"%f",startLocation.x);
    NSLog(@"%f",endLocation.x);
    
    if(moveView!=nil){
        if(directionNum==1||directionNum==2){
            if(directionNum==1){
                
                if(nowDate-startDate>200){
                    
                    if(moveView.frame.origin.x>-DEF_SCREEN_WIDTH/2){
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(0,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
                            backViewColor.alpha=1.0f;
                            _effectView.alpha=1.0f;
                        }];
                    }else{
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(-DEF_SCREEN_WIDTH,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
                            moveView=nil;
                            backViewColor.alpha=0.0f;
                             _effectView.alpha=0.0f;
                        }];
                    }
                }else{
                    if(startLocation.x>endLocation.x){
                        if(abs((int)startLocation.x-(int)endLocation.x)>10){
                        
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(-DEF_SCREEN_WIDTH,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
                            moveView=nil;
                            backViewColor.alpha=0.0f;
                            _effectView.alpha=0.0f;

                        }];
                        }else{
                            [UIView animateWithDuration:0.1 animations:^{
                                [moveView setFrame:CGRectMake(0,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
                                
                            }];
                        }
                    }else if(startLocation.x<endLocation.x){
                         if(abs((int)startLocation.x-(int)endLocation.x)>10){

                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(0,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
                            backViewColor.alpha=1.0f;
                            _effectView.alpha=1.0f;
                            
                        }];
                         }else{
                             [UIView animateWithDuration:0.1 animations:^{
                                 [moveView setFrame:CGRectMake(0,moveView.frame.origin.y, moveView.frame.size.width, moveView.frame.size.height)];
                                 
                             }];
                         }
                        
                    }
                }
                
            }else if(directionNum==2){
                
            }
        }else if(directionNum==3||directionNum==4){
            if(directionNum==3){
                
                if(nowDate-startDate>200){
                    
                    if(moveView.frame.origin.y>-DEF_SCREEN_HEIGHT/2){
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(0,0, moveView.frame.size.width, moveView.frame.size.height)];
                             [updataTimer invalidate];
                            isTimerRun=false;
                             backViewColor.alpha=1.0f;
                             _effectView.alpha=1.0f;
                           
                        }];
                    }else{
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(0,-DEF_SCREEN_HEIGHT, moveView.frame.size.width, moveView.frame.size.height)];
                            moveView=nil;
                            [updataTimer invalidate];
                            isTimerRun=true;
                              updataTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updataMoveView) userInfo:nil repeats:YES];
                            
                            backViewColor.alpha=0.0f;
                             _effectView.alpha=0.0f;
                        }];
                    }
                }else{
                    if(startLocation.y>endLocation.y){
                        
                       isTimerRun=true;
                        [updataTimer invalidate];
                        updataTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updataMoveView) userInfo:nil repeats:YES];
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(0,-DEF_SCREEN_HEIGHT, moveView.frame.size.width, moveView.frame.size.height)];
                            moveView=nil;
                             backViewColor.alpha=0.0f;
                             _effectView.alpha=0.0f;
                        }];
                        
                    }else{
                         isTimerRun=false;
                        [updataTimer invalidate];
                        [UIView animateWithDuration:0.3 animations:^{
                            [moveView setFrame:CGRectMake(0,0, moveView.frame.size.width, moveView.frame.size.height)];
                             backViewColor.alpha=1.0f;
                             _effectView.alpha=1.0f;
                        }];
                    
                    
                    }
                }
                
            }else if(directionNum==4){
                
                
                
            }
        
        }
    }
}


-(void)updataMoveView{

    if(imageTwo.frame.origin.x>DEF_SCREEN_WIDTH){
        imageTwo.frame= CGRectMake(imageOne.frame.origin.x-imageTwo.frame.size.width, imageTwo.frame.origin.y, imageTwo.frame.size.width, imageTwo.frame.size.height);
    }
    if(imageOne.frame.origin.x>DEF_SCREEN_WIDTH){
        imageOne.frame= CGRectMake(imageTwo.frame.origin.x-imageOne.frame.size.width, imageOne.frame.origin.y, imageOne.frame.size.width, imageOne.frame.size.height);
    }
    imageOne.frame = CGRectMake(imageOne.frame.origin.x+0.15, imageOne.frame.origin.y, imageOne.frame.size.width, imageOne.frame.size.height);
    imageTwo.frame = CGRectMake(imageTwo.frame.origin.x+0.15, imageTwo.frame.origin.y, imageTwo.frame.size.width, imageTwo.frame.size.height);
    
    if(planeView.frame.origin.x>DEF_SCREEN_WIDTH){
        planeView.frame = CGRectMake(-planeView.frame.size.width, DEF_SCREEN_HEIGHT/(rand()%5), planeView.frame.size.width,  planeView.frame.size.height);
    }else{
        planeView.frame = CGRectMake(planeView.frame.origin.x+0.05, planeView.frame.origin.y-0.05, planeView.frame.size.width,  planeView.frame.size.height);
    }
    
    [self moveAction_Y:activeBtn andPosY:310*0.5*DEF_Adaptation_Font andisUp:&(isActiveUp) andSpeed:0.05 andHeight:6];
    [self moveAction_Y:DjBtn andPosY:177*0.5*DEF_Adaptation_Font andisUp:&(isDJUp)andSpeed:0.045 andHeight:6];
    [self moveAction_Y:looperBtn andPosY:585*0.5*DEF_Adaptation_Font andisUp:&(isLooperUp)andSpeed:0.04 andHeight:10];
    [self moveAction_Y:bg3V andPosY:996*0.3*DEF_Adaptation_Font andisUp:&(isLooperUp)andSpeed:0.03 andHeight:10];
}





@end
