//
//  SerachView.m
//  Looper
//
//  Created by lujiawei on 1/4/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "looperView.h"
#import "looperViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "PlayerInfoView.h"
#import "LocalDataMangaer.h"
#import "FirstWaves.h"
#import "DataHander.h"
#import "SecondWaves.h"

#import <AVFoundation/AVFoundation.h>
#import "sildeView.h"
#import "UIImageView+WebCache.h"

#import "DBSphereView.h"

#import "LooperScorllLayer.h"


#define ARC4RANDOM_MAX  0x100000000



@implementation looperView {
    
    NSDictionary *loopData;
    
    UIImageView *bkView;
    
    UIButton *showBtn;
    
    UIButton *closeBtn;
    
    UIButton *followBtn;
    
    UIButton *aboutBtn;
    
    UIButton *sendBtn;
    
    UITextField* text;
    
    UIView *BarrageV;
    
    NSTimer *timeColor;
    
    UIImageView *tempImage;
    
    NSMutableArray *barrageArray;
    
    
    CGPoint startLocation;
    
    int touchType;
    
    BOOL touchBegin;
    
    BOOL endBegin;
    
    BOOL selectBool;
    
    bool isStop;
    
    UIButton *followHome;
    
    UIButton *btnHome;
    
    UIButton *meHome;
    
    DBSphereView *sphereView;
    
    NSMutableArray *looperMessageData;
    
    UIImageView *textFrame;
    
    int selectMessage;
    
    bool isShowTextField;
    
    bool closeStatus;
    
    UIView *firstWare;
    
    UIView *secondWare;
    
    NSString *SenderTargetId;
    NSString * SenderText;
    
    NSString * SenderMessage;
    
    NSMutableArray *featureArray;
    
    NSTimer *featureTimer;
    
    
    UIButton *openH5Btn;
    
    AVPlayer *_player;
    AVPlayerLayer *playerLayer;
    
    
    
    //UILabel *musicName;
    LooperScorllLayer *musicPlayer;
    
    LooperScorllLayer *musicName;
    
    
    UIImageView *musicPic;
    
    UIButton *followMusic;
    
    bool isPlay;
    
    int playIndex;
    
    UIButton *playMusicBtn;
    
    UIButton *ownerFollowBtn;
    
    UIImageView *iconMusicImage;
    
    
    NSMutableArray *hotChatArray;
    
    
}
@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
    }
    return self;
}



-(void)createBackGround{
    NSString *imagePath;
    UIImageView *bk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,700*0.5*DEF_Adaptation_Font, 700*0.5*DEF_Adaptation_Font)];
    if([[loopData objectForKey:@"Loop"] objectForKey:@"loopcover"]!=nil){
        imagePath = [[loopData objectForKey:@"Loop"] objectForKey:@"loopcover"];
        [bk sd_setImageWithURL:[[NSURL alloc] initWithString:imagePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }else{
        UIImage *defalut = [UIImage imageNamed:@"IMG_0748.jpg"];
        bk.image = defalut;
    }
    
    [self addSubview:bk];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0,700*0.5*DEF_Adaptation_Font, 700*0.5*DEF_Adaptation_Font);
    effectView.alpha=0.7f;
    [self addSubview:effectView];
}



-(void)initViewWith:(NSDictionary*)looperData{
    loopData = [[NSMutableDictionary alloc] initWithDictionary:looperData];
    
    isShowTextField = false;
    NSArray *musicArray = [loopData objectForKey:@"Music"];
    playIndex = 0;
    int indexMusic;
    if([musicArray count]>0){
        indexMusic = rand()%[musicArray count];
        playIndex=indexMusic;
    }
   
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    [self createBackGround];
    
    looperMessageData = [[NSMutableArray alloc] initWithCapacity:50];
    [self performSelector:@selector(createHudView) withObject:nil afterDelay:0.1];
    
    
    [self createBarrageView];
    
    touchType = 0;
    closeStatus = false;
    timeColor = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updatePos) userInfo:nil repeats:YES];
    barrageArray = [[NSMutableArray alloc] initWithCapacity:50];
    tempImage= nil;
    touchBegin = true;
    endBegin= true;
    selectBool = false;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerMusicEnd) name:AVPlayerItemDidPlayToEndTimeNotification  object:[_player currentItem]];
    
    [self performSelector:@selector(playMusic:) withObject:[[NSNumber alloc] initWithInt:playIndex] afterDelay:0.5];
    
}



-(void)playerMusicEnd{
    isPlay = true;
    [_player seekToTime:kCMTimeZero];
    
    [_player pause];
    [_player setRate:0];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    

    NSArray *musicArray = [loopData objectForKey:@"Music"];
    if([musicArray count]!=0)
    {
        [self playMusicNext];
    }
}


-(int)playMusicFront{
    isPlay = true;
    [_player seekToTime:kCMTimeZero];
    
    [_player pause];
    [_player setRate:0];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    NSArray *musicArray = [loopData objectForKey:@"Music"];
    
    if(playIndex-1<0){
        playIndex = [musicArray count]-1;
         [self playMusic:[[NSNumber alloc] initWithInt:playIndex]];
    }else{
        playIndex=playIndex-1;
        [self playMusic:[[NSNumber alloc] initWithInt:playIndex]];
    }
    [self updataMusicView:playIndex];
    return playIndex;
}


