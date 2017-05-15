//
//  StartView.m
//  Looper
//
//  Created by lujiawei on 12/6/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "StartView.h"
#import "StartViewModel.h"
#import "LooperConfig.h"
#import "UIImage+RTTint.h"
#import "DKPlayerBar.h"
#import "UIImageView+WebCache.h"



@implementation StartView{

    AVPlayerLayer*playerLayer;

    UIButton *play_button;
    
    UIImageView *playMusicIcon;
    
    bool isPlay;
    
    NSTimer * avTimer;
    
    DKPlayerBar *playerBar;
    
    NSArray *array;
    
    CGPoint originalLocation;
    
    CGPoint endLocation;
    
    
    UIImageView *bk ;
    
    UIVisualEffectView *effectView;
    
    UIImageView *diskV;
    
    UILabel *musicsinger;
    
    UILabel *musicName;
    
    UIImageView *frame;
    
    NSTimer *timeColor;
    
    double i;
    
    double colorNum;
    
    int musicCount;
    
    NSMutableArray *resultArray;
    
    NSString *currentId;
    
    
    UIImageView *likeBtn;
    
    UIImageView *unlikeBtn;
    
    
    UIImage *likeV;
    
    UIImage *unlike;
    
    
    bool isFinish;
}


@synthesize obj = _obj;
@synthesize player = _player;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andArray:(NSMutableArray*)ListArray
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (StartViewModel*)idObject;
        array  = ListArray;
        musicCount = 0;
        resultArray = [[NSMutableArray alloc] initWithCapacity:50];
        [self initView:musicCount];
    }
    return self;
}


-(void)dealloc{
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
}



-(void)initView:(int)num{
     colorNum = 0.01f;
    isFinish = false;
    [self createBackGround:[array objectAtIndex:num]];
  
}


