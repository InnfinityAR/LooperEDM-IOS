//
//  MainView.m
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "MainView.h"
#import "MainViewModel.h"
#import "LooperConfig.h"
#import <QuartzCore/QuartzCore.h>
#import "LooperToolClass.h"
#import "DataHander.h"
#import "SelectToolView.h"

#define MaxSCale 2.8  //最大缩放比例
#define MinScale 0.6  //最小缩放比例

@implementation MainView{

    CGPoint originalLocation;
    
    CGPoint StartLocation;
    
    UIView *mapView;
    
    float totalScale;
    
    float initialScale;
    
    int preDistance;
    
    bool touchTrue;
    
    CGPoint centerPositionVector;
    
    CGPoint sreenCenterPoint;
    
    bool twoBool;

    CGPoint startPoint;
    
    CGPoint mapCenterPoint;
    
    UILabel *mapPosLable ;
    
    
    NSMutableArray *touchArray;
    
    CGSize mapSize;
    
    long int originalTime;
    
    
    NSMutableArray *loopArray;
    
    NSMutableArray *loopNameArray;
    
    NSMutableDictionary *loopDataDic;
    
    
    bool isToLooper;
    
    UIImageView *looperImage;
    
    
    UIImageView *showView;
    
    bool isShow;
    
    long int startTime;
    
    long int endTime;
    
    NSTimer *checktimer;
    
    
    UIImageView *selPoint;
    
    UIView *squareView;
    
    NSMutableArray *frameArray;
    
    SelectToolView *select;
    
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
    [self initView];
        
        
    }
    return self;
}



-(void)initView{
    
    isToLooper = false;
    totalScale = 1.0;

    loopArray = [[NSMutableArray alloc] initWithCapacity:50];
    loopDataDic = [[NSMutableDictionary alloc] initWithCapacity:50];
    frameArray = [[NSMutableArray alloc] initWithCapacity:50];
    loopNameArray = [[NSMutableArray alloc] initWithCapacity:50];
    
    mapView = [[UIView alloc] initWithFrame:CGRectMake(-300*DEF_Adaptation_Font*0.5*100/2,-300*DEF_Adaptation_Font*0.5*100/2, 300*DEF_Adaptation_Font*0.5*100, 300*DEF_Adaptation_Font*0.5*100)];
    
    [self addSubview:mapView];

    for (int i=0;i<100;i++){
        for (int j=0;j<100;j++){
            
            UIView *frame = [[UIView alloc] initWithFrame:CGRectMake(i*300*0.5*DEF_Adaptation_Font,j*300*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font)];
            
            frame.layer.borderWidth = 1*0.5*DEF_Adaptation_Font;
            
            frame.layer.borderColor = [[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:0.5] CGColor];
            
            [mapView addSubview:frame];
            
            frame.hidden=YES;
            
            [frameArray addObject:frame];
            
        }
    }

    mapView.multipleTouchEnabled=true;
    
    [mapView setBackgroundColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:35/255.0 alpha:1.0]];
    
    mapSize= CGSizeMake(mapView.frame.size.width, mapView.frame.size.height);
    touchArray= [[NSMutableArray alloc] initWithCapacity:50];

    [self createHudView];
    
    [self requestMapData:CGPointMake(1,1)];
    
    [self performSelector:@selector(addboundaryView) withObject:nil afterDelay:0.2];
    
}


-(void)updateMainMap{
    for (UIView *loop in loopArray){
        
        [loop removeFromSuperview];
    }
    for (UILabel *loopLabel in loopNameArray){
        
        [loopLabel removeFromSuperview];
    }
    
    [loopNameArray removeAllObjects];
    [loopArray removeAllObjects];
    [loopDataDic removeAllObjects];

}


-(void)requestMapData:(CGPoint)point{
    
  
    [_obj getAreaMapList:point];

}

-(int)getDiameterWithNum:(int)PersonNum{
    
    if(PersonNum<12){
        return 60;
    }else if(PersonNum<60){
        return 100;
    }else if(PersonNum<120){
        return 140;
    }else if(PersonNum<240){
         return 180;
    }else if(PersonNum<500){
        return 220;
    }else if(PersonNum>=500){
        return 260;
    }
    return 0;
}



