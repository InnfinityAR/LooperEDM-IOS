//
//  MoveLableView.m
//  Looper
//
//  Created by lujiawei on 22/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "MoveLableView.h"
#import "CreateLoopViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import <math.h>

@implementation MoveLableView{

    UIScrollView *moveTapScrollView;
    NSMutableArray *LableArray;
    
    NSMutableArray *_tagArray;

}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andTag:(NSArray*)tagArray
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (CreateLoopViewModel*)idObject;
        [self initView:tagArray];
        
        
    }
    return self;
    
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==2001){
        
        NSLog(@"%@",LableArray);
        
        [_obj removeLableView:LableArray];
    }

    if(button.tag<1000){
        UILabel *lable=(UILabel*)[button viewWithTag:1000];
        if([button isSelected]==true){
            [lable setTextColor:[UIColor whiteColor]];
            [button setSelected:false];
            [self removeLableArray:lable.text];
        }else {
             [lable setTextColor:[UIColor blackColor]];
            [button setSelected:true];
            [self addLableArray:lable.text];
        }
    }
}


-(void)addLableArray:(NSString*)lableStr{
    [LableArray addObject:lableStr];
}

-(void)removeLableArray:(NSString*)lableStr{
    
    for (int i=0;i<[LableArray count];i++){
        if([lableStr isEqualToString:[LableArray objectAtIndex:i]]==true){
            [LableArray removeObjectAtIndex:i];
        }
    }
}




-(void)initView:(NSArray*)tagArray{
    
    LableArray = [[NSMutableArray alloc] initWithCapacity:50];
    _tagArray = [[NSMutableArray alloc] initWithArray:tagArray];
    
    UIImageView * movebk=[LooperToolClass createImageView:@"bg_looperBg.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    
    [self addSubview:movebk];
    
    
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:2001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    
    
    UILabel *title = [LooperToolClass createLableView:CGPointMake(277*DEF_Adaptation_Font_x*0.5, 59*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"选择标签" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:title];
    
    UIButton *commitBtn =[LooperToolClass createBtnImageName:@"btn_commit_loop.png" andRect:CGPointMake(532, 57) andTag:2001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: commitBtn];
    
    
    [self createScrollView];
}


-(void)createScrollView{
    moveTapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 1010*DEF_Adaptation_Font*0.5)];
   [moveTapScrollView setContentSize:CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*1.5)];
    [self addSubview:moveTapScrollView];
     
    [self addMoveScrollContent];

}


-(int)createTipView:(NSArray*)array andStartY:(int)start_y{
    
    int fin_y=0;
    
    for (int i=0;i<[array count];i++){
        
        int num = i +1;
        int num_x = num%3;
        int num_y = ceil(num/3.0);
        if(num_x==0){
            num_x=3;
        }
        NSLog(@"%d",num_y);
        
        UIButton *selBtn =[LooperToolClass createBtnImageName:@"btn_unSelect.png" andRect:CGPointMake(167+(154*(num_x-1)), start_y+((num_y-1)*85)) andTag:[[[array objectAtIndex:i] objectForKey:@"diyflag_id"] intValue] andSelectImage:@"btn_select.png" andClickImage:nil andTextStr:[[array objectAtIndex:i] objectForKey:@"diyflag_name"] andSize:CGSizeZero andTarget:self];
        [moveTapScrollView addSubview: selBtn];
        
        for(int j=0;j<[_tagArray count];j++){
            if([[[array objectAtIndex:i] objectForKey:@"diyflag_name"] isEqualToString:[_tagArray objectAtIndex:j]]==true){
                [selBtn setSelected:true];
                [LableArray addObject:[_tagArray objectAtIndex:j]];
                UILabel *lable=(UILabel*)[selBtn viewWithTag:1000];
                [lable setTextColor:[UIColor blackColor]];
                break;
            }
        }
        
        
    
        fin_y =  start_y+((num_y-1)*85) +85;
    }
    return fin_y;
}


-(void)addMoveScrollContent{
    
    NSMutableArray *tapArray = [[NSMutableArray alloc] initWithArray:[[_obj tapData] objectForKey:@"data"]];
    
    NSMutableArray *arrayStatus= [[NSMutableArray alloc] initWithCapacity:50];
    NSMutableArray *arrayScene= [[NSMutableArray alloc] initWithCapacity:50];
    NSMutableArray *arrayStyle= [[NSMutableArray alloc] initWithCapacity:50];
    
    for (int i =0;i<[tapArray count];i++){
        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[tapArray objectAtIndex:i]];
        if([[dic objectForKey:@"pid"] intValue]==1){
            [arrayStatus addObject:dic];
        }else if([[dic objectForKey:@"pid"] intValue]==2){
            [arrayScene addObject:dic];
        }else if([[dic objectForKey:@"pid"] intValue]==3){
            [arrayStyle addObject:dic];
        }
    }
    
    
    UIImageView * statusI=[LooperToolClass createImageView:@"icon_status.png" andRect:CGPointMake(20, 29) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [moveTapScrollView addSubview:statusI];
    
    int first_Y=[self createTipView:arrayStatus andStartY:49];
    
    UIImageView * sceneI=[LooperToolClass createImageView:@"icon_scene.png" andRect:CGPointMake(20, first_Y) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [moveTapScrollView addSubview:sceneI];
    first_Y=[self createTipView:arrayScene andStartY:first_Y+20];
    
    UIImageView * styleI=[LooperToolClass createImageView:@"icon_style.png" andRect:CGPointMake(20, first_Y) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [moveTapScrollView addSubview:styleI];
    first_Y=[self createTipView:arrayStyle andStartY:first_Y+20];
    
    
    
    
    
}



@end