-(void)createBackGround:(NSDictionary*)songDic{
    currentId = [songDic objectForKey:@"MusicID"];
    
    bk = [[UIImageView alloc] initWithFrame:CGRectMake(-(DEF_SCREEN_WIDTH/2),0,DEF_SCREEN_WIDTH+DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [self addSubview:bk];
    
    [bk sd_setImageWithURL:[songDic objectForKey:@"MusicCoverUrl"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
        
        [self addSubview:effectView];
        
        [self createItemView:[songDic objectForKey:@"MusicUrl"] andMusicPic:[songDic objectForKey:@"MusicCoverUrl"] andMusicName:[songDic objectForKey:@"MusicName"] andProducter:[songDic objectForKey:@"MusicArtist"]];
    }];
}

-(void)updateColor{

    UIImage *tinted = [frame.image rt_tintedImageWithColor: [UIColor colorWithHue:colorNum+0.003f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    colorNum = colorNum +0.003f;
    frame.image = tinted;
    if(colorNum>1.0){
        colorNum = 0.001f;
    }
}


-(void)createItemView:(NSString*)musicUrl andMusicPic:(NSString*)pic andMusicName:(NSString*)MusicName andProducter:(NSString*)productName{
    
    isPlay = true;
    
    UIImage *disk = [UIImage imageNamed:@"img_disk.png"];
    diskV = [[UIImageView alloc] initWithFrame:CGRectMake(46*DEF_Adaptation_Font_x*0.5,175*DEF_Adaptation_Font*0.5,disk.size.width*DEF_Adaptation_Font_x*0.3, disk.size.height*DEF_Adaptation_Font_x*0.3)];
    diskV.image = disk;
    [self addSubview:diskV];
    
    
    UIImage *frameV = [UIImage imageNamed:@"bg_frame.png"];
    frame = [[UIImageView alloc] initWithFrame:CGRectMake(113*DEF_Adaptation_Font_x*0.5,235*DEF_Adaptation_Font*0.5,frameV.size.width*DEF_Adaptation_Font_x*0.3, frameV.size.height*DEF_Adaptation_Font_x*0.3)];
    frame.image = frameV;
    
    [self addSubview:frame];
    
    
    likeV = [UIImage imageNamed:@"icon_start_like.png"];
    likeBtn = [[UIImageView alloc] initWithFrame:CGRectMake(482*DEF_Adaptation_Font_x*0.5,200*DEF_Adaptation_Font*0.5,likeV.size.width*DEF_Adaptation_Font_x*0.3, likeV.size.height*DEF_Adaptation_Font_x*0.3)];
    likeBtn.image = likeV;
    likeBtn.alpha = 0;
    [self addSubview:likeBtn];
    
    
    unlike = [UIImage imageNamed:@"icon_start_unlike.png"];
    unlikeBtn = [[UIImageView alloc] initWithFrame:CGRectMake(7*DEF_Adaptation_Font_x*0.5,194*DEF_Adaptation_Font*0.5,unlike.size.width*DEF_Adaptation_Font_x*0.3, unlike.size.height*DEF_Adaptation_Font_x*0.3)];
    unlikeBtn.image = unlike;
    unlikeBtn.alpha = 0;
    [self addSubview:unlikeBtn];
    
    
    timeColor = [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(updateColor) userInfo:nil repeats:YES];
    
    UIImage* playImage = [UIImage imageNamed:@"btn_play.png"];
    UIImage* stopImage = [UIImage imageNamed:@"btn_stop.png"];
    play_button = [[UIButton alloc]initWithFrame:CGRectMake(267*DEF_Adaptation_Font_x*0.5,753*DEF_Adaptation_Font*0.5,playImage.size.width*DEF_Adaptation_Font*0.3,playImage.size.height*DEF_Adaptation_Font*0.3)];
    [self addSubview:play_button];
    [play_button addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
    [play_button setBackgroundImage:playImage forState:UIControlStateNormal];
    [play_button setBackgroundImage:stopImage forState:UIControlStateSelected];
    [play_button setSelected:true];
    
    
    musicsinger = [[UILabel alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font_x*0.5, 89*DEF_Adaptation_Font*0.5, 740*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5)];
    musicsinger.text =productName;
    musicsinger.font =[UIFont fontWithName:@"Helvetica-Bold" size:26];
    musicsinger.textColor = [UIColor whiteColor];
    [self addSubview:musicsinger];
    

    musicName = [[UILabel alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font_x*0.5, 142*DEF_Adaptation_Font*0.5, 500*DEF_Adaptation_Font*0.5, 43*DEF_Adaptation_Font*0.5)];
    musicName.text = MusicName;
    musicName.font =[UIFont fontWithName:@"Dosis-Medium" size:18];
    musicName.textColor = [UIColor grayColor];
    [self addSubview:musicName];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",musicUrl];
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    _player=[AVPlayer playerWithPlayerItem:playerItem];  
    playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];

    [self.layer addSublayer:playerLayer];
    [_player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerMusicEnd) name:AVPlayerItemDidPlayToEndTimeNotification                                               object:[_player currentItem]];
    
    
    playMusicIcon = [[UIImageView alloc] initWithFrame:CGRectMake(175*DEF_Adaptation_Font_x*0.5,304*DEF_Adaptation_Font*0.5,294*DEF_Adaptation_Font_x*0.5, 294*DEF_Adaptation_Font_x*0.5)];
   
    [playMusicIcon sd_setImageWithURL:pic completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self addSubview:playMusicIcon];
        
        playMusicIcon.layer.cornerRadius = 294*DEF_Adaptation_Font_x*0.5/2;
        playMusicIcon.layer.masksToBounds = YES;
        
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 6.5;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = 500;
        animation.removedOnCompletion = NO;
        [playMusicIcon.layer addAnimation:animation forKey:nil];
        
        
        playerBar = [[DKPlayerBar alloc] initWithFrame:CGRectMake(25*DEF_Adaptation_Font_x*0.5,952*DEF_Adaptation_Font*0.5,600*DEF_Adaptation_Font_x*0.5,70*DEF_Adaptation_Font_x*0.5)];
        [self addSubview:playerBar];
        
        [playerBar createController:self];
        
        avTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer) userInfo:nil repeats:YES];

    }];
   
}


