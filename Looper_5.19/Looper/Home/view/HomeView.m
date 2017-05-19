//
//  HomeView.m
//  Looper
//
//  Created by lujiawei on 12/23/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"

@implementation HomeView{
    
    UIImageView *bkView;
    
    
    CGPoint originalLocation;
    
    CGPoint endLocation;
    
    int preDistance;
    
    long int  originalDate;
    
    NSMutableArray *touchArraylist;
    
    NSMutableArray *touchArray;

    UIImageView *backV;
    
    UIImageView *screenV;
    
    UIImageView *CalendarV;
    
    UIImageView *settingV;
    
    UIImageView *completeV;

    NSMutableArray *captionArray;
    
    NSTimer *captionTimer;
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (HomeViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
}


-(void)removeAllAnimation{

    [captionTimer invalidate];
    [backV stopAnimating];
    [screenV stopAnimating];
    [CalendarV stopAnimating];
    [settingV stopAnimating];
    [completeV stopAnimating];
    
    backV.animationImages = nil;
    screenV.animationImages = nil;
    CalendarV.animationImages = nil;
    settingV.animationImages = nil;
    completeV.animationImages = nil;
    
    [backV removeFromSuperview];
    [screenV removeFromSuperview];
    [CalendarV removeFromSuperview];
    [settingV removeFromSuperview];
    [completeV removeFromSuperview];

}




-(void)createBk{
    
    bkView=[LooperToolClass createImageView:@"bk_home1.png" andRect:CGPointMake(1917/3*-1, 0) andTag:100 andSize:CGSizeZero andIsRadius:false];
 
    [self addSubview:bkView];

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


-(UITouch*)getPointFromID:(int)index{
    UITouch *touch = [touchArray objectAtIndex:index];
    return touch;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self addTouchToDict:touches];
    if([touchArray count]==1){
    
        NSLog(@"start -------%lu",(unsigned long)[touches count]);
        UITouch *touch = [self getPointFromID:0];
        originalLocation = [touch locationInView:self];
        endLocation = [touch locationInView:self];
        CGPoint bkViewPos = [touch locationInView:bkView];
    
        NSDate *nowDate = [NSDate date];
        originalDate = (long int)([nowDate timeIntervalSince1970]*1000);
    }
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addTouchToDict:touches];
    if([touchArray count]==1){

    
    NSLog(@"move -------%lu",(unsigned long)[touches count]);
        UITouch* Point = [self getPointFromID:0];
        CGPoint movePoint = [Point locationInView:self];
        if((bkView.frame.origin.x+(movePoint.x-endLocation.x)<=0 )&& bkView.frame.origin.x+(movePoint.x-endLocation.x)>=-1*(bkView.frame.size.width-DEF_SCREEN_WIDTH)){
                NSLog(@"%lf",movePoint.x-endLocation.x);
                bkView.frame=CGRectMake(bkView.frame.origin.x+(movePoint.x-endLocation.x), bkView.frame.origin.y, bkView.frame.size.width,  bkView.frame.size.height);
        }
        endLocation = [Point locationInView:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self addTouchToDict:touches];
    if([touchArray count]==1){
        UITouch *touch =  [self getPointFromID:0];
        int PointLength=[self computeTwoPointLine:originalLocation andEnd:endLocation];
        endLocation = [touch locationInView:self];
        preDistance = 0;
        NSDate *now= [NSDate date];
        long int nowDate = (long int)([now timeIntervalSince1970]*1000);
        NSLog(@"%ld",nowDate);
        if(nowDate-originalDate<160){
            [self checkPointEventTag:[touch locationInView:bkView]];
        }
    }
      [self removeTouchesFromDict:touches];
    
}

-(void)mapEvent:(int)tag{

    NSLog(@"%d",tag);
    if(tag == 1){
        [self removeAllAnimation];
        
        [_obj popViewController];
    }else if(tag==2){
        
        [ _obj jumpToView:tag];
    }else if(tag==3){
        [ _obj jumpToPhone];
    }else if(tag==4){
        
        [ _obj createCalendarV];
    }


}

-(void)checkPointEventTag:(CGPoint)point{
    int i;
    int tag=0;
    for (i=0;i<[touchArraylist count];i++){
        NSDictionary *touchDic = [touchArraylist objectAtIndex:i];
        CGSize size = [[touchDic objectForKey:@"size"] CGSizeValue];
        CGPoint pos = [[touchDic objectForKey:@"pos"] CGPointValue];
        int tagNum =[[touchDic objectForKey:@"tag"] intValue];

        if(point.x>=pos.x && point.x<pos.x+size.width){
             if(point.y>=pos.y && point.y<pos.y+size.height){
                 tag = tagNum;
                 [self mapEvent:tagNum];
                 return;
             }
        }
    }
}



-(void)runAnimation:(NSString*)imageName andCount:(int)count andImageV:(UIImageView*)imageObj andDuration:(int)Duraction{
    
    imageObj.animationImages = [LooperToolClass initialImageArray:imageName andImageCount:count];
    imageObj.animationDuration = Duraction;
    imageObj.animationRepeatCount = 0;
    [imageObj startAnimating];//开始动画
    [bkView addSubview:imageObj];
}


-(void)createAnimatedView{

    backV = [[UIImageView alloc] initWithFrame:CGRectMake(-24*0.5*DEF_Adaptation_Font_x,728*0.5*DEF_Adaptation_Font, 461*0.5*DEF_Adaptation_Font, 451*0.5*DEF_Adaptation_Font)];
    [self runAnimation:@"chuansong" andCount:10 andImageV:backV andDuration:1];
    
    screenV = [[UIImageView alloc] initWithFrame:CGRectMake(666*0.5*DEF_Adaptation_Font_x,306*0.5*DEF_Adaptation_Font,638*0.5*DEF_Adaptation_Font, 373*0.5*DEF_Adaptation_Font)];
    [self runAnimation:@"daping" andCount:34 andImageV:screenV andDuration:4];
    
    CalendarV = [[UIImageView alloc] initWithFrame:CGRectMake(165*0.5*DEF_Adaptation_Font_x,361*0.5*DEF_Adaptation_Font, 292*0.5*DEF_Adaptation_Font, 164*0.5*DEF_Adaptation_Font)];
    [self runAnimation:@"rili" andCount:34 andImageV:CalendarV andDuration:4];
    
    settingV = [[UIImageView alloc] initWithFrame:CGRectMake(1395*0.5*DEF_Adaptation_Font_x,894*0.5*DEF_Adaptation_Font, 154*0.5*DEF_Adaptation_Font, 158*0.5*DEF_Adaptation_Font)];
    [self runAnimation:@"shezhi" andCount:10 andImageV:settingV andDuration:1.7];
    
    completeV = [[UIImageView alloc] initWithFrame:CGRectMake(761*0.5*DEF_Adaptation_Font_x,711*0.5*DEF_Adaptation_Font, 453*0.5*DEF_Adaptation_Font, 113*0.5*DEF_Adaptation_Font)];
    [self runAnimation:@"diannao" andCount:34 andImageV:completeV andDuration:4];

    UIImageView* calendarView=[LooperToolClass createImageView:@"home_calendar.png" andRect:CGPointMake(147, 348) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [bkView addSubview:calendarView];
    
     UIImageView* homeView=[LooperToolClass createImageView:@"home_frame.png" andRect:CGPointMake(636,286) andTag:100 andSize:CGSizeZero andIsRadius:false];
    [bkView addSubview:homeView];
    
}

-(void)addTouchEvent:(CGPoint)Tpos andSize:(CGSize)Tsize andTag:(int)eventTag{

    NSMutableDictionary *TouchDic=[[NSMutableDictionary alloc] initWithCapacity:50];
    [TouchDic setObject:[NSValue valueWithCGPoint:Tpos] forKey:@"pos"];
    [TouchDic setObject:[NSValue valueWithCGSize:Tsize] forKey:@"size"];
    [TouchDic setObject:[NSNumber numberWithInt:eventTag] forKey:@"tag"];
    [touchArraylist addObject:TouchDic];
}


-(void)createTouchView{
    touchArraylist = [[NSMutableArray alloc] initWithCapacity:50];
    [self addTouchEvent:CGPointMake(150*0.5*DEF_Adaptation_Font, 615*0.5*DEF_Adaptation_Font) andSize:CGSizeMake(160*0.5*DEF_Adaptation_Font, 370*0.5*DEF_Adaptation_Font) andTag:1];
    [self addTouchEvent:CGPointMake(1326*0.5*DEF_Adaptation_Font, 967*0.5*DEF_Adaptation_Font) andSize:CGSizeMake(185*0.5*DEF_Adaptation_Font, 135*0.5*DEF_Adaptation_Font) andTag:2];
    [self addTouchEvent:CGPointMake(1047*0.5*DEF_Adaptation_Font, 704*0.5*DEF_Adaptation_Font) andSize:CGSizeMake(145*0.5*DEF_Adaptation_Font, 95*0.5*DEF_Adaptation_Font) andTag:3];
    [self addTouchEvent:CGPointMake(119*0.5*DEF_Adaptation_Font, 264*0.5*DEF_Adaptation_Font) andSize:CGSizeMake(332*0.5*DEF_Adaptation_Font, 212*0.5*DEF_Adaptation_Font) andTag:4];
}


-(int)computeTwoPointLine:(CGPoint)startP andEnd:(CGPoint)endPoint{
    
    double length =sqrt((endPoint.x-startP.x)*(endPoint.x-startP.x)+(endPoint.y-startP.y)*(endPoint.y-startP.y));
    
    return (int)length;
}


-(void)createAnimatedV{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createAnimatedView];
          [self addCaptionView];
             [self createCalendarView];
        
    });
}