-(void)createLoopWithData:(NSDictionary*)loopData{
    int Diameter = [self getDiameterWithNum:[[loopData objectForKey:@"UserCount"] intValue]];
    NSString *imagePath;
    if([loopData objectForKey:@"LoopIconImage"]!=[NSNull null]){
        imagePath = [loopData objectForKey:@"LoopIconImage"];
    }else{
        imagePath = [loopData objectForKey:@"LoopImage"];
    }
    
    UIView *loopView = [LooperToolClass createViewAndRect:CGPointMake([[loopData objectForKey:@"CoordinateX"] intValue]*300 +(150-Diameter/2), [[loopData objectForKey:@"CoordinateY"] intValue]*300+(150-Diameter/2)) andTag:[[loopData objectForKey:@"LoopID"] intValue] andSize:CGSizeMake(Diameter*0.5*DEF_Adaptation_Font, Diameter*0.5*DEF_Adaptation_Font) andIsRadius:true andImageName:imagePath];
    loopView.tag= [[loopData objectForKey:@"LoopID"] intValue];
    
    [mapView addSubview:loopView];
    
    
     if([[loopData objectForKey:@"LoopType"] intValue]==8){
         
         UIImageView *imageV  = [loopView viewWithTag:200];
         imageV.layer.cornerRadius = 8*0.5*DEF_Adaptation_Font;
         imageV.layer.masksToBounds = YES;
         loopView.layer.cornerRadius = 8*0.5*DEF_Adaptation_Font;
         loopView.layer.masksToBounds = YES;
     }
    
    
    if([[loopData objectForKey:@"CurrentUserFollow"] intValue]==0){
        if([[loopData objectForKey:@"LoopType"] intValue]!=8){
            if([[loopData objectForKey:@"IsSquare"]intValue]==0){
                UIImage *image = [UIImage imageNamed:@"sprite_bk.png"];
                UIImageView *circleV= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,loopView.frame.size.width, loopView.frame.size.height)];
                circleV.layer.cornerRadius =loopView.frame.size.height/2;
                circleV.layer.masksToBounds = YES;
                circleV.image=image;
                [loopView addSubview:circleV];
            }else{
                UIImage *image = [UIImage imageNamed:@"sprite_house_bk.png"];
                UIImageView *circleV= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,loopView.frame.size.width, loopView.frame.size.height)];
                circleV.layer.cornerRadius =loopView.frame.size.height/2;
                circleV.layer.masksToBounds = YES;
                circleV.image=image;
                [loopView addSubview:circleV];
            }
        }
    }

    [loopDataDic setObject:loopData forKey:[NSString stringWithFormat:@"%d%d",[[loopData objectForKey:@"CoordinateX"] intValue],[[loopData objectForKey:@"CoordinateY"] intValue]]];

    [loopArray addObject:loopView];

    int num_y = 20;
    if(Diameter==260){
        num_y = 0;
    }
    
    UILabel *looperName = [LooperToolClass createLableView:
                           CGPointMake([[loopData objectForKey:@"CoordinateX"] intValue]*300*0.5*DEF_Adaptation_Font+17*0.5*DEF_Adaptation_Font,loopView.frame.origin.y+loopView.frame.size.height+num_y*DEF_Adaptation_Font*0.5)
                                                   andSize:CGSizeMake(264*0.5*DEF_Adaptation_Font, 29*0.5*DEF_Adaptation_Font)
                                                   andText:[loopData objectForKey:@"LoopName"]
                                               andFontSize:12
                                                  andColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0]
                                                   andType:NSTextAlignmentCenter];
    [mapView addSubview:looperName];
    [loopNameArray addObject:looperName];
    [selPoint removeFromSuperview];
}

-(void)updataView{
    
    
    
    
}


-(void)addLoopWithData:(NSDictionary*)loopData{
    
     [self createLoopWithData:loopData];
}

-(void)responeseMapData:(NSMutableArray *)mapData{
    
    [self updateMainMap];
    
    for (NSMutableDictionary *loopDic in mapData){
        [self createLoopWithData:loopDic];
    }
}