//TODO 手势滑动 左右 手势

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    originalLocation = [touch locationInView:self];
    //isPlay =true;
    //[self playMusic];
    
    if(originalLocation.y<800*0.5*DEF_Adaptation_Font){
    
    CFTimeInterval pausedTime = [playMusicIcon.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    playMusicIcon.layer.speed = 0.0;
    playMusicIcon.layer.timeOffset = pausedTime;
        
    }
}




- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint moveTouch = [touch locationInView:self];
    
    if(moveTouch.y<800*0.5*DEF_Adaptation_Font){
        playMusicIcon.frame=CGRectMake(playMusicIcon.frame.origin.x+(moveTouch.x-originalLocation.x), playMusicIcon.frame.origin.y , playMusicIcon.frame.size.width, playMusicIcon.frame.size.height);
        
        
        int num_x = playMusicIcon.frame.origin.x+playMusicIcon.frame.size.width/2;
        
        if(num_x==DEF_SCREEN_WIDTH/2){
            
            unlikeBtn.alpha = 0;
            likeBtn.alpha = 0;
        }
        
        
        if(num_x>DEF_SCREEN_WIDTH/2){
            unlikeBtn.alpha = 0;
            likeBtn.alpha = likeBtn.alpha +0.0125*(moveTouch.x-originalLocation.x);
            
        }else if(num_x<DEF_SCREEN_WIDTH/2){
            likeBtn.alpha = 0;
            
            unlikeBtn.alpha = unlikeBtn.alpha +0.0125*(originalLocation.x-moveTouch.x);
        }
        
    }
    originalLocation = [touch locationInView:self];
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch =  [touches anyObject];
    endLocation = [touch locationInView:self];
    int PointLength=[self computeTwoPointLine:originalLocation andEnd:endLocation];
    
   // if(endLocation.y<900*0.5*DEF_Adaptation_Font){
        
        int num_x = playMusicIcon.frame.origin.x+playMusicIcon.frame.size.width/2;
        int move_x;
        
        if(num_x>160*DEF_Adaptation_Font*0.5 && num_x<480*DEF_Adaptation_Font*0.5){
            move_x = 175*DEF_Adaptation_Font*0.5;
        }else if(num_x<160*DEF_Adaptation_Font*0.5){
            move_x = -300*DEF_Adaptation_Font*0.5;
        }else if(num_x>480*DEF_Adaptation_Font*0.5){
            move_x = 1000*DEF_Adaptation_Font*0.5;
        }
        
        CFTimeInterval pausedTime = [playMusicIcon.layer  timeOffset];
        playMusicIcon.layer .speed = 1.0;
        playMusicIcon.layer .timeOffset = 0.0;
        playMusicIcon.layer .beginTime = 0.0;
        CFTimeInterval timeSincePause = [playMusicIcon.layer  convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        playMusicIcon.layer .beginTime = timeSincePause;
    
        [UIView animateWithDuration:0.2 animations:^{
            // 2 秒内向右移动 100, 向下移动100。
           playMusicIcon.frame=CGRectMake(move_x, playMusicIcon.frame.origin.y , playMusicIcon.frame.size.width, playMusicIcon.frame.size.height);
            unlikeBtn.alpha = 0;
            likeBtn.alpha = 0;
            
        } completion:^(BOOL finished) {
            if(num_x<160*DEF_Adaptation_Font*0.5){
               [self updataNextMusic:true];
            }else if(num_x>480*DEF_Adaptation_Font*0.5){
                [self updataNextMusic:false];
            }else if(num_x>160*DEF_Adaptation_Font*0.5 && num_x<480*DEF_Adaptation_Font*0.5){
                isPlay =false;
                [self playMusic];
              
                CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                
                animation.fromValue = [NSNumber numberWithFloat:0.f];
                animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
                animation.duration  = 6.5;
                animation.autoreverses = NO;
                animation.fillMode =kCAFillModeForwards;
                animation.repeatCount = 500;
                animation.removedOnCompletion = NO;
                [playMusicIcon.layer addAnimation:animation forKey:nil];
            }
        }];
   // }
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{


}

-(int)computeTwoPointLine:(CGPoint)startP andEnd:(CGPoint)endPoint{


    double length =sqrt((endPoint.x-startP.x)*(endPoint.x-startP.x)+(endPoint.y-startP.y)*(endPoint.y-startP.y));

    return (int)length;
}



-(void)getMusicInfo{
    
    [self removeALLView];
     [_player seekToTime:kCMTimeZero];
     playerLayer = nil;
     _player =nil;
    if((musicCount+1)<=[array count]-1){
        [_player seekToTime:kCMTimeZero];
        [_player.currentItem removeObserver:self forKeyPath:@"status"];
          [playerLayer removeFromSuperlayer];
        [self initView:musicCount+1];
        musicCount = musicCount +1;
    }else{
        [self removeALLView];
        [_player seekToTime:kCMTimeZero];
        [_player.currentItem removeObserver:self forKeyPath:@"status"];
        [playerLayer removeFromSuperlayer];
        [self.obj toMainView:resultArray];
    }

}

-(void)removeALLView{
    [bk removeFromSuperview];
    
    [effectView removeFromSuperview];
    
    [diskV removeFromSuperview];
    
    [musicsinger removeFromSuperview];
    
    [musicName removeFromSuperview];
    
    [playMusicIcon removeFromSuperview];
    
    [playerBar removeFromSuperview];
    
    [playerLayer removeFromSuperlayer];
    
    [play_button removeFromSuperview];

    [timeColor invalidate];
    
}


-(void)updataNextMusic:(bool)isLike{
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    if(isLike==true){
    //喜欢
        [tempDic setObject:@"0" forKey:@"like"];
    }else{
    //不喜欢
        [tempDic setObject:@"1" forKey:@"like"];
    }
    [tempDic setObject:currentId forKey:@"musicId"];
    
    [resultArray addObject:tempDic];
    [self getMusicInfo];
}

-(void)updataMusicProgress:(float)progressF{
    float time = progressF*CMTimeGetSeconds(_player.currentItem.duration);
    [_player seekToTime:CMTimeMake(time,1)];
    if(isPlay){
        [_player play];
    }
}

-(void)stopMusic{
    
     [_player pause];

}




-(void)timer{

   float progress = CMTimeGetSeconds(_player.currentItem.currentTime) / CMTimeGetSeconds(_player.currentItem.duration);
    
    [playerBar updateProgress:progress];
    
    if(progress>0.98){
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [tempDic setObject:@"0" forKey:@"like"];
        [tempDic setObject:currentId forKey:@"musicId"];
        [resultArray addObject:tempDic];
        [avTimer invalidate];
        [self getMusicInfo];
    }
}


-(void)playerMusicEnd{

    [_player seekToTime:kCMTimeZero];

}

-(void)playMusic{
    if(isPlay == true){
        [_player pause];
        [play_button setSelected:false];
        isPlay = false;
        CFTimeInterval pausedTime = [playMusicIcon.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        playMusicIcon.layer.speed = 0.0;
        playMusicIcon.layer.timeOffset = pausedTime;
    }else{
        [_player play];
        [play_button setSelected:true];
        isPlay = true;
        CFTimeInterval pausedTime = [playMusicIcon.layer  timeOffset];
        playMusicIcon.layer .speed = 1.0;
        playMusicIcon.layer .timeOffset = 0.0;
        playMusicIcon.layer .beginTime = 0.0;
        CFTimeInterval timeSincePause = [playMusicIcon.layer  convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        playMusicIcon.layer .beginTime = timeSincePause;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_player.currentItem removeObserver:self forKeyPath:@"status"];

}


@end