-(void)addCaptionImage:(NSString*)imageName andPos:(CGPoint)pos{
    UIImage *captionSp = [UIImage imageNamed:imageName];

    UIImageView *captionImage = [[UIImageView alloc] initWithFrame:CGRectMake(pos.x*0.5*DEF_Adaptation_Font, pos.y*0.5*DEF_Adaptation_Font, captionSp.size.width*0.3*DEF_Adaptation_Font, captionSp.size.height*0.3*DEF_Adaptation_Font)];
    captionImage.image = captionSp;
    captionImage.alpha=0;
    [bkView addSubview:captionImage];
    [captionArray addObject:captionImage];

}

-(void)addCaptionView{
    captionArray = [[NSMutableArray alloc]initWithCapacity:50];
    
    [self addCaptionImage:@"home_exit.png" andPos:CGPointMake(187, 892)];
    [self addCaptionImage:@"home_message.png" andPos:CGPointMake(1110, 743)];
    [self addCaptionImage:@"home_4.png" andPos:CGPointMake(862, 468)];
    [self addCaptionImage:@"home_3.png" andPos:CGPointMake(1509, 442)];
    [self addCaptionImage:@"home_1.png" andPos:CGPointMake(782, 751)];
    [self addCaptionImage:@"home_2.png" andPos:CGPointMake(927, 746)];
    
    captionTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(captionViewUpdata) userInfo:nil repeats:true];
}

