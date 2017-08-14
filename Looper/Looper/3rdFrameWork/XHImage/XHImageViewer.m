//
//  XHImageViewer.m
//  XHImageViewer
//
//  Created by 曾 宪华 on 14-2-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHImageViewer.h"
#import "XHViewState.h"
#import "XHZoomingImageView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@interface XHImageViewer ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imgViews;
@property (nonatomic) int _type_num;

@end

@implementation XHImageViewer{

    NSMutableArray *tempArray;
    UIImageView *tempImage;
}

- (id)init{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    self.backgroundScale = 0.95;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    pan.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag == 101){
        [self dismissWithAnimate];
    }else if(button.tag == 102){
        
        for (int i=0;i<[[_scrollView subviews]count];i++){
            [[[_scrollView subviews] objectAtIndex:i] removeFromSuperview];
        }
        
        [_scrollView removeFromSuperview];
        [tempArray removeObjectAtIndex:(_scrollView.contentOffset.x / _scrollView.frame.size.width)];
        
        if([tempArray count]==0){
            [self removeFromSuperview];
             [self dismissWithAnimate];
        
        }else{

            [self showWithImageViews:tempArray selectedView:[tempArray objectAtIndex:0] andType:1];

        
        }
    }
}


-(void)createHudView{

    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *delBtn = [LooperToolClass createBtnImageNameReal:@"btn_delete_photo.png" andRect:CGPointMake(534*DEF_Adaptation_Font*0.5,30*DEF_Adaptation_Font*0.5)andTag:102 andSelectImage:@"btn_delete_photo.png" andClickImage:@"btn_delete_photo.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5)  andTarget:self];
    [self addSubview:delBtn];

}



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self _setup];
       
    }
    return self;
}

- (void)setImageViewsFromArray:(NSArray*)views {
    NSMutableArray *imgViews = [NSMutableArray array];
    for(id obj in views){
        if([obj isKindOfClass:[UIImageView class]]){
            [imgViews addObject:obj];
            
            UIImageView *view = obj;
            
            XHViewState *state = [XHViewState viewStateForView:view];
            [state setStateWithView:view];
            
            view.userInteractionEnabled = NO;
        }
    }
    _imgViews = [[NSMutableArray alloc]initWithArray:[imgViews copy]];
}


- (void)showWithImageViews:(NSArray*)views selectedView:(UIImageView*)selectedView andType:(int)type{
    tempArray = [[NSMutableArray alloc] initWithArray:views];
    
    [self setImageViewsFromArray:views];
    
    if(_imgViews.count > 0){
        if(![selectedView isKindOfClass:[UIImageView class]] || ![_imgViews containsObject:selectedView]){
            selectedView = _imgViews[0];
        }
        [self showWithSelectedView:selectedView];
    }
    if(type==1){
    
        [self createHudView];
    }else if(type==0){
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
        [self addSubview:backBtn];
    }
}

#pragma mark- Properties

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[backgroundColor colorWithAlphaComponent:0]];
}

- (NSInteger)pageIndex {
    return (_scrollView.contentOffset.x / _scrollView.frame.size.width + 0.5);
}

#pragma mark- View management

- (UIImageView *)currentView {
    return [_imgViews objectAtIndex:self.pageIndex];
}

- (void)showWithSelectedView:(UIImageView*)selectedView {
    for(UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    const NSInteger currentPage = [_imgViews indexOfObject:selectedView];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.backgroundColor = [self.backgroundColor colorWithAlphaComponent:1];
        _scrollView.alpha = 0;
    }
    
    [self addSubview:_scrollView];
    [window addSubview:self];
    
    const CGFloat fullW = window.frame.size.width;
    const CGFloat fullH = window.frame.size.height;
    
    
    tempImage = selectedView;
    selectedView.frame = [window convertRect:selectedView.frame fromView:selectedView.superview];
    [window addSubview:selectedView];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _scrollView.alpha = 1;
                         window.rootViewController.view.transform = CGAffineTransformMakeScale(self.backgroundScale, self.backgroundScale);
                         
                         selectedView.transform = CGAffineTransformIdentity;
                         
                         CGSize size = (selectedView.image) ? selectedView.image.size : selectedView.frame.size;
                         CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
                         CGFloat W = ratio * size.width;
                         CGFloat H = ratio * size.height;
                         NSLog(@"size.height---%f,ratio---%f",size.height,ratio);
                         selectedView.frame = CGRectMake((fullW-W)/2, (fullH-H)/2, W, H);
                         NSLog(@"---x--%f,y--%f,width---%f,height---%f",selectedView.frame.origin.x,selectedView.frame.origin.y,selectedView.frame.size.width,selectedView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                         [selectedView removeFromSuperview];
                         _scrollView.contentSize = CGSizeMake(_imgViews.count * fullW, 0);
                         _scrollView.contentOffset = CGPointMake(currentPage * fullW, 0);
                         
                         UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScrollView:)];
                         [_scrollView addGestureRecognizer:gesture];
                         
                         for(UIImageView *view in _imgViews){
                             view.transform = CGAffineTransformIdentity;
                             
                             CGSize size = (view.image) ? view.image.size : view.frame.size;
                             CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
                             CGFloat W = ratio * size.width;
                             CGFloat H = ratio * size.height;
                             NSLog(@"over-- size.height---%f,ratio---%f",size.height,ratio);
                             view.frame = CGRectMake((fullW-W)/2, (fullH-H)/2, W, H);
                             NSLog(@"---x--%f,y--%f,width---%f,height---%f",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
                             XHZoomingImageView *tmp = [[XHZoomingImageView alloc] initWithFrame:CGRectMake([_imgViews indexOfObject:view] * fullW, 0, fullW, fullH)];
                             tmp.imageView = view;
                             
                             [_scrollView addSubview:tmp];
                         }
                     }
     ];
}