-(void)addboundaryView{
    for (int i =0;i<100;i++){
    
        UIImage *imageFrame = [UIImage imageNamed:@"Mapframe.png"];
        UIImageView *upImage = [[UIImageView alloc] initWithFrame:CGRectMake(i*(300*0.5*DEF_Adaptation_Font), -300*0.5*DEF_Adaptation_Font, 300*0.5*DEF_Adaptation_Font,  300*0.5*DEF_Adaptation_Font)];
        upImage.image = imageFrame;
        [mapView addSubview:upImage];
        
        UIImageView *downImage = [[UIImageView alloc] initWithFrame:CGRectMake(i*(300*0.5*DEF_Adaptation_Font), (mapView.frame.size.height),  300*0.5*DEF_Adaptation_Font,  300*0.5*DEF_Adaptation_Font)];
        downImage.image = imageFrame;
         downImage.transform=CGAffineTransformMakeRotation(180*M_PI/180);
        [mapView addSubview:downImage];
        
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(-1*(300*0.5*DEF_Adaptation_Font), i*300*0.5*DEF_Adaptation_Font,  300*0.5*DEF_Adaptation_Font,  300*0.5*DEF_Adaptation_Font)];
        leftImage.image = imageFrame;
        leftImage.transform=CGAffineTransformMakeRotation(270*M_PI/180);
        [mapView addSubview:leftImage];
        
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(mapView.frame.size.width, i*300*0.5*DEF_Adaptation_Font,  300*0.5*DEF_Adaptation_Font,  300*0.5*DEF_Adaptation_Font)];
        rightImage.image = imageFrame;
        rightImage.transform=CGAffineTransformMakeRotation(90*M_PI/180);
        [mapView addSubview:rightImage];
    
    }
    
    UIImage *imageFrame = [UIImage imageNamed:@"show_map.png"];
    showView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    showView.image = imageFrame;
    showView.alpha=0;
    [self addSubview:showView];
  
}


-(void)lightningAnimated{
    if(isShow==false){
        isShow=true;
        
    [[DataHander sharedDataHander] showView:@"showContent.png" andTime:2 andPos:CGPointMake(141*DEF_Adaptation_Font_x*0.5, 431*DEF_Adaptation_Font*0.5)];
        
    [UIView animateWithDuration:0.5 animations:^{
        showView.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            showView.alpha=0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                showView.alpha=1.0;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    showView.alpha=0;
                    isShow=false;
                }];
            }];
        }];
    }];
    }
}




-(void)createHudView{
    
    isShow=false;
    
   UIButton *homeBtn = [LooperToolClass createBtnImageName:@"btn_home.png" andRect:CGPointMake(538, 1044) andTag:HomeBtnTag andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self] ;
    
    [self addSubview:homeBtn];
  
    
    UIButton *looperBtn = [LooperToolClass createBtnImageName:@"btn_looper.png" andRect:CGPointMake(28, 1044) andTag:LopperBtnTag andSelectImage:nil andClickImage:@"btn_unlooper.png" andTextStr:nil andSize:CGSizeZero  andTarget:self];
    
    [self addSubview:looperBtn];

    UIButton *searchBtn = [LooperToolClass createBtnImageName:@"btn_serach.png" andRect:CGPointMake(30, 62) andTag:SearchBtnTag andSelectImage:nil andClickImage:nil
                                                   andTextStr:nil andSize:CGSizeZero  andTarget:self];
    
    [self addSubview:searchBtn];

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
     [LooperToolClass didTapView:button andView:self];
    
    [self.obj hudOnClick:button.tag];
    
}



- (void)pinch:(UIPinchGestureRecognizer *)recognizer{

    float initialScale = totalScale;
    
    
    CGFloat scale = recognizer.scale;
    
    //放大情况
    if(scale > 1.0){
        if(totalScale > MaxSCale) return;
    }
    
    //缩小情况
    if (scale < 1.0) {
        if (totalScale < MinScale) return;
    }
    
    mapView.transform = CGAffineTransformScale(mapView.transform, scale, scale);
    totalScale *=scale;
    recognizer.scale = 1.0;
    
}

