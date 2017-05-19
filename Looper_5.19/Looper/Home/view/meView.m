//
//  meView.m
//  Looper
//
//  Created by lujiawei on 12/27/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "meView.h"
#import "HomeViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "UIImage+RTTint.h"

@implementation meView{

    NSMutableArray *musicArray;
    UIImageView *bk;
    
    double colorNum;
    NSTimer *timeColor;
    

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
     colorNum = 0.01f;
    
    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(18*DEF_Adaptation_Font*0.5,39*DEF_Adaptation_Font*0.5,615*DEF_Adaptation_Font_x*0.5, 1018*DEF_Adaptation_Font*0.5)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
     [self addSubview:bk1];
                  bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    bk=[LooperToolClass createImageView:@"bg_me_back.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk];
    

    UIImageView *bk_font=[LooperToolClass createImageView:@"bg_me_front.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
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



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag == meBackTag){
    
        [timeColor invalidate];
    
    }
    
    
    
    [self.obj hudOnClick:button.tag];
    
}

-(void)initWithData:(NSDictionary*)mineData{
    
    
    UIImageView *imageHeadV = [[UIImageView alloc] initWithFrame:CGRectMake(256*0.5*DEF_Adaptation_Font,96*0.5*DEF_Adaptation_Font, 130*0.5*DEF_Adaptation_Font,130*0.5*DEF_Adaptation_Font)];

    [imageHeadV sd_setImageWithURL:[mineData objectForKey:@"HeadImageUrl"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    imageHeadV.layer.cornerRadius = 65*0.5*DEF_Adaptation_Font;
    imageHeadV.layer.masksToBounds = YES;
    
    [self addSubview:imageHeadV];

    
    UIButton *head = [LooperToolClass createBtnImageName:@"icon_me_head.png" andRect:CGPointMake(251, 92) andTag:meHeadTag andSelectImage:@"icon_me_head.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:head];
    
}



-(void)createHudView{
    
    UIButton *backBtn = [LooperToolClass createBtnImageName:@"btn_me_back.png" andRect:CGPointMake(48, 76) andTag:meBackTag andSelectImage:@"btn_me_back.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *TrendsBtn = [LooperToolClass createBtnImageName:@"icon_me_Trends.png" andRect:CGPointMake(126, 266) andTag:meTrendsTag andSelectImage:@"icon_me_Trends.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    //[self addSubview:TrendsBtn];
    
    UIButton *followBtn = [LooperToolClass createBtnImageName:@"icon_me_follow.png" andRect:CGPointMake(280, 266) andTag:meFollowTag andSelectImage:@"icon_me_follow.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
   // [self addSubview:followBtn];
    
    UIButton *fansBtn = [LooperToolClass createBtnImageName:@"icon_me_fans.png" andRect:CGPointMake(439, 267) andTag:meFansTag andSelectImage:@"icon_me_fans.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
   // [self addSubview:fansBtn];
    
    UIButton *logoutBtn = [LooperToolClass createBtnImageName:@"btn_me_logout.png" andRect:CGPointMake(234, 867) andTag:meLogOutTag andSelectImage:@"btn_me_logout.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:logoutBtn];


    UIButton *head = [LooperToolClass createBtnImageName:@"icon_me_head.png" andRect:CGPointMake(251, 92) andTag:meHeadTag andSelectImage:@"icon_me_head.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:head];

    
}

-(void)addArrayImage:(NSString*)imageN andTag:(int)tag{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:imageN forKey:@"image"];
    [dic setObject:[NSNumber numberWithInt:tag] forKey:@"imageTag"];
    
    [musicArray addObject:dic];

}


-(void)createTableView{
    
    musicArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self addArrayImage:@"btn_me_setting.png" andTag:meSettingTag];
    [self addArrayImage:@"btn_me_share.png" andTag:meShareTag];
    [self addArrayImage:@"btn_me_about.png" andTag:meAboutTag];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(24*0.5*DEF_Adaptation_Font, 385*0.5*DEF_Adaptation_Font,598*DEF_Adaptation_Font_x*0.5, 210*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",[[musicArray objectAtIndex:indexPath.row] objectForKey:@"imageTag"]);
    
    
     [self.obj hudOnClick:[[[musicArray objectAtIndex:indexPath.row] objectForKey:@"imageTag"] intValue]];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return  70*DEF_Adaptation_Font*0.5;


}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [musicArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    UIImageView *tempBg=[LooperToolClass createImageView:[[musicArray objectAtIndex:indexPath.row] objectForKey:@"image"] andRect:CGPointMake(85*DEF_Adaptation_Font_x*0.5,16*DEF_Adaptation_Font*0.5) andTag:100 andSize:CGSizeMake(220*DEF_Adaptation_Font_x*0.5, 48*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    

    [cell.contentView addSubview:tempBg];
  
    
    return cell;
}





-(void)initView{

    [self createBk];
    [self createHudView];
    [self createTableView];


}
@end
