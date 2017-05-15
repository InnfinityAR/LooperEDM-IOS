//
//  DKPlayerBar.m
//  NeteasePlayerBar
//
//  Created by ZhangAo on 15/5/2.
//  Copyright (c) 2015年 ZhangAo. All rights reserved.
//

#import "DKPlayerBar.h"
#import "LooperConfig.h"
#import "StartView.h"

#define stretchImgFromMiddle(img)	[(img) stretchableImageWithLeftCapWidth:(img).size.width / 2 topCapHeight:(img).size.height / 3]

typedef enum {
    DKPlayStatePlay,
    DKPlayStatePause,
    DKPlayStateDrag
    
} DKPlayState;

@interface DKPlayButton : UIButton

@property (nonatomic, assign) DKPlayState playState;

@end

@implementation DKPlayButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      //  self.adjustsImageWhenHighlighted = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"icon_point.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"icon_point.png"] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"icon_point.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
        
        [self setImage:[UIImage imageNamed:@"icon_point.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"icon_point.png"] forState:UIControlStateSelected];
        
       // [self addTarget:self action:@selector(updateStateIfNeeds) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    self.playState = DKPlayStateDrag;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    self.playState = self.isSelected;
}

- (void)sizeToFit {
    CGRect frame = self.frame;
    frame.size = [self backgroundImageForState:UIControlStateNormal].size;
    self.frame = frame;
}

- (void)updateStateIfNeeds {
    if (self.playState != DKPlayStateDrag) {
        self.selected = !self.selected;
    }
}

- (void)setPlayState:(DKPlayState)playState {
    _playState = playState;
    
    switch (playState) {
        case DKPlayStatePlay:
            self.selected = NO;
            [self setImage:[self imageForState:UIControlStateNormal] forState:UIControlStateHighlighted];
            break;
        case DKPlayStatePause:
            self.selected = YES;
            [self setImage:[self imageForState:UIControlStateSelected] forState:UIControlStateSelected | UIControlStateHighlighted];
            break;
        case DKPlayStateDrag:
            [self setImage:[UIImage imageNamed:@"PlayerDrag"] forState:self.state | UIControlStateHighlighted];
            break;
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface DKPlayerBar ()

@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, weak) UIView *currentView;
@property (nonatomic, weak) DKPlayButton *playButton;
@property (nonatomic) int  pointCount;
@property (nonatomic,weak) id  obj;
@property (nonatomic)int num ;
@property (nonatomic)NSTimer *time;


@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation DKPlayerBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bk_progrss.png"]];
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
        
        UIImageView *currentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bk_line.png"]];
        [self addSubview:currentView];
        self.currentView = currentView;
        
        UIButton *playButton = [[UIButton alloc] initWithFrame: CGRectMake(0,-47,50,50)];
        
        UIImage* play = [UIImage imageNamed:@"icon_point.png"];
        [playButton setBackgroundImage:play forState:UIControlStateNormal];
        [playButton setBackgroundImage:play forState:UIControlStateHighlighted];
       
        [self addSubview:playButton];

         [playButton addTarget:self action:@selector(buttonDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [playButton addTarget:self action:@selector(buttonDown) forControlEvents:UIControlEventTouchUpInside];
        

        
        self.playButton = playButton;
    }
    return self;
}


-(void)buttonDown{


    [self cancelBtn];

}

-(void)cancelBtn{
    float musicNum = self.currentView.frame.size.width/self.backgroundView.frame.size.width;
    self.pointCount = 0;
    [self.obj updataMusicProgress:musicNum];

}


-(void)btnonClick{


    NSLog(@"btnonClick");

}


-(void)createController:(id)obj{
    self.obj = obj;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.lastFrame, self.frame)) {
        return;
    }
    self.lastFrame = self.frame;
    self.backgroundView.frame = CGRectMake(17, (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.backgroundView.bounds)) / 8,
                                           CGRectGetWidth(self.bounds) - 17 * 2, CGRectGetHeight(self.backgroundView.bounds)/3);
    
    
    
   [self.playButton sizeToFit];
    
    self.playButton.frame = CGRectMake(20,-CGRectGetHeight(self.playButton.bounds)*0.06,
                                       CGRectGetWidth(self.playButton.bounds)*0.33, CGRectGetHeight(self.playButton.bounds)*0.33);
    
    [self updateCurrentView];

    self.pointCount = 0;
    

}

- (IBAction)buttonDrag:(UIButton *)button withEvent:(UIEvent *)event {

    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    
    button.center = CGPointMake(MIN(CGRectGetWidth(self.bounds) - CGRectGetWidth(button.bounds) / 2-10*DEF_Adaptation_Font, MAX((CGRectGetWidth(button.bounds)-4) / 2+12*DEF_Adaptation_Font, button.center.x + (point.x - lastPoint.x))),
                                button.center.y);
    
    
     self.pointCount = self.pointCount +1;
    [self updateCurrentView];

}



-(void)updateProgress:(float)progressF{
    
    if(self.pointCount ==0){
        
        if(isnan(progressF)==true){
            progressF=0.01;
            
        }
        float num_x = progressF*self.backgroundView.frame.size.width;
        CGRect currentViewFrame = CGRectMake(self.backgroundView.frame.origin.x+5*DEF_Adaptation_Font,
                                             self.backgroundView.frame.origin.y+ self.backgroundView.bounds.size.height/2*0.5+2*DEF_Adaptation_Font,
                                             num_x,
                                             self.backgroundView.bounds.size.height/2*0.5);
        self.currentView.frame = currentViewFrame;
        
        if(currentViewFrame.size.width+self.playButton.frame.size.width/2+10*DEF_Adaptation_Font>self.backgroundView.frame.size.width+self.playButton.frame.size.width/2.1){
            self.playButton.center =CGPointMake(self.backgroundView.frame.size.width+self.playButton.frame.size.width/2.1,self.playButton.center.y);
        }else{
            self.playButton.center =CGPointMake(currentViewFrame.size.width+self.playButton.frame.size.width/2+10*DEF_Adaptation_Font,self.playButton.center.y);
        }
    }
}


-(void)updateCurrentView {
    CGRect currentViewFrame = CGRectMake(self.backgroundView.frame.origin.x+5*DEF_Adaptation_Font,
                                         self.backgroundView.frame.origin.y+ self.backgroundView.bounds.size.height/2*0.5+2*DEF_Adaptation_Font,
                                         CGRectGetMaxX(self.playButton.frame)- CGRectGetMinX(self.backgroundView.frame) * 2-self.playButton.frame.size.width*0.5*0.3,
                                         self.backgroundView.bounds.size.height/2*0.5);
    self.currentView.frame = currentViewFrame;
    
    
    float musicNum = self.currentView.frame.size.width/self.backgroundView.frame.size.width;
    
    
    if(self.pointCount==1){
        [self.obj stopMusic];
    }
    

    
}

@end