-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));
}


-(int)computeTwoPointLine:(CGPoint)startP andEnd:(CGPoint)endPoint{
    
    double length =sqrt((endPoint.x-startP.x)*(endPoint.x-startP.x)+(endPoint.y-startP.y)*(endPoint.y-startP.y));
    
    return (int)length;
}


-(CGPoint)createCenterPos:(CGPoint)point_first andSecond:(CGPoint)point_second{
    
    return  CGPointMake((point_first.x+point_second.x)/2, (point_first.y+point_second.y)/2);
}


-(UITouch*)getPointFromID:(int)index{
    UITouch *touch = [touchArray objectAtIndex:index];
    return touch;
}


-(void)removeTouchesFromDict:(NSSet*)touches{
    for (UITouch *touch in touches)
    {
        for (int i =1;i<[touchArray count];i++){
            UITouch* touch1 = [touchArray objectAtIndex:i];
            if(touch ==touch1){
                [touchArray removeObjectAtIndex:i];
            }
        }
    }
    [touchArray removeAllObjects];

    
}

-(void)addTouchToDict:(NSSet*)touches{
    for (UITouch *touch in touches)
    {
        bool bExist=false;
        
        for (int i =0;i<[touchArray count];i++){
            UITouch* touch1 = [touchArray objectAtIndex:i];
            if(touch ==touch1){
                [touchArray replaceObjectAtIndex:i withObject:touch];
                bExist = true;
                break;
            }
        }
        if(bExist==false){
            
            CGPoint temp = [touch locationInView:self];
            if(temp.x ==0.0 && temp.y==0.0){
                break;
            }else{
                [touchArray addObject:touch];
            }
        }
    }
    
}

-(void)clickSelPoint{

    if(selPoint!=nil){
          [selPoint removeFromSuperview];
          [squareView removeFromSuperview];
    }
    CGPoint point = CGPointMake( fabs(mapView.frame.origin.x)+selPoint.frame.origin.x+selPoint.frame.size.width/2, fabs(mapView.frame.origin.y)+selPoint.frame.origin.y+selPoint.frame.size.height/2);
    [self createLoop:point];
    
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]*1000);
    startTime =nowDate;
    originalTime = nowDate;
    [selPoint removeFromSuperview];
    [squareView removeFromSuperview];
    [checktimer invalidate];
    selPoint = nil;
    for (UIView *view in frameArray){
        
        view.hidden=YES;
    }
}

-(void)updateCheckLongPress{

    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]*1000);

    if(nowDate-startTime>200){
        if(selPoint==nil){
        
        [checktimer invalidate];
        [selPoint removeFromSuperview];
        [squareView removeFromSuperview];
        
        for (UIView *view in frameArray){
        
            view.hidden=NO;
        }
    
        CGPoint point = CGPointMake( fabs(mapView.frame.origin.x)+originalLocation.x-30*0.5*DEF_Adaptation_Font+60*0.5*DEF_Adaptation_Font/2, fabs(mapView.frame.origin.y)+originalLocation.y-30*0.5*DEF_Adaptation_Font+60*0.5*DEF_Adaptation_Font/2);
        int num_x = (point.x/(300*DEF_Adaptation_Font*0.5*totalScale));
        int num_y = (point.y/(300*DEF_Adaptation_Font*0.5*totalScale));

        squareView = [[UIView alloc] initWithFrame:CGRectMake(num_x*300*DEF_Adaptation_Font*0.5,num_y*300*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5)];
        //[squareView setBackgroundColor:[UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.4]];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2*DEF_Adaptation_Font*0.5,2*DEF_Adaptation_Font*0.5, 296*DEF_Adaptation_Font*0.5,  296*DEF_Adaptation_Font*0.5)];

            [imageV setImage:[UIImage imageNamed:@"looper_enable.png"]];
            [squareView addSubview:imageV];
            
         [mapView addSubview:squareView];
        
        selPoint = [[UIImageView alloc] initWithFrame:CGRectMake(originalLocation.x-30*0.5*DEF_Adaptation_Font, originalLocation.y-30*0.5*DEF_Adaptation_Font, 60*0.5*DEF_Adaptation_Font, 60*0.5*DEF_Adaptation_Font)];
        [selPoint setImage:[UIImage imageNamed:@"createloop.png"]];
        selPoint.layer.cornerRadius = 60*0.5*DEF_Adaptation_Font/2;
        [self addSubview:selPoint];

        selPoint.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelPoint)];
        [selPoint addGestureRecognizer:singleTap];
        
        startTime =nowDate;
        
        
        select =[[SelectToolView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        select.multipleTouchEnabled=true;
        [self addSubview:select];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:@"是否要创建新的loop?" forKey:@"LableStr"];
        [select initView:dic andViewType:1 andTypeTag:500];
        }
    }
}