- (void)prepareToDismiss {
    UIImageView *currentView = [self currentView];
    
    if([self.delegate respondsToSelector:@selector(imageViewer:willDismissWithSelectedView:)]) {
        [self.delegate imageViewer:self willDismissWithSelectedView:currentView];
    }
    
    for(UIImageView *view in _imgViews) {
        if(view != currentView) {
            XHViewState *state = [XHViewState viewStateForView:view];
            view.transform = CGAffineTransformIdentity;
            view.frame = state.frame;
            view.transform = state.transform;
            [state.superview addSubview:view];
        }
    }
}

- (void)dismissWithAnimate {
    UIView *currentView = [self currentView];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect rct = currentView.frame;
    currentView.transform = CGAffineTransformIdentity;
    currentView.frame = [window convertRect:rct fromView:currentView.superview];
    [window addSubview:currentView];
    
    
    _scrollView.alpha = 0;
    window.rootViewController.view.transform =  CGAffineTransformIdentity;
    
    XHViewState *state = [XHViewState viewStateForView:currentView];
    currentView.frame = [window convertRect:state.frame fromView:state.superview];
    currentView.transform = state.transform;

    
    currentView.transform = CGAffineTransformIdentity;
    currentView.frame = state.frame;
    currentView.transform = state.transform;
    [state.superview addSubview:currentView];
    
    for(UIView *view in _imgViews){
        XHViewState *_state = [XHViewState viewStateForView:view];
        view.userInteractionEnabled = _state.userInteratctionEnabled;
    }
    
    
    
    [self.delegate imageViewer:self finishWithSelectedView:tempArray];
    
    
    
    [self removeFromSuperview];
    /*
    [UIView animateWithDuration:0.3
                     animations:^{
                         _scrollView.alpha = 0;
                         window.rootViewController.view.transform =  CGAffineTransformIdentity;
     
                         XHViewState *state = [XHViewState viewStateForView:currentView];
                         currentView.frame = [window convertRect:state.frame fromView:state.superview];
                         currentView.transform = state.transform;
                     }
                     completion:^(BOOL finished) {
                         XHViewState *state = [XHViewState viewStateForView:currentView];
                         currentView.transform = CGAffineTransformIdentity;
                         currentView.frame = state.frame;
                         currentView.transform = state.transform;
                         [state.superview addSubview:currentView];
                         
                         for(UIView *view in _imgViews){
                             XHViewState *_state = [XHViewState viewStateForView:view];
                             view.userInteractionEnabled = _state.userInteratctionEnabled;
                         }
                         
                         [self removeFromSuperview];
                     }
     ];
     */
}

#pragma mark- Gesture events

- (void)tappedScrollView:(UITapGestureRecognizer*)sender
{
    [self prepareToDismiss];
    [self dismissWithAnimate];
}

- (void)didPan:(UIPanGestureRecognizer*)sender
{
    static UIImageView *currentView = nil;
    
    if(sender.state == UIGestureRecognizerStateBegan){
        currentView = [self currentView];
        
        UIView *targetView = currentView.superview;
        while(![targetView isKindOfClass:[XHZoomingImageView class]]){
            targetView = targetView.superview;
        }
        
        if(((XHZoomingImageView *)targetView).isViewing){
            currentView = nil;
        }
        else{
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            currentView.frame = [window convertRect:currentView.frame fromView:currentView.superview];
            [window addSubview:currentView];
            
            [self prepareToDismiss];
        }
    }
    
    if(currentView){
        if(sender.state == UIGestureRecognizerStateEnded){
            if(_scrollView.alpha>0.5){
                [self showWithSelectedView:currentView];
            }
            else{
                [self dismissWithAnimate];
            }
            currentView = nil;
        }
        else{
            CGPoint p = [sender translationInView:self];
            
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, p.y);
            transform = CGAffineTransformScale(transform, 1 - fabs(p.y)/1000, 1 - fabs(p.y)/1000);
            currentView.transform = transform;
            
            CGFloat r = 1-fabs(p.y)/200;
            _scrollView.alpha = MAX(0, MIN(1, r));
        }
    }
}

@end