-(int)playMusicNext{
     isPlay = true;
    [_player seekToTime:kCMTimeZero];
    
    [_player pause];
    [_player setRate:0];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;

    NSArray *musicArray = [loopData objectForKey:@"Music"];
    
    if([musicArray count]-1<playIndex+1){
        playIndex=0;
        [self playMusic:[[NSNumber alloc] initWithInt:playIndex]];
    }else{
        playIndex = playIndex+1;
        if(playIndex<[musicArray count]-1){
        
         [self playMusic:[[NSNumber alloc] initWithInt:playIndex]];
        }
        
        
    }
    [self updataMusicView:playIndex];
    return playIndex;
}

-(void)playMusicAtIndex:(int)index{

    isPlay = true;
    [_player seekToTime:kCMTimeZero];
    
    [_player pause];
    [_player setRate:0];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    
    playIndex=index;
    
    [self playMusic:[[NSNumber alloc] initWithInt:playIndex]];
    [self updataMusicView:playIndex];


}


-(void)updataMusicView:(int)index{
    
    [playMusicBtn removeFromSuperview];
    [musicName removeFromSuperview];
    [musicPlayer removeFromSuperview];
    [iconMusicImage removeFromSuperview];
    
    
    
    NSArray *musicArray = [loopData objectForKey:@"Music"];
    
    if([musicArray count]!=0){

        NSDictionary *dic = [musicArray objectAtIndex:index];
        [musicPic removeFromSuperview];

        
        musicName = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(118*DEF_Adaptation_Font*0.5,1056*DEF_Adaptation_Font*0.5, 370*DEF_Adaptation_Font*0.5, 37*DEF_Adaptation_Font*0.5) and:self];
        [self addSubview:musicName];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:50];
        [array addObject:[dic objectForKey:@"filename"]];
        
        [musicName initView:CGRectMake(0,0, 370*DEF_Adaptation_Font*0.5, 37*DEF_Adaptation_Font*0.5) andStr:array andType:2];

        
        musicPlayer = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(118*DEF_Adaptation_Font*0.5,1100*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5,25*DEF_Adaptation_Font*0.5) and:self];
        [self addSubview:musicPlayer];
        NSMutableArray *arrayPlayer = [[NSMutableArray alloc] initWithCapacity:50];
        [arrayPlayer addObject:[dic objectForKey:@"artist"]];
        
        [musicPlayer initView:CGRectMake(0,0, 350*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5) andStr:arrayPlayer andType:3];


        
        
        [followMusic setHidden:false];
        
        
        if([[dic objectForKey:@"islike"] intValue]==1){
            [followMusic setSelected:true];
        }else{
            [followMusic setSelected:false];
            
        }
        if([[dic objectForKey:@"music_cover"] isEqualToString:@""]==true){
            [musicPic removeFromSuperview];
            musicPic = [[UIImageView alloc] initWithFrame:CGRectMake(39*DEF_Adaptation_Font*0.5, 1062*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
            musicPic.image=[UIImage imageNamed:@"default_music.png"];
            musicPic.layer.cornerRadius =54*DEF_Adaptation_Font*0.5/2;
            musicPic.layer.masksToBounds = YES;
            [self addSubview:musicPic];
            
        }else{
            musicPic = [[UIImageView alloc] initWithFrame:CGRectMake(39*DEF_Adaptation_Font*0.5, 1062*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
            musicPic.layer.cornerRadius =54*DEF_Adaptation_Font*0.5*0.5;
            musicPic.layer.masksToBounds = YES;
            
            [musicPic sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"music_cover"] ] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            [self addSubview:musicPic];
        }
        
        
        playMusicBtn = [LooperToolClass createBtnImageNameReal:@"small_parse.png" andRect:CGPointMake(39*DEF_Adaptation_Font*0.5, 1062*DEF_Adaptation_Font*0.5) andTag:9009 andSelectImage:@"small_play.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:playMusicBtn];

        [_obj updataMusicData:dic andIndex:playIndex];

        
    }else{
        
        UIImage *iconMusic =[UIImage imageNamed:@"icon_music.png"];
        iconMusicImage = [[UIImageView alloc] initWithFrame:CGRectMake(39*DEF_Adaptation_Font*0.5,1062*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
        iconMusicImage.image =iconMusic;
        [self addSubview:iconMusicImage];
        
        [musicName removeFromSuperview];
        [musicPlayer removeFromSuperview];
        [musicPic removeFromSuperview];
         [playMusicBtn removeFromSuperview];
        [followMusic setHidden:true];
        
    }
    
}


-(void)stopMusic{
    if(isPlay==true){
        [_player pause];
        [playMusicBtn setSelected:true];
        isPlay=false;
    }else if(isPlay==false){
          [_player play];
         [playMusicBtn setSelected:false];
        isPlay=true;
    }

}


-(void)playMusic:(NSNumber*)number{

    NSArray *musicArray = [loopData objectForKey:@"Music"];
    if([musicArray count]!=0){
        NSDictionary *dic = [musicArray objectAtIndex:[number intValue]];
        NSString *urlStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"path"]];
        urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url=[NSURL URLWithString:urlStr];
        
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        
        _player=[AVPlayer playerWithPlayerItem:playerItem];
        playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
         isPlay = true;
        [self.layer addSublayer:playerLayer];
        [_player play];
    }
}



-(void)updatePos{
    for (int i=0;i<[barrageArray count];i++){
        UIImageView *image = [barrageArray objectAtIndex:i];
        float num_x=0;
        if(image.frame.origin.y>239*DEF_Adaptation_Font*0.5){
            
            num_x = image.frame.origin.x -1.0f;
            image.frame = CGRectMake(num_x, image.frame.origin.y, image.frame.size.width, image.frame.size.height);
        }else{
            num_x = image.frame.origin.x -0.7f;
            image.frame = CGRectMake(num_x, image.frame.origin.y, image.frame.size.width, image.frame.size.height);
        }
        if(num_x<-200){
            [image removeFromSuperview];
            
            [barrageArray removeObjectAtIndex:i];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(touchBegin==true){
        touchBegin=false;
        UITouch *touch = [touches anyObject];
        startLocation = [touch locationInView:self];
        if(tempImage==nil){
            tempImage=nil;
            for (int i=0;i<[barrageArray count];i++){
                UIImageView *image = [barrageArray objectAtIndex:i];
                if(image.frame.origin.x<startLocation.x && startLocation.x<image.frame.origin.x+image.frame.size.width+210*DEF_Adaptation_Font*0.5){
                    if(image.frame.origin.y<startLocation.y && startLocation.y<image.frame.origin.y+image.frame.size.height){
                        tempImage = image;
                        
                        [barrageArray removeObjectAtIndex:i];
                        break;
                    }
                }
            }
            if(tempImage==nil){
                touchBegin=true;
            }
        }
    }
    if(isShowTextField==true){
        [self endEditing:YES];
        if(selectBool==false){
            
            if(touchBegin==false){
                touchBegin=true;
                endBegin=true;
                if(tempImage!=nil){
                    [barrageArray addObject:tempImage];
                    tempImage = nil;
                }
            }
        }
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* Point = [touches anyObject];
    CGPoint movePoint = [Point locationInView:self];
    int length =60;
    touchType = 5;
    
    if(tempImage!=nil){
        selectMessage = tempImage.tag;
    }
    if(fabs(startLocation.x-movePoint.x)>length){
        if(startLocation.x>movePoint.x){
            touchType =1;
        }else{
            touchType=2;
        }
    }
    if(fabs(startLocation.y-movePoint.y)>length){
        if(startLocation.y>movePoint.y){
            touchType =3;
        }else{
            touchType=4;
        }
    }
    
    [self checkMessageisLocalUser];
}




-(void)checkMessageisLocalUser{
    NSDictionary *messageData;
    for (NSDictionary *data in looperMessageData){
        if(selectMessage==[[data objectForKey:@"messageId"] intValue]){
            messageData = data;
            break;
        }
    }
    if([[[LocalDataMangaer sharedManager] uid]intValue]==[[messageData objectForKey:@"senderUserId"]intValue]){
        if(touchType==5 ||touchType==3){
            
        }else{
            touchType=5;
        }
    }
}


-(void)moveUpAction:(int)type{
    
    NSDictionary *messageData;
    
    for (NSDictionary *data in looperMessageData){
        if(selectMessage==[[data objectForKey:@"messageId"] intValue]){
            messageData = data;
            break;
        }
    }
    if(type==3){
        [_obj addPreferenceToCommentMessageId:[messageData objectForKey:@"messageId"] andlike:1 andTarget:[messageData objectForKey:@"senderUserId"] andMessageText:[messageData objectForKey:@"text"]];
        
        UIImage *image1 =[UIImage imageNamed:@"icon_looper_goodA1.png"];
        UIImageView *upImage = [[UIImageView alloc] initWithFrame:CGRectMake(100,100,
                                                                             image1.size.width*DEF_Adaptation_Font*0.3, image1.size.height*DEF_Adaptation_Font*0.3)];
        upImage.image =image1;
        [self addSubview:upImage];
        
        [UIView animateWithDuration:1 animations:^{
            upImage.frame = CGRectMake(upImage.frame.origin.x, upImage.frame.origin.y-100, upImage.frame.size.width, upImage.frame.size.height);
        } completion:^(BOOL finished) {
            [upImage removeFromSuperview];
        }];
        
    }else if(type==2){
        [_obj followUser:[messageData objectForKey:@"senderUserId"]];
        UIImage *image2 =[UIImage imageNamed:@"icon_looper_followA1.png"];
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(100,100, image2.size.width*DEF_Adaptation_Font*0.3, image2.size.height*DEF_Adaptation_Font*0.3)];
        rightImage.image =image2;
        [self addSubview:rightImage];
        
        [UIView animateWithDuration:1 animations:^{
            rightImage.frame = CGRectMake(rightImage.frame.origin.x+100, rightImage.frame.origin.y, rightImage.frame.size.width, rightImage.frame.size.height);
        } completion:^(BOOL finished) {
            [rightImage removeFromSuperview];
        }];
        
    }
}


-(void)addTextUserName{
    NSDictionary *messageData;
    
    for (NSDictionary *data in looperMessageData){
        if(selectMessage==[[data objectForKey:@"messageId"] intValue]){
            messageData = data;
            break;
        }
    }
    SenderTargetId = [messageData objectForKey:@"senderUserId"];
    SenderText= [messageData objectForKey:@"text"];
    SenderMessage = [messageData objectForKey:@"messageId"];
    
    text.text = [NSString stringWithFormat:@"@%@:",[messageData objectForKey:@"name"]];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =  [touches anyObject];
    if(touchBegin == false){
        if(selectBool ==true){
            [self removeAll];
        }
    }
    if(tempImage!=nil){
        if(endBegin==true){
            endBegin = false;
            if(touchType==3){
                if(tempImage!=nil){
                    [barrageArray addObject:tempImage];
                    
                    endBegin=true;
                    touchBegin=true;
                    tempImage = nil;
                    [self moveUpAction:touchType];
                }
            }else if(touchType==2){
                if(tempImage!=nil){
                    [barrageArray addObject:tempImage];
                    endBegin=true;
                    touchBegin=true;
                    tempImage = nil;
                    [self moveUpAction:touchType];
                }
            }else if(touchType==1){
                [self createSelectView];
            }else if(touchType==4){
                [text becomeFirstResponder];
                [self addTextUserName];
                //[barrageArray addObject:tempImage];
            }else if(touchType==5){
                if(tempImage!=nil){
                    if(isStop==false){
                        isStop=true;
                        endBegin=true;
                        touchBegin=true;
                    }else{
                        endBegin=true;
                        touchBegin=true;
                        [barrageArray addObject:tempImage];
                        tempImage=nil;
                        isStop=false;
                    }
                }else{
                    endBegin=true;
                    touchBegin=true;
                    tempImage = nil;
                }
            }else if(touchType==nil){
                endBegin=true;
                touchBegin=true;
              //  [self endEditing:true];
            }
        }else if(endBegin==false){
            [self endEditing:true];
           
            SenderTargetId = nil;
            SenderText= nil;
            SenderMessage = nil;
            
            endBegin=true;
            touchBegin=true;
            text.text=@"";
             [barrageArray addObject:tempImage];
        
               tempImage = nil;
        }
    }else{
         text.text=@"";
        [self endEditing:true];
        tempImage = nil;
        
    
    }
    
    touchType=nil;
    
    
    
}



-(void)createSelectView{
    touchBegin=false;
    selectBool=true;
    
    btnHome = [LooperToolClass createBtnImageName:@"icon_looper_me.png" andRect:CGPointMake(-45+tempImage.frame.origin.x*2.0/DEF_Adaptation_Font,49+tempImage.frame.origin.y*2.0/DEF_Adaptation_Font) andTag:301 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:btnHome];
    
    meHome = [LooperToolClass createBtnImageName:@"icon_looper_home.png" andRect:CGPointMake(-45+tempImage.frame.origin.x*2.0/DEF_Adaptation_Font,-49+tempImage.frame.origin.y*2.0/DEF_Adaptation_Font) andTag:302 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:meHome];
    
    followHome = [LooperToolClass createBtnImageName:@"icon_looper_follow.png" andRect:CGPointMake(-90+tempImage.frame.origin.x*2.0/DEF_Adaptation_Font,0+tempImage.frame.origin.y*2.0/DEF_Adaptation_Font) andTag:303 andSelectImage:nil andClickImage:nil  andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:followHome];
    
}


-(void)onClickImage:(UITapGestureRecognizer *)tap{

    
    UIImageView *v = (UIImageView*)tap.view;
    
    for (int i=0;i<[barrageArray count];i++){
        UIImageView *image = [barrageArray objectAtIndex:i];
        if(v==image){
            [barrageArray removeObjectAtIndex:i];
            
        }
    }
}


-(void)FeaturedUpdata:(NSDictionary*)FeatureData{
    featureArray =  [FeatureData objectForKey:@"data"];
    
    hotChatArray = [[NSMutableArray alloc] initWithCapacity:50];
    [hotChatArray removeAllObjects];
    for (int i =0;i<[featureArray count];i++){
        NSDictionary *dic = [featureArray objectAtIndex:i];
        if([[dic objectForKey:@"thumbupcount"] intValue]>0){
            [hotChatArray addObject:dic];
        }
    }

    if([hotChatArray count]!=0){
        if(featureTimer==nil){
            [featureTimer invalidate];
            featureTimer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(updateFeaturedShowLable) userInfo:nil repeats:true];
        }
    }
}

-(void)updateFeaturedShowLable{
    int featureCount = [hotChatArray count];
    if (featureCount!=0) {
        int randN;
        if(featureCount==1){
            randN =0;
        }else{
            randN= (arc4random() % (featureCount-1)) + 0;
        }
        NSMutableDictionary *senderDic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [senderDic setObject:[[hotChatArray objectAtIndex:randN] objectForKey:@"messagecontent"] forKey:@"text"];
        [senderDic setObject:[[hotChatArray objectAtIndex:randN] objectForKey:@"yunxinid"] forKey:@"messageId"];
        [senderDic setObject:[[hotChatArray objectAtIndex:randN] objectForKey:@"userid"] forKey:@"senderUserId"];
        [senderDic setObject:[[hotChatArray objectAtIndex:randN] objectForKey:@"headimageurl"] forKey:@"HeadImageUrl"];
        
        [senderDic setObject:[[hotChatArray objectAtIndex:randN] objectForKey:@"nickname"] forKey:@"name"];

        NSDate *now= [NSDate date];
        long int nowDate = (long int)([now timeIntervalSince1970]);
        [senderDic setObject:[[NSNumber alloc] initWithLong:nowDate] forKey:@"sentTime"];
        [self ReceiveMessage:2 andData:senderDic];
        
    }
}

-(void)removeMusic{
    [featureTimer invalidate];
    
    isPlay = false;
    [_player seekToTime:kCMTimeZero];
    [_player pause];
    [_player setRate:0];
    [_player replaceCurrentItemWithPlayerItem:nil];
    _player = nil;
    
   // [self removeAll];
    
}





-(void)updataData:(NSDictionary*)looperDataSource andType:(int)type{

    loopData = [[NSMutableDictionary alloc] initWithDictionary:looperDataSource];

    if(type==2){
        [self updataMusicView:playIndex];
    }else if(type==1){
        isPlay = false;
        [_player seekToTime:kCMTimeZero];
        [_player pause];
        [_player setRate:0];
        [_player replaceCurrentItemWithPlayerItem:nil];
        _player = nil;
        playIndex=0;
        [self updataMusicView:playIndex];
        
        [self playMusic:[[NSNumber alloc] initWithInt:playIndex]];
    
    }
    
}

//type 2 精选
//type 1 实时
-(void)ReceiveMessage:(int)type andData:(NSDictionary*)data{
    
    if(closeStatus==false){
        
        
        [looperMessageData addObject:data];
        
        int randN;
        randN= (arc4random() % 7);

        int num_y = 115;
        if(randN==0){
            num_y = 115;
        }else if(randN==1){
            num_y = 177;
        }else if(randN==2){
            num_y = 239;
        }else if(randN==3){
            num_y = 305;
        }else if(randN==4){
            num_y = 367;
        }else if(randN==5){
            num_y = 429;
        }else if(randN==6){
            num_y = 491;
        }else if(randN>6){
            num_y = 491;
        }
        
        UIImageView *yellowV;
        
     
        yellowV = [[UIImageView alloc] initWithFrame:CGRectMake(800*DEF_Adaptation_Font*0.5, num_y*DEF_Adaptation_Font*0.5, 59*DEF_Adaptation_Font*0.5, 59*DEF_Adaptation_Font*0.5)];
        [yellowV setBackgroundColor:[UIColor clearColor]];
        
        yellowV.layer.cornerRadius =59*DEF_Adaptation_Font*0.5*0.5;
        yellowV.tag = [[data objectForKey:@"messageId"] intValue];

        [self addSubview:yellowV];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(3*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5, 53*DEF_Adaptation_Font*0.5)];
        imageV.layer.cornerRadius =53*DEF_Adaptation_Font*0.5*0.5;
        imageV.layer.masksToBounds = YES;
        
        [imageV sd_setImageWithURL:[[NSURL alloc] initWithString:[data objectForKey:@"HeadImageUrl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        int num_w;
        num_w = [self computeLableLength:[data objectForKey:@"text"]];
  
        UIImageView *labelBk  = [[UIImageView alloc] initWithFrame:CGRectMake(11*DEF_Adaptation_Font*0.5, 3*DEF_Adaptation_Font*0.5,num_w+52*DEF_Adaptation_Font_x*0.5,  53*DEF_Adaptation_Font*0.5)];
        [labelBk setBackgroundColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:35/255.0 alpha:0.3]];
        
        labelBk.layer.cornerRadius =53*DEF_Adaptation_Font*0.5/2;
        
        [yellowV addSubview:labelBk];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(52*DEF_Adaptation_Font_x*0.5,0*DEF_Adaptation_Font*0.5, 415*DEF_Adaptation_Font_x*0.5, 53*DEF_Adaptation_Font*0.5)];

        label.text =[data objectForKey:@"text"];
        label.textAlignment = NSTextAlignmentLeft;
        label.font  = [UIFont fontWithName:looperFont size:15*DEF_Adaptation_Font];
        

        
        label.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
        
        int start = 0;
        int end = 0;
        NSString *content = label.text;
        for (int i = 0; i < content.length; i ++) {
            //这里的小技巧，每次只截取一个字符的范围
            NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
            if ([a isEqualToString:@"@"]==true) {
                start = i;
            }
            if ([a isEqualToString:@":"]==true) {
                end = i;
            }
            
        }
        
        
        if(type==2){
            int colorRand= (arc4random() % 3);
            if(colorRand==2){
                label.textColor = [UIColor colorWithRed:69/255.0 green:217/255.0 blue:193/255.0 alpha:1.0];
            } else if(colorRand==1){
                label.textColor = [UIColor colorWithRed:193/255.0 green:140/255.0 blue:252/255.0 alpha:1.0];
            }else {
                label.textColor = [UIColor colorWithRed:120/255.0 green:244/255.0 blue:56/255.0 alpha:1.0];
            }
        }
        
        
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
        [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:15*DEF_Adaptation_Font],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(start, end)];
        //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
        label.attributedText = attributeString;
        [labelBk addSubview:label];
        [yellowV addSubview:imageV];
        
        [barrageArray addObject:yellowV];
    }
}


-(float)computeLableLength:(NSString*)lableStr{
    
    float num_x = 30*DEF_Adaptation_Font_x*0.5;
    NSString *perchar;
    int alength = [lableStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [lableStr characterAtIndex:i];
        NSString *temp = [lableStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x +30*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +17*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +17*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +17*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +17*DEF_Adaptation_Font_x*0.5;
        }
    }
    
    if(num_x>430*DEF_Adaptation_Font_x*0.5){
        num_x=430*DEF_Adaptation_Font_x*0.5;
    }
    
    return num_x;
    
}

-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(3,0,  rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor grayColor];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    textField.enablesReturnKeyAutomatically = YES;
    textField.returnKeyType = UIReturnKeySend;
    
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    return textField;
}

-(void)createBarrageView{
    
    BarrageV = [[UIView alloc] initWithFrame:CGRectMake(0, 115*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH, 432*DEF_Adaptation_Font*0.5)];
    [self addSubview:BarrageV];
    
}

-(void)createHudView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
    [self addSubview:backBtn];
    
    bkView = [[UIImageView alloc] initWithFrame:CGRectMake(0,614*DEF_Adaptation_Font*0.5,DEF_SCREEN_WIDTH,422*DEF_Adaptation_Font*0.5)];
    [bkView setBackgroundColor:[UIColor colorWithRed:40/255.0 green:45/255.0 blue:65/255.0 alpha:1.0]];
    [self addSubview:bkView];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,32*DEF_Adaptation_Font*0.5) andTag:299 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];
    
    UIImageView *chatbK=[LooperToolClass createImageViewReal:@"bg_chat_bk.png" andRect:CGPointMake(0,548*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH, 67*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:chatbK];

    
    UIImageView *localUser = [[UIImageView alloc] initWithFrame:CGRectMake(28*DEF_Adaptation_Font*0.5, 560*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5, 42*DEF_Adaptation_Font*0.5)];
    localUser.layer.cornerRadius =42*DEF_Adaptation_Font*0.5*0.5;
    localUser.layer.masksToBounds = YES;
    
    [localUser sd_setImageWithURL:[[NSURL alloc] initWithString:[LocalDataMangaer sharedManager].HeadImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self addSubview:localUser];


    text=[self createTextField:@"  想什么呢 来聊聊" andImg:@"bg_looper_chat.png" andRect:CGRectMake(88*DEF_Adaptation_Font*0.5,560*DEF_Adaptation_Font*0.5,392*DEF_Adaptation_Font*0.5,41*DEF_Adaptation_Font*0.5) andTag:1001];
    
    UILabel *looperName = [LooperToolClass createLableView:CGPointMake(38*DEF_Adaptation_Font*0.5,627*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(563*DEF_Adaptation_Font*0.5,97*DEF_Adaptation_Font*0.5) andText:[[loopData objectForKey:@"Loop"] objectForKey:@"looptitle"] andFontSize:21 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
   [self addSubview:looperName];
    
  
    UIButton *BtnMusic = [LooperToolClass createBtnImageNameReal:@"bg_looper_down.png" andRect:CGPointMake(0,1036*DEF_Adaptation_Font*0.5) andTag:900 andSelectImage:@"bg_looper_down.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(DEF_SCREEN_WIDTH,100*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:BtnMusic];

    
    UIImageView *looper_owner=[LooperToolClass createImageViewReal:@"bg_looper_owner.png" andRect:CGPointMake(38*DEF_Adaptation_Font*0.5,873*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(564*DEF_Adaptation_Font*0.5, 22*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:looper_owner];

    UILabel *looperOwner= [LooperToolClass createLableView:CGPointMake(114*DEF_Adaptation_Font*0.5,(845+93)*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(303*DEF_Adaptation_Font*0.5,29*DEF_Adaptation_Font*0.5) andText:[[loopData objectForKey:@"Owner"] objectForKey:@"nickname"] andFontSize:15 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.78] andType:NSTextAlignmentLeft];
    [self addSubview:looperOwner];

    
    UILabel *looperFans= [LooperToolClass createLableView:CGPointMake(114*DEF_Adaptation_Font*0.5,(882+93)*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(140*DEF_Adaptation_Font*0.5,26*DEF_Adaptation_Font*0.5) andText:[NSString stringWithFormat:@"粉丝：%@",[[loopData objectForKey:@"Owner"] objectForKey:@"fanscount"]] andFontSize:13 andColor:[UIColor colorWithRed:221/255.0 green:225/255.0 blue:238/255.0 alpha:0.70] andType:NSTextAlignmentLeft];
    [self addSubview:looperFans];
    
    if([[loopData objectForKey:@"Loop"] objectForKey:@"news_tag"]!=[NSNull null]){
    
        LooperScorllLayer *sildeV = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(85*DEF_Adaptation_Font*0.5, 720*DEF_Adaptation_Font*0.5, 470*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5) and:self];
        [self addSubview:sildeV];
        
        [sildeV initView:CGRectMake(0,0, 470*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5) andStr:[[[loopData objectForKey:@"Loop"] objectForKey:@"news_tag"] componentsSeparatedByString:@","] andType:1];
    }
    
    
    
    
    
    UIImageView * looperPic =[LooperToolClass createBtnImage:[[loopData objectForKey:@"Owner"] objectForKey:@"headimageurl"] andRect:CGPointMake(39, 938) andTag:1000 andSize:CGSizeMake(59, 59) andTarget:self];
    [self addSubview:looperPic];
    looperPic.layer.cornerRadius =59*DEF_Adaptation_Font*0.5*0.5;
    looperPic.layer.masksToBounds = YES;

    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickOwn:)];
    [looperPic addGestureRecognizer:singleTap];
    
    [self createMusicBK];
    
    UIButton *userList = [LooperToolClass createBtnImageNameReal:@"btn_userList.png" andRect:CGPointMake(503*DEF_Adaptation_Font*0.5,549*DEF_Adaptation_Font*0.5) andTag:901 andSelectImage:@"btn_userList.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(58*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:userList];

    
    UIButton *chatList = [LooperToolClass createBtnImageNameReal:@"btn_chatList.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,549*DEF_Adaptation_Font*0.5) andTag:902 andSelectImage:@"btn_chatList.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(56*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:chatList];

    if([loopData[@"isFollow"] intValue]==0){
        if([[LocalDataMangaer sharedManager].uid isEqualToString:[[loopData objectForKey:@"Owner"] objectForKey:@"userid"]]==false){
            followBtn = [LooperToolClass createBtnImageNameReal:@"btn_addLoop.png" andRect:CGPointMake(212*DEF_Adaptation_Font*0.5,799*DEF_Adaptation_Font*0.5) andTag:105 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(217*DEF_Adaptation_Font*0.5,47*DEF_Adaptation_Font*0.5) andTarget:self];
            [self addSubview:followBtn];
        }
    }
    
    if([[LocalDataMangaer sharedManager].uid isEqualToString:[[loopData objectForKey:@"Owner"] objectForKey:@"userid"]]==false){
        
        ownerFollowBtn = [LooperToolClass createBtnImageNameReal:@"ownerFollow.png" andRect:CGPointMake(475*DEF_Adaptation_Font*0.5,936*DEF_Adaptation_Font*0.5) andTag:1009 andSelectImage:@"owenFollowed.png"andClickImage:nil andTextStr:nil andSize:CGSizeMake(144*DEF_Adaptation_Font*0.5,63*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:ownerFollowBtn];

        
        if([loopData[@"isFollowOwner"] intValue]==0){
            [ownerFollowBtn setSelected:false];
        }else{
            [ownerFollowBtn setSelected:true];
        }
    }
}

-(void)onClickOwn:(UITapGestureRecognizer *)tap{
    
    if(tap.view.tag==1000){
        [_obj createPlayerView:[loopData objectForKey:@"Owner"]];
    }
}

-(void)createMusicBK{
    
    NSArray *musicArray = [loopData objectForKey:@"Music"];
    if([musicArray count]!=0){
        NSDictionary *dic = [musicArray objectAtIndex:playIndex];
        
        
        
        musicName = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(118*DEF_Adaptation_Font*0.5,1056*DEF_Adaptation_Font*0.5, 370*DEF_Adaptation_Font*0.5, 37*DEF_Adaptation_Font*0.5) and:self];
        [self addSubview:musicName];
        NSMutableArray *arrayName = [[NSMutableArray alloc] initWithCapacity:50];
        [arrayName addObject:[dic objectForKey:@"filename"]];
        
        [musicName initView:CGRectMake(0,0, 370*DEF_Adaptation_Font*0.5, 37*DEF_Adaptation_Font*0.5) andStr:arrayName andType:2];

        
        
        musicPlayer = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(118*DEF_Adaptation_Font*0.5,1100*DEF_Adaptation_Font*0.5, 350*DEF_Adaptation_Font*0.5,25*DEF_Adaptation_Font*0.5) and:self];
        [self addSubview:musicPlayer];
        NSMutableArray *arrayPlayer = [[NSMutableArray alloc] initWithCapacity:50];
        [arrayPlayer addObject:[dic objectForKey:@"artist"]];
        
        [musicPlayer initView:CGRectMake(0,0, 350*DEF_Adaptation_Font*0.5, 25*DEF_Adaptation_Font*0.5) andStr:arrayPlayer andType:3];
        

        
        
        followMusic = [LooperToolClass createBtnImageNameReal:@"btn_unfollowMusic.png" andRect:CGPointMake(480*DEF_Adaptation_Font*0.5,1050*DEF_Adaptation_Font*0.5) andTag:1000 andSelectImage:@"btn_followMusic.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(49*DEF_Adaptation_Font*0.5,70*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:followMusic];
        
        if([[dic objectForKey:@"islike"] intValue]==1){
            [followMusic setSelected:true];
        }
        
        if([[dic objectForKey:@"music_cover"] isEqualToString:@""]==true){
            [musicPic removeFromSuperview];
            musicPic = [[UIImageView alloc] initWithFrame:CGRectMake(39*DEF_Adaptation_Font*0.5, 1062*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
            musicPic.image=[UIImage imageNamed:@"default_music.png"];
            musicPic.layer.cornerRadius =54*DEF_Adaptation_Font*0.5/2;
            musicPic.layer.masksToBounds = YES;
            [self addSubview:musicPic];
            
        }else{
            musicPic = [[UIImageView alloc] initWithFrame:CGRectMake(39*DEF_Adaptation_Font*0.5, 1062*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
            musicPic.layer.cornerRadius =54*DEF_Adaptation_Font*0.5*0.5;
            musicPic.layer.masksToBounds = YES;
            
            [musicPic sd_setImageWithURL:[[NSURL alloc] initWithString:[dic objectForKey:@"music_cover"] ] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            [self addSubview:musicPic];
        }
        
        playMusicBtn = [LooperToolClass createBtnImageNameReal:@"small_parse.png" andRect:CGPointMake(39*DEF_Adaptation_Font*0.5, 1062*DEF_Adaptation_Font*0.5) andTag:9009 andSelectImage:@"small_play.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:playMusicBtn];

        
    }else{
        UIImage *iconMusic =[UIImage imageNamed:@"icon_music.png"];
        iconMusicImage = [[UIImageView alloc] initWithFrame:CGRectMake(39*DEF_Adaptation_Font*0.5,1062*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5)];
        iconMusicImage.image =iconMusic;
        [self addSubview:iconMusicImage];
    }

    
    
    
    UIButton *MusicList = [LooperToolClass createBtnImageNameReal:@"btn_loop_list.png" andRect:CGPointMake(561*DEF_Adaptation_Font*0.5,1050*DEF_Adaptation_Font*0.5) andTag:909 andSelectImage:@"btn_loop_list.png" andClickImage:nil andTextStr:nil andSize:CGSizeMake(49*DEF_Adaptation_Font*0.5,70*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:MusicList];
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{


}

-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    

}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    
  }


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([text.text isEqualToString:@""]==false){
        
        [_obj sendMessage:text.text andTarget:SenderTargetId andReplyMessageId:SenderMessage andReplayMessageText:SenderText];
        text.text = @"";
    }
    [self endEditing:YES];
    
    if(barrageArray!=nil){
        if(tempImage!=nil){
        [barrageArray addObject:tempImage];
        }
    }
    
    return YES;
}

/**
 结束编辑UITextField的方法，让原来的界面还原高度
 */
-(void) textFieldDidEndEditing:(UITextField *)textField{
    

}


-(void)removeAll{
    [followHome removeFromSuperview];
    [btnHome removeFromSuperview];
    [meHome removeFromSuperview];
    endBegin=true;
    touchBegin=true;
    selectBool=false;
    if(tempImage!=nil){
        [barrageArray addObject:tempImage];
        tempImage = nil;
    }
    
//    for (int i=0;i<[barrageArray count];i++){
//    
//        UIView *view = [barrageArray objectAtIndex:i];
//        [view removeFromSuperview];
//    
//    
//    }
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==101){
        if(closeStatus ==true){
            closeStatus =false;
            [[DataHander sharedDataHander] showView:@"closeOff.png" andTime:1 andPos:CGPointMake(141*DEF_Adaptation_Font_x*0.5, 431*DEF_Adaptation_Font*0.5)];
            [closeBtn setSelected:false];
        }else {
            closeStatus =true;
            [closeBtn setSelected:true];
            [[DataHander sharedDataHander] showView:@"closeOn.png" andTime:1 andPos:CGPointMake(141*DEF_Adaptation_Font_x*0.5, 431*DEF_Adaptation_Font*0.5)];
            
        }
    }else if(button.tag==102){
        
        // [_obj shareH5];
    }else if(button.tag==100){
        [_player seekToTime:kCMTimeZero];
        
        [_player pause];
        [_player setRate:0];
        [_player replaceCurrentItemWithPlayerItem:nil];
        _player = nil;
        
        [_obj popController];
    }else if(button.tag==1000){
        NSArray *musicArray = [loopData objectForKey:@"Music"];
        if([button isSelected]==true){
        
            [button setSelected:false];
            if([musicArray count]!=0){
                NSDictionary *dic = [musicArray objectAtIndex:playIndex];
                [_obj addToFavorite:[dic objectForKey:@"fileid"] andisLike:0];

            }
        }else{
             [button setSelected:true];
            if([musicArray count]!=0){
                NSDictionary *dic = [musicArray objectAtIndex:playIndex];
                [_obj addToFavorite:[dic objectForKey:@"fileid"] andisLike:1];
            }
        }
        
        
    }else if(button.tag==119){
        
        [_obj createLooperChatV];
        
    }else if(button.tag==105){
        
        if([loopData[@"isFollow"] intValue]==1){
            [loopData setValue:[[NSNumber alloc] initWithInt:0] forKey:@"isFollow"];
            [_obj unfollowLoop];
            [followBtn removeFromSuperview];
        }else{
            [_obj followLoop];
            [followBtn removeFromSuperview];
        }
    }else if(button.tag==109){
        
        
    }else if(button.tag==400){
       // -(void)jumpToH5:(NSDictionary*)h5Data
        NSDictionary *H5Dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [H5Dic setValue:[loopData objectForKey:@"ContentURL"] forKey:@"H5Url"];
        [H5Dic setValue:[loopData objectForKey:@"LoopDescription"] forKey:@"LoopDescription"];
        [H5Dic setValue:[loopData objectForKey:@"LoopName"] forKey:@"LoopName"];
        [H5Dic setValue:[loopData objectForKey:@"ActivityIconImage"] forKey:@"LoopImage"];
        [H5Dic setValue:loopData[@"isFollow"] forKey:@"isFollow"];
        [_obj jumpToH5:H5Dic];
    }else if(button.tag==110){
        [_obj createLooperDeatail];
        
    }else if(button.tag==301){
        [self removeAll];
        [self actionWithType:301];
    }else if(button.tag==302){
        [self removeAll];
        [self actionWithType:302];
    }else if(button.tag==303){
        [self removeAll];
        [self actionWithType:303];
    }else if(button.tag ==299){
        
        [_obj shareH5];
        
    }else if(button.tag ==900){
    
        [_obj toMusicView:playIndex andIsPlay:isPlay];
            
    }else if(button.tag ==901){
        
        [_obj addUserView];
        
    }else if(button.tag ==902){
        [_obj createLooperChatV];
    }else if(button.tag ==909){
        [_obj addMusicListView];
    }else if(button.tag ==1009){
        if([ownerFollowBtn isSelected]==true){
            [ownerFollowBtn setSelected:false];
            [_obj unfollowUser:[[loopData objectForKey:@"Owner"] objectForKey:@"userid"]];
            
        }else{
            [ownerFollowBtn setSelected:true];
            [_obj followUser:[[loopData objectForKey:@"Owner"] objectForKey:@"userid"]];
        }
    }else if(button.tag ==9009){
        if([playMusicBtn isSelected]==true){
        
            [playMusicBtn setSelected:false];
            [self stopMusic];
        }else {
            [playMusicBtn setSelected:true];
             [self stopMusic];
        
        }
    }

}

-(void)updatefollow{

}


-(void)actionWithType:(int)btnTag{
    NSDictionary *messageData;
    for (NSDictionary *data in looperMessageData){
        if(selectMessage==[[data objectForKey:@"messageId"] intValue]){
            messageData = data;
            break;
        }
    }
    
    if(btnTag==301){
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:[messageData objectForKey:@"senderUserId"] forKey:@"userid"];
        [self createPlayerView:dic];
        
    }else if(btnTag ==302){
        
        
        
    }else if(btnTag ==303){
        
        UIImage *image2 =[UIImage imageNamed:@"icon_looper_followA1.png"];
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(100,100, image2.size.width*DEF_Adaptation_Font*0.3, image2.size.height*DEF_Adaptation_Font*0.3)];
        rightImage.image =image2;
        [self addSubview:rightImage];
        
        [UIView animateWithDuration:1 animations:^{
            rightImage.frame = CGRectMake(rightImage.frame.origin.x+100, rightImage.frame.origin.y, rightImage.frame.size.width, rightImage.frame.size.height);
        } completion:^(BOOL finished) {
            [rightImage removeFromSuperview];
        }];
        [_obj followUser:[messageData objectForKey:@"senderUserId"]];
    }
    
}



-(void)createPlayerView:(NSDictionary*)looperData{
    
    [_obj createPlayerView:looperData];
    
}



@end