-(void)selectViewType:(int)type andSelectNum:(int)selNum andSelectStr:(NSString*)Selstr{

    if(type==500){
        if(selNum==100){
            
            [selPoint removeFromSuperview];
            [squareView removeFromSuperview];
            [checktimer invalidate];
             selPoint = nil;
            for (UIView *view in frameArray){
                
                view.hidden=YES;
            }
        }else if(selNum ==101){
            
            
        }else if(selNum ==200){
            [select removeFromSuperview];
        
        }
        [select removeFromSuperview];
        
    }
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    touchTrue = true;
    
    [self addTouchToDict:touches];
    if([touchArray count]==1){
        NSDate *now= [NSDate date];
        long int nowDate = (long int)([now timeIntervalSince1970]*1000);
        originalLocation =[[self getPointFromID:0] locationInView:self];
        StartLocation =[[self getPointFromID:0] locationInView:self];
        originalTime = nowDate;
        [self checkSelectLoop:[self getPointFromID:0] andEnd:false];
        startTime = originalTime;
        
        checktimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateCheckLongPress) userInfo:nil repeats:true];
        
    }else if([touchArray count]==2){
        CGPoint touch1 = [[self getPointFromID:0] locationInView:self];
        CGPoint touch2 = [[self getPointFromID:1] locationInView:self];
        preDistance = [self computeTwoPointLine:touch1 andEnd:touch2];
        mapCenterPoint = [self createCenterPos:touch1 andSecond:touch2];
        
        CGPoint touch3 = [[self getPointFromID:0] locationInView:mapView];
        CGPoint touch4 = [[self getPointFromID:1] locationInView:mapView];
        mapCenterPoint = [self createCenterPos:touch3 andSecond:touch4];
    }
    
}




- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]*1000);
    startTime = nowDate;
    
    if( touchTrue ==true){
        
        [self addTouchToDict:touches];
        if([touchArray count]==1){
            
            bool isTouch=false;
            
            if(selPoint!=nil){
                if(selPoint.frame.origin.x<originalLocation.x && originalLocation.x<selPoint.frame.origin.x+selPoint.frame.size.width){
                    if(selPoint.frame.origin.y<originalLocation.y && originalLocation.y<selPoint.frame.origin.y+selPoint.frame.size.height){
                        selPoint.frame = CGRectMake([[self getPointFromID:0] locationInView:self].x-selPoint.frame.size.width/2, [[self getPointFromID:0] locationInView:self].y-selPoint.frame.size.height/2, selPoint.frame.size.width, selPoint.frame.size.height);
                        
                        CGPoint point = CGPointMake( fabs(mapView.frame.origin.x)+selPoint.frame.origin.x+selPoint.frame.size.width/2, fabs(mapView.frame.origin.y)+selPoint.frame.origin.y+selPoint.frame.size.height/2);
                        int num_x = (point.x/(300*DEF_Adaptation_Font*0.5*totalScale));
                        int num_y = (point.y/(300*DEF_Adaptation_Font*0.5*totalScale));
                        squareView.frame = CGRectMake(num_x*300*DEF_Adaptation_Font*0.5,num_y*300*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5);
                        
                        if([loopDataDic objectForKey:[NSString stringWithFormat:@"%d%d",num_x,num_y]]!=nil){
                            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2*DEF_Adaptation_Font*0.5,2*DEF_Adaptation_Font*0.5, 296*DEF_Adaptation_Font*0.5,  296*DEF_Adaptation_Font*0.5)];

                            [imageV setImage:[UIImage imageNamed:@"looper_unable.png"]];
                            [squareView addSubview:imageV];
                        }else{
                            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2*DEF_Adaptation_Font*0.5,2*DEF_Adaptation_Font*0.5, 296*DEF_Adaptation_Font*0.5,  296*DEF_Adaptation_Font*0.5)];

                            [imageV setImage:[UIImage imageNamed:@"looper_enable.png"]];
                            [squareView addSubview:imageV];
                        }
                        isTouch = true;
                    }
                }
            }
            if(isTouch==false){
                
                CGPoint movePoint = [[self getPointFromID:0] locationInView:self];
                if((mapView.frame.origin.x+(movePoint.x-originalLocation.x)<=300*0.5*DEF_Adaptation_Font *totalScale)&& mapView.frame.origin.x+(movePoint.x-originalLocation.x)>=-1*(mapView.frame.size.width-DEF_SCREEN_WIDTH+300*0.5*DEF_Adaptation_Font*totalScale)){
                    if( mapView.frame.origin.y+(movePoint.y-originalLocation.y)<=300*0.5*DEF_Adaptation_Font *totalScale&& mapView.frame.origin.y+(movePoint.y-originalLocation.y)>=-1*(mapView.frame.size.height-DEF_SCREEN_HEIGHT+300*0.5*DEF_Adaptation_Font*totalScale)){
                        
                        mapView.frame=CGRectMake(mapView.frame.origin.x+(movePoint.x-originalLocation.x), mapView.frame.origin.y+(movePoint.y-originalLocation.y), mapView.frame.size.width,  mapView.frame.size.height);
                    }else{
                        [self lightningAnimated];
                        
                    }
                }else{
                    [self lightningAnimated];
                    
                }
                if(selPoint!=nil){
                    
                    if((selPoint.frame.origin.x+(movePoint.x-originalLocation.x)<=DEF_SCREEN_WIDTH-selPoint.frame.size.width)&& selPoint.frame.origin.x+(movePoint.x-originalLocation.x)>=0){
                        if( selPoint.frame.origin.y+(movePoint.y-originalLocation.y)<=DEF_SCREEN_HEIGHT-selPoint.frame.size.height&& selPoint.frame.origin.y+(movePoint.y-originalLocation.y)>=0){
                            
                            selPoint.frame=CGRectMake(selPoint.frame.origin.x+(movePoint.x-originalLocation.x), selPoint.frame.origin.y+(movePoint.y-originalLocation.y), selPoint.frame.size.width,  selPoint.frame.size.height);
                            
                            CGPoint point = CGPointMake( fabs(mapView.frame.origin.x)+selPoint.frame.origin.x+selPoint.frame.size.width/2, fabs(mapView.frame.origin.y)+selPoint.frame.origin.y+selPoint.frame.size.height/2);
                            int num_x = (point.x/(300*DEF_Adaptation_Font*0.5*totalScale));
                            int num_y = (point.y/(300*DEF_Adaptation_Font*0.5*totalScale));
                            squareView.frame = CGRectMake(num_x*300*DEF_Adaptation_Font*0.5,num_y*300*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5, 300*DEF_Adaptation_Font*0.5);
                            
                            if([loopDataDic objectForKey:[NSString stringWithFormat:@"%d%d",num_x,num_y]]!=nil){
                                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2*DEF_Adaptation_Font*0.5,2*DEF_Adaptation_Font*0.5, 296*DEF_Adaptation_Font*0.5,  296*DEF_Adaptation_Font*0.5)];
                                [imageV setImage:[UIImage imageNamed:@"looper_unable.png"]];
                                [squareView addSubview:imageV];
                            }else{
                                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2*DEF_Adaptation_Font*0.5,2*DEF_Adaptation_Font*0.5, 296*DEF_Adaptation_Font*0.5,  296*DEF_Adaptation_Font*0.5)];

                                [imageV setImage:[UIImage imageNamed:@"looper_enable.png"]];
                                [squareView addSubview:imageV];
                            }
                        }
                    }
                    
                }
            }
            
            originalLocation =[[self getPointFromID:0] locationInView:self];
            
        }else if([touchArray count]==2){
            originalLocation = [[self getPointFromID:0] locationInView:self];
            CGPoint touch1 = [[self getPointFromID:0] locationInView:self];
            CGPoint touch2 = [[self getPointFromID:1] locationInView:self];
            
            int curDistance = [self computeTwoPointLine:touch1 andEnd:touch2];
            
            float scale = totalScale + totalScale * (curDistance - preDistance) / 200;
            
            //放大情况
            if(scale > MaxSCale){
                scale = MaxSCale;
            }
            
            //缩小情况
            if (scale < MinScale) {
                scale = MinScale;
            }
            
            mapView.transform = CGAffineTransformScale(mapView.transform, scale/totalScale, scale/totalScale);
            preDistance = curDistance;
            float oldScale= totalScale;
            totalScale =scale;
            float deltaX = (mapCenterPoint.x - 0.5 * mapSize.width) * (totalScale - oldScale);
            float deltaY = (mapCenterPoint.y - 0.5 * mapSize.height) * (totalScale - oldScale);
            
            int num_x = mapView.frame.origin.x-deltaX;
            if(num_x>=300*0.5*DEF_Adaptation_Font*totalScale){
                num_x = 300*0.5*DEF_Adaptation_Font*totalScale;
                [self lightningAnimated];
            }else if(num_x<=-1*(mapView.frame.size.width-DEF_SCREEN_WIDTH+300*0.5*DEF_Adaptation_Font*totalScale)){
                num_x= -1*(mapView.frame.size.width-DEF_SCREEN_WIDTH+300*0.5*DEF_Adaptation_Font*totalScale);
                [self lightningAnimated];
            }
            int num_y = mapView.frame.origin.y-deltaY;
            if(num_y>=300*0.5*DEF_Adaptation_Font*totalScale){
                num_y = 300*0.5*DEF_Adaptation_Font*totalScale;
                [self lightningAnimated];
            }else if(num_y<=-1*(mapView.frame.size.height-DEF_SCREEN_HEIGHT+300*0.5*DEF_Adaptation_Font*totalScale)){
                num_y= -1*(mapView.frame.size.height-DEF_SCREEN_HEIGHT+300*0.5*DEF_Adaptation_Font*totalScale);
                [self lightningAnimated];
            }
            
            mapView.frame= CGRectMake(num_x,num_y, mapView.frame.size.width, mapView.frame.size.height);
            
            //高低判断
        }
        
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    [checktimer invalidate];
    
    touchTrue = false;
    
    [self addTouchToDict:touches];
    
    if([touchArray count]==1){
        originalLocation = [[self getPointFromID:0] locationInView:self];
        NSDate *now= [NSDate date];
        long int nowDate = (long int)([now timeIntervalSince1970]*1000);
        endTime = nowDate;
        BOOL isLoop = false;
        
         if(nowDate-originalTime<100){
             int curDistance = [self computeTwoPointLine:StartLocation andEnd:[[self getPointFromID:0] locationInView:self]];
             if(curDistance<10){
                 isLoop = true;
                 [self checkSelectLoop:[self getPointFromID:0]andEnd:true];
             }
         }
        if(nowDate-originalTime>200){
            int curDistance = [self computeTwoPointLine:StartLocation andEnd:[[self getPointFromID:0] locationInView:self]];
            if(curDistance<3){
                isLoop = true;
                if([self checkSelectLoop:[self getPointFromID:0] andEnd:true]==0){
                    
                    
                }
            }
        }
        if(isLoop==false){
            [self checkSelectLoop:[self getPointFromID:0]andEnd:true];
        }
        
   
    }else if([touchArray count]==2){
          originalLocation =[[self getPointFromID:0] locationInView:self];
    }
    [self removeTouchesFromDict:touches];
    
    
    if(selPoint!=nil){
        [UIView animateWithDuration:0.05 animations:^{
            // 2 秒内向右移动 100, 向下移动100。
            selPoint.frame=CGRectMake(squareView.frame.origin.x*totalScale-fabs(mapView.frame.origin.x)+ (squareView.frame.size.width*totalScale-selPoint.frame.size.width)/2,squareView.frame.origin.y*totalScale-fabs(mapView.frame.origin.y)+(squareView.frame.size.height*totalScale-selPoint.frame.size.height)/2, selPoint.frame.size.width,  selPoint.frame.size.height);
            
        } completion:^(BOOL finished) {
            // 动画完成后的回调
        }];
    }
 
}



