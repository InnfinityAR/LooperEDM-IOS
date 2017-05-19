//
//  XDRefreshFooter.m
//  XDRefresh
//
//  Created by 蔡欣东 on 2016/7/27.
//  Copyright © 2016年 蔡欣东. All rights reserved.
//

#import "XDRefreshFooter.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"

@interface XDRefreshFooter(){
    CGFloat     _contentH;
    CGFloat     _footerH;
    CGFloat     _scrollViewW;
    CGFloat     _scrollViewH;
    BOOL        _isRefreshing;
    BOOL        _haveFooter;
    BOOL        _enableRefresh;
    BOOL        isObserver;

}

/**
 *  底部视图
 */
@property (nonatomic, strong, readwrite) UIView *footerView;

/**
 *  菊花视图
 */
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *indicator;

@property (nonatomic, strong, readwrite) UIImageView *indicatorV;

/**
 *  滚动视图
 */
@property(nonatomic, strong ,readwrite)UIScrollView *scrollView;

/**
 *  刷新回调
 */
@property(nonatomic, copy ,readwrite)XDRefreshingBlock refreshingBlock;

/**
 *  状态视图
 */
@property(nonatomic, strong, readwrite)UILabel *statusLabel;

@end

@implementation XDRefreshFooter

+ (XDRefreshFooter *)footerOfScrollView:(UIScrollView *)scrollView
                        refreshingBlock:(XDRefreshingBlock)block {
    XDRefreshFooter *footer = [[XDRefreshFooter alloc] init];
    footer.scrollView       = scrollView;
    footer.refreshingBlock  = block;
    [footer initFooter];
    return footer;
}

-(void)removeAction{
    
    if(_scrollView!=nil){
        
        if(isObserver==true){
            [_indicatorV stopAnimating];
            [_indicatorV removeFromSuperview];
            [_footerView removeFromSuperview];
            [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
            self.refreshingBlock=nil;
            self.scrollView = nil;
            
        }
    }
}



- (void)initFooter {
    isObserver = false;
    _scrollViewW    = _scrollView.frame.size.width;
    _scrollViewH    = _scrollView.frame.size.height;
    _footerH        = 60;
    _haveFooter     = NO;
    _isRefreshing   = NO;
    _enableRefresh  = YES;
    
    
    
    _footerView         = [[UIView alloc] init];
    
    //_indicator      = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  //  _indicator.frame = CGRectMake((_scrollViewW-_footerH)/2, 0, _footerH, _footerH);
    //[_footerView addSubview:_indicator];
    
    _indicatorV=[LooperToolClass LoadingImageName:@"loading" andCount:53 andDuration:1.4 andloadScroll:true andPoint:CGPointMake(DEF_SCREEN_WIDTH/2-30,0)];
    _indicator.frame = CGRectMake((_scrollViewW-_footerH)/2,0, _footerH, _footerH);
    [_footerView addSubview:_indicatorV];
    _indicatorV.hidden = YES;
    
    
    
    _statusLabel                = [[UILabel alloc] init];
    _statusLabel.frame          = CGRectMake(0, 0, 0, 0);
    _statusLabel.text           = @"";
    _statusLabel.font           = [UIFont systemFontOfSize:14];
    _statusLabel.textAlignment  = NSTextAlignmentCenter;
    _statusLabel.textColor      = [UIColor whiteColor];
    [_footerView addSubview:_statusLabel];
    isObserver = true;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //[_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (_enableRefresh) {
            _contentH = _scrollView.contentSize.height;
            if (!_haveFooter) {
                _haveFooter = YES;
                [_scrollView addSubview:_footerView];
            }
            
            _footerView.frame   = CGRectMake(0, _contentH, _scrollViewW, _footerH);
            
            _statusLabel.frame = CGRectMake(0, 0, 0, 0);
            _statusLabel.text = @"";

            CGFloat currentPostion = _scrollView.contentOffset.y;

            if ((_contentH > _scrollViewH) && (currentPostion > (_contentH - _scrollViewH))) {
                [self beginRefreshing];
            }
        }
    }
}



- (void)beginRefreshing {
    if (!_isRefreshing) {
        _isRefreshing = YES;
        _indicatorV.hidden = NO;

        [_indicatorV startAnimating];
        
        [UIView animateWithDuration:0.3f animations:^{
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, _footerH, 0);
        }];
        
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
    }
}

- (void)endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
       [UIView animateWithDuration:0.3f animations:^{
           [_indicatorV stopAnimating];
             _indicatorV.hidden = YES;
            _isRefreshing = NO;
       }];
    });
}

- (void)resetNoMoreData {
    _statusLabel.frame = CGRectMake(0, 0, 0, 0);
    _statusLabel.text = @"";
    _enableRefresh = YES;

}

- (void)endRefreshingWithNoMoreDataWithTitle:(NSString *)title {
    [self endRefreshing];
    _statusLabel.frame = CGRectMake(0, 0, _scrollViewW, _footerH);
    _statusLabel.text = title;
    _enableRefresh = NO;

}

-(void)dealloc{
    [_indicatorV stopAnimating];
    [_indicatorV removeFromSuperview];
    [_footerView removeFromSuperview];
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    self.refreshingBlock=nil;
    self.scrollView = nil;
}


@end
