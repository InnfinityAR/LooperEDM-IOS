//
//  HowToPlayView.m
//  Looper
//
//  Created by lujiawei on 2/6/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "HowToPlayView.h"
#import "LooperConfig.h"

#define startLayer 1
#define mapLayer 2
#define loopLayer 3

@implementation HowToPlayView{


    NSMutableArray *ActionArray;
    bool isBegin;
    bool isClose;
    
    int actionIndex;
    
    
    UIImageView *turnRightLable;
    UIImageView *turnRight;
    UIImageView *hand;
    
    
    UIImageView *turnDownLable;
    UIImageView *turnDown;
    
    
    int index;
    

}

@synthesize obj = _obj;


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = idObject;
        [self initView];
    }
    return self;
}

-(void)initView{
    isBegin = false;
    isClose = false;
    ActionArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];

    

}



-(void)actionMove{
    if(isBegin == true){
        if([ActionArray count]-1>=actionIndex){
            int num_x = -500;
            if(actionIndex%2==1){
                num_x = 500;
            }
            NSDictionary *dic = [ActionArray objectAtIndex:actionIndex];
            UIImage *actionImage = [UIImage imageNamed:[dic objectForKey:@"pic"]];
            UIImageView *actionSp = [[UIImageView alloc] initWithFrame:CGRectMake([[dic objectForKey:@"x"] intValue]*DEF_Adaptation_Font*0.5+num_x, [[dic objectForKey:@"y"] intValue]*DEF_Adaptation_Font*0.5, actionImage.size.width*0.3*DEF_Adaptation_Font, actionImage.size.height*0.3*DEF_Adaptation_Font)];
            actionSp.image = actionImage;
            [self addSubview:actionSp];
            
            
            [UIView animateWithDuration:0.4 animations:^{
                int num_Offset;
                if(num_x>0){
                    num_Offset = -20;
                }else{
                    num_Offset = 20;
                }
                actionSp.frame= CGRectMake([[dic objectForKey:@"x"] intValue]*DEF_Adaptation_Font*0.5+num_Offset,actionSp.frame.origin.y, actionSp.frame.size.width, actionSp.frame.size.height);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    int num_Offset;
                    if(num_x>0){
                        num_Offset = 30;
                    }else{
                        num_Offset = -30;
                    }
                    actionSp.frame= CGRectMake(actionSp.frame.origin.x+num_Offset,actionSp.frame.origin.y, actionSp.frame.size.width, actionSp.frame.size.height);
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        actionSp.frame= CGRectMake([[dic objectForKey:@"x"] intValue]*DEF_Adaptation_Font*0.5,actionSp.frame.origin.y, actionSp.frame.size.width, actionSp.frame.size.height);
                    }];
                }];
                
            }];
            actionIndex = actionIndex +1;
            if(actionIndex == [ActionArray count]){
                [self performSelector:@selector(setCloseStatus) withObject:nil afterDelay:1.0];
            }
            
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(isClose==true){
        [self removeFromSuperview];
    }
    
    if(index==3){
        [self actionMove];
    }
}

-(void)setCloseStatus{

    isClose = true;
}


-(NSDictionary*)createDicWithData:(NSString*)ImgStr andX:(int)pos_x andY:(int)pos_y{

    NSMutableDictionary *imageDic=[NSMutableDictionary dictionaryWithDictionary:@{@"pic":ImgStr,@"x":[[NSNumber alloc] initWithInt:pos_x],@"y":[[NSNumber alloc] initWithInt:pos_y]}];
    return imageDic;
}



-(UIImageView*)createImageView:(NSString*)imageStr andSize:(CGSize)size andPoint:(CGPoint)point{
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    imageV.image = [UIImage imageNamed:imageStr];
    return imageV;
}



