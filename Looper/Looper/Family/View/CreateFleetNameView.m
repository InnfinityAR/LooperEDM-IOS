//
//  CreateFleetNameView.m
//  Looper
//
//  Created by lujiawei on 15/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "CreateFleetNameView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"


@implementation CreateFleetNameView {

    UITextField *fleetTextName;

    


}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {

    if (self = [super initWithFrame:frame]) {
        self.obj = (FamilyViewModel*)idObject;
        [self initView];
    }
    return self;
    
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==5000){
        
        [self removeFromSuperview];
    }else if(button.tag==5001){
        if(fleetTextName.text.length>0){
            NSLog(@"11111111");

            [_obj createFleetGroup:fleetTextName.text];
        }
        
    }
}


-(UITextField*)createTextField:(NSString*)string andRect:(CGRect)rect andTag:(int)num{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(rect.origin.x*DEF_Adaptation_Font*0.5,rect.origin.y*DEF_Adaptation_Font*0.5,  rect.size.width*DEF_Adaptation_Font*0.5, rect.size.height*DEF_Adaptation_Font*0.5)];
    [textField setPlaceholder:string];
    [textField setValue:[UIColor colorWithRed:140/255.0 green:130/255.0 blue:139/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.textColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    textField.font =[UIFont fontWithName:looperFont size:14*DEF_Adaptation_Font];
    textField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
    textField.delegate = self;
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    textField.textAlignment = string;
    [textField setBackgroundColor:[UIColor clearColor]];
    textField.layer.borderColor= [UIColor grayColor].CGColor;
    textField.layer.cornerRadius=8*DEF_Adaptation_Font*0.5;
    textField.layer.masksToBounds=YES;
    
    textField.layer.borderWidth= 1.0f;
    return textField;
}


-(void)initView{
    
    UIView* bkV =[[UIView alloc] initWithFrame:CGRectMake(31*DEF_Adaptation_Font*0.5, 117*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5, 978*DEF_Adaptation_Font*0.5)];
    [bkV setBackgroundColor:[UIColor colorWithRed:85/255.0 green:76/255.0 blue:107/255.0 alpha:1.0]];
    [self addSubview:bkV];
    bkV.layer.cornerRadius=12.0*DEF_Adaptation_Font*0.5;
    bkV.layer.masksToBounds=YES;
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 585*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerView.image=[UIImage imageNamed:@"family_header_BG"];
    [bkV addSubview:headerView];
    
    UILabel *headerLB=[[UILabel alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 0, bkV.frame.size.width-180*DEF_Adaptation_Font*0.5, 68*DEF_Adaptation_Font*0.5)];
    headerLB.textAlignment=NSTextAlignmentCenter;
    headerLB.text=@"新建舰队";
    headerLB.textColor=[UIColor whiteColor];
    headerLB.font=[UIFont boldSystemFontOfSize:18];
    [bkV addSubview:headerLB];
    
    UIButton *closeBtn = [LooperToolClass createBtnImageName:@"btn_Family_close.png" andRect:CGPointMake(500, 10) andTag:5000 andSelectImage:@"btn_Family_close.png" andClickImage:@"btn_Family_close.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:closeBtn];
    
    
    
    UIButton *commitBtn = [LooperToolClass createBtnImageName:@"btn_family_commit.png" andRect:CGPointMake(56, 891) andTag:5001 andSelectImage:@"btn_Family_uncommit.png" andClickImage:@"btn_Family_uncommit.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [bkV addSubview:commitBtn];
    
    fleetTextName = [self createTextField:@"输入舰队名字" andRect:CGRectMake(55, 131, 471, 53) andTag:100];
    [bkV addSubview:fleetTextName];



}



@end
