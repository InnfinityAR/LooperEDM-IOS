//
//  SettingView.m
//  Looper
//
//  Created by lujiawei on 12/29/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "SettingView.h"
#import "HomeViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImage+RTTint.h"

@implementation SettingView{

    NSMutableArray *settingArray;
    NSTimer *timeColor;
    double colorNum;
    UIImageView *bk;

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

-(void)createBk{
    
     UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(18*DEF_Adaptation_Font*0.5,39*DEF_Adaptation_Font*0.5,615*DEF_Adaptation_Font_x*0.5, 1018*DEF_Adaptation_Font*0.5)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addSubview:bk1];
    bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    bk=[LooperToolClass createImageView:@"bg_setting_behind.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk];
    
    UIImageView *bk_font=[LooperToolClass createImageView:@"bg_setting_front.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:bk_font];

    timeColor = [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(updateColor) userInfo:nil repeats:YES];
}



-(void)updateColor{
    
    UIImage *tinted = [bk.image rt_tintedImageWithColor: [UIColor colorWithHue:colorNum+0.003f saturation:1.0 brightness:1.0 alpha:1.0] level:0.5f];
    colorNum = colorNum +0.003f;
    bk.image = tinted;
    if(colorNum>1.0){
        colorNum = 0.001f;
    }
}


-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageName:@"btn_setting_back.png" andRect:CGPointMake(48, 76) andTag:settingBack andSelectImage:@"btn_setting_back.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:backBtn];

    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
   
    
    if(settingBack==button.tag){
    
    
        [timeColor invalidate];
    }
    
     [self.obj hudOnClick:button.tag];
    
    
    
}

-(void)initView{
    [self createBk];
    [self createHudView];
    [self createTableView];

}


-(void)addArrayImage:(NSString*)imageN andTag:(int)tag{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:imageN forKey:@"image"];
    [dic setObject:[NSNumber numberWithInt:tag] forKey:@"imageTag"];
    
    [settingArray addObject:dic];
    
}


-(void)createTableView{
    
    settingArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self addArrayImage:@"btn_settiing_accounts.png" andTag:settingAccount];
    [self addArrayImage:@"btn_setting_message.png" andTag:settingMessage];
    [self addArrayImage:@"btn_setting_widecache.png" andTag:settingWidhCache];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(24*0.5*DEF_Adaptation_Font, 200*0.5*DEF_Adaptation_Font,598*DEF_Adaptation_Font_x*0.5, 210*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",[[settingArray objectAtIndex:indexPath.row] objectForKey:@"imageTag"]);
    
    
    [self.obj hudOnClick:[[[settingArray objectAtIndex:indexPath.row] objectForKey:@"imageTag"] intValue]];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  70*DEF_Adaptation_Font*0.5;
    
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [settingArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    UIImageView *tempBg=[LooperToolClass createImageView:[[settingArray objectAtIndex:indexPath.row] objectForKey:@"image"] andRect:CGPointMake(85*DEF_Adaptation_Font_x*0.5,34*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(183*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    
    
    [cell.contentView addSubview:tempBg];
    
    
    return cell;
}



@end