-(void)captionViewUpdata{
    for (UIImageView *imageV in captionArray){
        [UIView animateWithDuration:2.0 animations:^{
            imageV.alpha=1.0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:2.0 animations:^{
                imageV.alpha=0.0;
            }];
        }];
    }
}



-(void)initView{
    touchArray= [[NSMutableArray alloc] initWithCapacity:50];
    [self createBk];
    [self createTouchView];
    [self performSelector:@selector(createAnimatedV) withObject:nil afterDelay:0.5];
}



-(void)createCalendar:(NSString*)calendarImage andPoint:(CGPoint)point{
    UIImage *CalendarImage1 = [UIImage imageNamed:calendarImage];
    UIImageView *imageV =[[UIImageView alloc] initWithFrame:CGRectMake(point.x*0.5*DEF_Adaptation_Font, point.y*0.5*DEF_Adaptation_Font,CalendarImage1.size.width*0.3*DEF_Adaptation_Font, CalendarImage1.size.height*0.3*DEF_Adaptation_Font)];
    imageV.image = CalendarImage1;
    [bkView addSubview:imageV];
}


-(NSInteger)weekdayStringFromDate:(NSDate*)inputDate{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return theComponents.weekday;
    
}

-(void)createCalendarView{

    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    NSInteger m = [components month]; // month
    NSInteger d = [components day]; // day
    NSInteger y = [components year]; // year
    
    if(m<=9){
        [self createCalendar:@"calendar_0.png" andPoint:CGPointMake(170, 374)];
        [self createCalendar:[NSString stringWithFormat:@"calendar_%ld.png",(long)m] andPoint:CGPointMake(200, 374)];
    }else{
        int n=m %10;
        [self createCalendar:@"calendar_1.png" andPoint:CGPointMake(170, 374)];
        [self createCalendar:[NSString stringWithFormat:@"calendar_%ld.png",(long)n] andPoint:CGPointMake(200, 374)];
    }
    [self createCalendar:@"calendar_month.png" andPoint:CGPointMake(228, 374)];
    
    if(d<=9){
        [self createCalendar:@"calendar_0.png" andPoint:CGPointMake(271, 374)];
        [self createCalendar:[NSString stringWithFormat:@"calendar_%ld.png",(long)d] andPoint:CGPointMake(302, 374)];
    }else{
        int n=d %10;
        int nu =d/10;
        [self createCalendar:[NSString stringWithFormat:@"calendar_%ld.png",(long)nu] andPoint:CGPointMake(271, 374)];
        [self createCalendar:[NSString stringWithFormat:@"calendar_%ld.png",(long)n] andPoint:CGPointMake(302, 374)];
    }
    [self createCalendar:@"calendar_day.png" andPoint:CGPointMake(333, 374)];

    int week =[self weekdayStringFromDate:currentDate];

     [self createCalendar:[NSString stringWithFormat:@"calendar_w%d.png",week] andPoint:CGPointMake(275, 444)];
    
}




@end
