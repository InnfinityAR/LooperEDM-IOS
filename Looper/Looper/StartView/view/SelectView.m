//
//  SelectView.m
//  Looper
//
//  Created by lujiawei on 12/10/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "SelectView.h"
#import "StartViewModel.h"
#import "DKPlayerBar.h"
#import "LooperConfig.h"
#import "UIImage+RTTint.h"

@implementation SelectView{
        
        UIImage *popSelImage;
        
        UIImage *popImage;
        
        UIButton* popbutton;
        
        NSTimer *timer;
        
        UIImage* prpSelImage;
        
        UIImage* prpImage;
        
        UIButton* prp_button;
        
        UIImageView *popImage1;
        
        UIImageView *prpImage1;
        
        AVPlayerLayer*playerLayer;
        
        
        UIButton *play_button;
        
        UIImageView *playMusicIcon;
        
        bool isPlay;
        
        NSTimer * avTimer;
        
        DKPlayerBar *playerBar;
        
        double i;
}


@synthesize obj = _obj;
@synthesize player = _player;



-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (StartViewModel*)idObject;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self playVideo];
    [self createBtn];
}

-(void)createBtn{
    i = 0.01f;
    
    popSelImage = [UIImage imageNamed:@"btn-prp-select.png"];
    popImage = [UIImage imageNamed:@"btn-prp.png"];
    popbutton = [[UIButton alloc]initWithFrame:CGRectMake(48*DEF_Adaptation_Font_x*0.5,242*DEF_Adaptation_Font*0.5,popImage.size.width*DEF_Adaptation_Font_x*0.3,popImage.size.height*DEF_Adaptation_Font*0.3)];
    [self addSubview:popbutton];
    [popbutton addTarget:self action:@selector(prpBtn) forControlEvents:UIControlEventTouchUpInside];
    [popbutton setBackgroundImage:popImage forState:UIControlStateNormal];
    [popbutton setBackgroundImage:popSelImage forState:UIControlStateHighlighted];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(updateColor) userInfo:nil repeats:YES];
    prpSelImage = [UIImage imageNamed:@"btn-pop-select.png"];
    prpImage = [UIImage imageNamed:@"btn-pop.png"];
    prp_button = [[UIButton alloc]initWithFrame:CGRectMake(304*DEF_Adaptation_Font_x*0.5,783*DEF_Adaptation_Font*0.5,popImage.size.width*DEF_Adaptation_Font*0.3,popImage.size.height*DEF_Adaptation_Font*0.3)];
    [self addSubview:prp_button];
    [prp_button addTarget:self action:@selector(popBtn) forControlEvents:UIControlEventTouchUpInside];
    [prp_button setBackgroundImage:prpImage forState:UIControlStateNormal];
    [prp_button setBackgroundImage:prpSelImage forState:UIControlStateHighlighted];
    
    popImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(48*DEF_Adaptation_Font_x*0.5,242*DEF_Adaptation_Font*0.5,popImage.size.width*DEF_Adaptation_Font_x*0.3,popImage.size.height*DEF_Adaptation_Font*0.3)];
    [popImage1 setImage:[UIImage imageNamed:@"pro.png"]];
    [self addSubview:popImage1];
    
    prpImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(304*DEF_Adaptation_Font_x*0.5,783*DEF_Adaptation_Font*0.5,popImage.size.width*DEF_Adaptation_Font*0.3,popImage.size.height*DEF_Adaptation_Font*0.3)];
    [prpImage1 setImage:[UIImage imageNamed:@"prp.png"]];
    [self addSubview:prpImage1];
}


-(void)updateColor{
    UIImage *tinted = [popImage rt_tintedImageWithColor: [UIColor colorWithHue:i+0.001f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    UIImage *tintedSel = [popSelImage rt_tintedImageWithColor: [UIColor colorWithHue:i+0.001f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    UIImage *prp = [prpImage rt_tintedImageWithColor: [UIColor colorWithHue:i+0.001f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    UIImage *prpSel = [prpSelImage rt_tintedImageWithColor: [UIColor colorWithHue:i+0.001f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    i = i +0.001f;
    [prp_button setBackgroundImage:prp forState:UIControlStateNormal];
    [prp_button setBackgroundImage:prpSel forState:UIControlStateHighlighted];
    [popbutton setBackgroundImage:tinted forState:UIControlStateNormal];
    [popbutton setBackgroundImage:tintedSel forState:UIControlStateHighlighted];
    
    if(i>1.0){
        i = 0.001f;
    }
}

-(void)playVideo{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartMovie.mp4" withExtension:nil];
    _player=[AVPlayer playerWithURL:url];
    playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    [self.layer addSublayer:playerLayer];
    [_player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification                                               object:[_player currentItem]];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [_player seekToTime:kCMTimeZero];
    [_player play];
}

-(void)dealloc{
    [timer invalidate];
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
}

-(void)popBtn{
    
    [self.obj removeSelectToStart:101];
 
}

-(void)prpBtn{
     [self.obj removeSelectToStart:100];

}





@end