-(void)intoSceenViewType:(int)SceenType{
    index =SceenType;
    [ActionArray removeAllObjects];
    if(SceenType==startLayer){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"howToOne"]!=nil){
             [self removeFromSuperview];
             return;
        }
        isBegin =true;
        actionIndex = 0;

        turnRightLable =[self createImageView:@"turn_right_lable.png" andSize:CGSizeMake(322*DEF_Adaptation_Font*0.5, 32*DEF_Adaptation_Font*0.5) andPoint:CGPointMake(158*DEF_Adaptation_Font*0.5, 846*DEF_Adaptation_Font*0.5)];
        
         [self addSubview:turnRightLable];
        
        turnRight =  [self createImageView:@"turn_right.png" andSize:CGSizeMake(422*DEF_Adaptation_Font*0.5, 32*DEF_Adaptation_Font*0.5) andPoint:CGPointMake(54*DEF_Adaptation_Font*0.5, 450*DEF_Adaptation_Font*0.5)];
        
        [self addSubview:turnRight];
        
        hand =  [self createImageView:@"hand.png" andSize:CGSizeMake(79*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5) andPoint:CGPointMake(88*DEF_Adaptation_Font*0.5, 562*DEF_Adaptation_Font*0.5)];
        
        [self addSubview:hand];
        
        
        [UIView animateWithDuration:1.0 animations:^{
            hand.frame = CGRectMake(hand.frame.origin.x +400*DEF_Adaptation_Font*0.5, hand.frame.origin.y, hand.frame.size.width, hand.frame.size.height);
        }completion:^(BOOL finished) {
             hand.frame = CGRectMake(79*DEF_Adaptation_Font*0.5, hand.frame.origin.y, hand.frame.size.width, hand.frame.size.height);
            sleep(0.8);
            [UIView animateWithDuration:1.0 animations:^{
               hand.frame = CGRectMake(hand.frame.origin.x +400*DEF_Adaptation_Font*0.5, hand.frame.origin.y, hand.frame.size.width, hand.frame.size.height);
            }completion:^(BOOL finished) {
                sleep(0.5);
                [turnRight removeFromSuperview];
                [turnRightLable removeFromSuperview];
                turnDownLable =[self createImageView:@"turn_down_lable.png" andSize:CGSizeMake(227*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andPoint:CGPointMake(207*DEF_Adaptation_Font*0.5, 847*DEF_Adaptation_Font*0.5)];
                
                [self addSubview:turnDownLable];
                
                turnDown =  [self createImageView:@"turn_down.png" andSize:CGSizeMake(31*DEF_Adaptation_Font*0.5, 532*DEF_Adaptation_Font*0.5) andPoint:CGPointMake(302*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5)];
                
                [self addSubview:turnDown];
                
                hand.frame = CGRectMake(371*DEF_Adaptation_Font*0.5, 264*DEF_Adaptation_Font*0.5, hand.frame.size.width, hand.frame.size.height);
                
                
                [UIView animateWithDuration:1.0 animations:^{
                    hand.frame = CGRectMake(hand.frame.origin.x, hand.frame.origin.y+400*DEF_Adaptation_Font*0.5, hand.frame.size.width, hand.frame.size.height);
                }completion:^(BOOL finished) {
                    hand.frame = CGRectMake(hand.frame.origin.x,  264*DEF_Adaptation_Font*0.5, hand.frame.size.width, hand.frame.size.height);
                    sleep(0.8);
                    [UIView animateWithDuration:1.0 animations:^{
                        hand.frame = CGRectMake(hand.frame.origin.x, hand.frame.origin.y+400*DEF_Adaptation_Font*0.5, hand.frame.size.width, hand.frame.size.height);
                    }completion:^(BOOL finished) {
                        sleep(0.5);
                        isClose=true;
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"howToOne"];
                    }];
                }];
            }];
        }];
        

    }else if(SceenType==mapLayer){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"howToTwo"]!=nil){
            [self removeFromSuperview];
            return;
        }
        isBegin =true;
        actionIndex = 0;
        [ActionArray addObject:[self createDicWithData:@"map_1.png" andX:194 andY:217]];
        [ActionArray addObject:[self createDicWithData:@"map_2.png" andX:23 andY:925]];
        [ActionArray addObject:[self createDicWithData:@"map_3.png" andX:286 andY:827]];
         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"howToTwo"];
        [self actionMove];


    }else if(SceenType==loopLayer){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"howToThree"]!=nil){
            [self removeFromSuperview];
             return;
        }
        isBegin =true;
        actionIndex = 0;
        [ActionArray addObject:[self createDicWithData:@"loop_1.png" andX:31 andY:108]];
        [ActionArray addObject:[self createDicWithData:@"loop_2.png" andX:78 andY:526]];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"howToThree"];
        [self actionMove];  
    }
}



@end
