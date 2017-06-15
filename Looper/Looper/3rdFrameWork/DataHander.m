//
//  DataHander.m
//  CaCaXian
//
//  Created by Nancy on 13-4-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DataHander.h"
#import "AppDelegate.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"

@implementation DataHander

static DataHander* dataHander = nil;

+(DataHander *)sharedDataHander
{
    @synchronized(self){
        if (dataHander == nil) {
            dataHander = [[self alloc] init];
        }
    }
    return dataHander;
}



-(void)showViewWithStr:(NSString *)labelStr andTime:(int)Time andPos:(CGPoint)point{
    
    if(showViewLable==nil){
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       
        showViewLable = [[UIView alloc] initWithFrame:CGRectMake(130*DEF_Adaptation_Font*0.5, 522*DEF_Adaptation_Font*0.5, 390*DEF_Adaptation_Font*0.5, 92*DEF_Adaptation_Font*0.5)];
        [showViewLable setBackgroundColor:[UIColor colorWithRed:22/255.0 green:11/255.0 blue:28/255.0 alpha:0.9]];
        showViewLable.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
        [appDelegate.window addSubview:showViewLable];
        
         UILabel* lable = [LooperToolClass createLableView:CGPointMake(0,0) andSize:CGSizeMake(390*DEF_Adaptation_Font*0.5,92*DEF_Adaptation_Font*0.5) andText:labelStr andFontSize:11 andColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
        [showViewLable addSubview:lable];
//runloop
        [self performSelector:@selector(removeShowLableV) withObject:nil afterDelay:Time];

    }
}


-(void)removeShowLableV{

    if(showViewLable!=nil){
        [showViewLable removeFromSuperview];
        showViewLable=nil;
    }
}




-(void)showView:(NSString*)imagePah andTime:(int)Time andPos:(CGPoint)point{
    
    if(showV==nil){
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UIImage *showImage = [UIImage imageNamed:imagePah];
        
        showV = [[UIImageView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-showImage.size.width*0.3/2, point.y, showImage.size.width*0.3, showImage.size.height*0.3)];
        showV.image = showImage;
        [appDelegate.window addSubview:showV];
        
        [self performSelector:@selector(removeShowView) withObject:nil afterDelay:Time];
    }
}


-(void)removeShowView{

    if(showV!=nil){
        [showV removeFromSuperview];
        showV=nil;
    }
}


-(void)showDlg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(!loadImage){
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            bk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
            [bk setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
            [appDelegate.window addSubview:bk];
            loadImage=[LooperToolClass LoadingImageName:@"loading" andCount:53 andDuration:1.4 andloadScroll:false andPoint:CGPointMake(0, 0)];
            [appDelegate.window addSubview:loadImage];
        }
    });
}

-(void)hideDlg
{     dispatch_async(dispatch_get_main_queue(), ^{
    
    [bk removeFromSuperview];
    [loadImage removeFromSuperview];
     loadImage = nil;

    });
}


-(id)init{
    
    if(self = [super init])
    {
       
    }
    return self;
}


- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}
- (oneway void)release
{
    ///oneway用在分布式对象的API，这些API可以在不同的线程，甚至是不同的程序。oneway关键字只用在返回类型为void的消息定义中， 因为oneway是异步的，其消息预计不会立即返回。
}
- (id)autorelease
{
    return self;
}
-(void)dealloc
{
    mbProgressHud = nil;
    [super dealloc];
}
@end
