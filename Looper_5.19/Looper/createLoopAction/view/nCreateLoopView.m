//
//  CreateLoopView.m
//  Looper
//
//  Created by lujiawei on 18/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "nCreateLoopView.h"
#import "CreateLoopViewModel.h"
#import "LooperConfig.h"
#import "DataHander.h"
#import "LooperToolClass.h"

@implementation nCreateLoopView{

    UIButton *uploadPic;
    UIImageView *firstV;
    UIImageView *SecondV;
    UITextField *looperName;
    
    NSString *firstStr;
    NSString *secondStr;
    
    NSMutableArray *tagArray;
    NSMutableArray *btnArray;
    UIButton *lineBk;
    
    bool isCreateLoop;
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (CreateLoopViewModel*)idObject;
        [self initView];
        
        
    }
    return self;
    
}


-(void)updataHeadView:(NSString*)picUrl andSecondUrl:(NSString*)SecondUrl{

    [firstV removeFromSuperview];
    [SecondV removeFromSuperview];

    [uploadPic setHidden:true];
    isCreateLoop = true;
    
    firstStr = picUrl;
    secondStr = SecondUrl;
    
    firstV = [[UIImageView alloc] initWithFrame:CGRectMake(73*DEF_Adaptation_Font*0.5, 630*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5)];
    firstV.image=[UIImage imageNamed:picUrl];
    [self addSubview:firstV];
    
    SecondV = [[UIImageView alloc] initWithFrame:CGRectMake(338*DEF_Adaptation_Font*0.5, 627*DEF_Adaptation_Font*0.5, 158*DEF_Adaptation_Font*0.5, 264*DEF_Adaptation_Font*0.5)];
    SecondV.image=[UIImage imageNamed:SecondUrl];
    [self addSubview:SecondV];
    
    uploadPic =[LooperToolClass createBtnImageName:@"reUpLoadPic.png" andRect:CGPointMake(70, 858) andTag:1002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: uploadPic];
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==200){
    
        [_obj backView];
    }else if(button.tag==1001){
        [self endEditing:YES];
        [_obj createLableView:tagArray];
    }else if(button.tag==1002){
    
        [self endEditing:YES];
        [_obj LocalPhoto];
    }else if(button.tag==900){
        
        if([looperName.text length]==0){
            [[DataHander sharedDataHander] showViewWithStr:@"请输入loop名称" andTime:1 andPos:CGPointZero];
        }else{
            if(isCreateLoop==true){
                
                [_obj createLoopRequset:looperName.text andPhoto1:firstStr andPhoto2:secondStr andTags:tagArray];
            }else{
            
                 [[DataHander sharedDataHander] showViewWithStr:@"请添加图片" andTime:1 andPos:CGPointZero];
            }
        
        
        
        }
    }
}


-(void)addTag:(NSArray*)tags{

    tagArray = [[NSMutableArray alloc] initWithArray:tags];
    
    [self updataViewTag];
   // [tagArray addObject:tagStr];
}

