//
//  PlayVideoView.m
//  Looper
//
//  Created by lujiawei on 14/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PlayVideoView.h"
#import "PhotoWallViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import "LooperConfig.h"

@implementation PlayVideoView{

    NSString * _urlString;
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andUrlStr:(NSString*)urlString{

    if (self = [super initWithFrame:frame]) {
        self.obj = (PhotoWallViewModel*)idObject;
        
        
        [self initView:urlString];
    }
    return self;



}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}



-(void)initView:(NSString*)urlString{

    _urlString = urlString;
    
     [self setBackgroundColor:[UIColor blackColor]];
    
    AVPlayer*_player=[AVPlayer playerWithURL:[[NSURL alloc] initWithString:_urlString]];
    AVPlayerLayer*playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    [self.layer addSublayer:playerLayer];
    [_player play];

}


@end