-(void)accelerateMoving{
    
    //StartLocation
   // originalLocation
   // endTime
   // originalTime

}



-(void)moveMap:(CGPoint)targetPoint{
    
    float num_x = targetPoint.x *300*DEF_Adaptation_Font*0.5*totalScale;
    float num_y = targetPoint.y *300*DEF_Adaptation_Font*0.5*totalScale;
    
    float nx = (num_x-(DEF_SCREEN_WIDTH/2))*-1 -300*DEF_Adaptation_Font*0.5*totalScale/2;
    float ny = (num_y-(DEF_SCREEN_HEIGHT/2))*-1 -300*DEF_Adaptation_Font*0.5*totalScale/2;
    
    
    [UIView animateWithDuration:1.0 animations:^{
        // 2 秒内向右移动 100, 向下移动100。
         mapView.frame= CGRectMake(nx,ny, mapView.frame.size.width, mapView.frame.size.height);
        
    } completion:^(BOOL finished) {
        // 动画完成后的回调
    }];
}


-(int)checkSelectLoop:(UITouch*)touch andEnd:(bool)isEnd{
     [looperImage setAlpha:1.0];
    CGPoint point = [touch locationInView:mapView];
    int num_x = (point.x/(300*DEF_Adaptation_Font*0.5));
    int num_y = (point.y/(300*DEF_Adaptation_Font*0.5));

    
    if([loopDataDic objectForKey:[NSString stringWithFormat:@"%d%d",num_x,num_y]]!=nil){
        NSDictionary *loopData =[loopDataDic objectForKey:[NSString stringWithFormat:@"%d%d",num_x,num_y]];

            int num_width=[self getDiameterWithNum:[[loopData objectForKey:@"UserCount"] intValue]];
            int numX = point.x -num_x *(300*DEF_Adaptation_Font*0.5);
            int numY = point.y -num_y *(300*DEF_Adaptation_Font*0.5);
            int numStart_x = (300-num_width)*DEF_Adaptation_Font*0.5*0.5;
            int numStart_y = (300-num_width)*DEF_Adaptation_Font*0.5*0.5;
            if(numStart_x<=numX && numX<=(numStart_x+(num_width*DEF_Adaptation_Font*0.5))){
                if(numStart_y<=numY  && numY<=(numStart_y+(num_width*DEF_Adaptation_Font*0.5))){
                    UIView *looper;
                    for (UIView *looperV in loopArray){
                        int num = (int)looperV.tag;
                        if(num == [[loopData objectForKey:@"LoopID"] intValue]){
                            looper = looperV;
                            break;
                        }
                    }
                    looperImage = [looper viewWithTag:200];
                    
                    if(isEnd==false){
                        [looperImage setAlpha:0.5];
                        [LooperToolClass didTapView:looper andView:mapView];
                    }
                    if(isEnd==true){
                        [self performSelector:@selector(jumpLooperView:) withObject:loopData afterDelay:0.2];
                    }
                    return 1;
                   //[_obj JumpLooperView:loopData];
                }
            }
    }
    return 0;
}


-(void)jumpLooperView:(NSDictionary*)loopData{

    [looperImage setAlpha:1.0];

    [_obj JumpLooperView:loopData];

}


//270 193

-(void)adjustToBoundaries{

    
}


-(void)createLoop:(CGPoint)point{

    //CGPoint point = [touch locationInView:mapView];
    int num_x = (point.x/(300*DEF_Adaptation_Font*0.5*totalScale));
    int num_y = (point.y/(300*DEF_Adaptation_Font*0.5*totalScale));
    
    [_obj checkMapIsUse:CGPointMake(num_x, num_y)];
    
}


@end