-(void)updataViewTag{
     [lineBk setFrame:CGRectMake(lineBk.frame.origin.x, 421*DEF_Adaptation_Font*0.5, lineBk.frame.size.width, lineBk.frame.size.height)];
    for (int i=0;i<[btnArray count];i++)
    {
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn removeFromSuperview];
    }
    [btnArray removeAllObjects];
    for (int i=0;i<[tagArray count];i++){
        if(i<3){
            UIButton *selBtn =[LooperToolClass createBtnImageName:@"btn_select.png" andRect:CGPointMake(63+(i*154),420) andTag:800 andSelectImage:@"btn_select.png" andClickImage:nil andTextStr:[tagArray objectAtIndex:i] andSize:CGSizeZero andTarget:self];
            UILabel *lable=(UILabel*)[selBtn viewWithTag:1000];
            [lable setTextColor:[UIColor blackColor]];
            [self addSubview: selBtn];
            [btnArray addObject:selBtn];
            [lineBk setFrame:CGRectMake(lineBk.frame.origin.x, 421*DEF_Adaptation_Font*0.5, lineBk.frame.size.width, lineBk.frame.size.height)];
        }
        if(2<i&&i<6){
            UIButton *selBtn =[LooperToolClass createBtnImageName:@"btn_select.png" andRect:CGPointMake(63+((i-3)*154),480) andTag:800 andSelectImage:@"btn_select.png" andClickImage:nil andTextStr:[tagArray objectAtIndex:i] andSize:CGSizeZero andTarget:self];
            UILabel *lable=(UILabel*)[selBtn viewWithTag:1000];
            [lable setTextColor:[UIColor blackColor]];
            [self addSubview: selBtn];
            [btnArray addObject:selBtn];
            
            [lineBk setFrame:CGRectMake(lineBk.frame.origin.x, 495*DEF_Adaptation_Font*0.5, lineBk.frame.size.width, lineBk.frame.size.height)];
        }
        
    }
}



-(void)initView{
    isCreateLoop = false;
    btnArray =[[NSMutableArray alloc] initWithCapacity:50];
    tagArray=[[NSMutableArray alloc] initWithCapacity:50];
    [self setBackgroundColor:[UIColor colorWithRed:17/255.0 green:18/255.0 blue:34/255.0 alpha:1.0]];
    
    [self createHudView];
    
}


-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(3,0,  rect.size.width, rect.size.height)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor colorWithRed:192/255.0 green:245/255.0 blue:55/255.0 alpha:1.0];
    textField.font =[UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.enablesReturnKeyAutomatically = YES;
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    return textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [self endEditing:true];
    
    
    return true;
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    
    [self endEditing:YES];

}



-(void)createHudView{
    UIImageView * bg=[LooperToolClass createImageView:@"bg_looperBg.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bg];
    
    UIButton *back =[LooperToolClass createBtnImageName:@"btn_infoBack.png" andRect:CGPointMake(1, 34) andTag:200 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: back];
    
    UILabel *title = [LooperToolClass createLableView:CGPointMake(277*DEF_Adaptation_Font_x*0.5, 59*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(92*DEF_Adaptation_Font_x*0.5, 27*DEF_Adaptation_Font_x*0.5) andText:@"创建loop" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:title];
    
    UIButton *commitBtn =[LooperToolClass createBtnImageName:@"btn_commit_loop.png" andRect:CGPointMake(532, 57) andTag:900 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: commitBtn];

    
    
    UILabel *loopName = [LooperToolClass createLableView:CGPointMake(64*DEF_Adaptation_Font_x*0.5, 156*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:@"loop名称" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:loopName];

    UILabel *label = [LooperToolClass createLableView:CGPointMake(64*DEF_Adaptation_Font_x*0.5, 363*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:@"标签" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:label];

    UILabel *Cover = [LooperToolClass createLableView:CGPointMake(64*DEF_Adaptation_Font_x*0.5, 570*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(90*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:@"loop封面" andFontSize:11 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
    [self addSubview:Cover];
    
    looperName =[self createTextField:@"请输入loop名字" andImg:@"bg_text.png" andRect:CGRectMake(62*DEF_Adaptation_Font_x*0.5, 213*DEF_Adaptation_Font_x*0.5, 505*DEF_Adaptation_Font_x*0.5, 58*DEF_Adaptation_Font_x*0.5) andTag:100];
    
    lineBk =[LooperToolClass createBtnImageName:@"bg_text.png" andRect:CGPointMake(62, 421) andTag:1001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: lineBk];
    
    uploadPic =[LooperToolClass createBtnImageName:@"btn_upload_pic.png" andRect:CGPointMake(187, 692) andTag:1002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: uploadPic];
    
    
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self addGestureRecognizer:singleTap];
    
    
    
}

@end
