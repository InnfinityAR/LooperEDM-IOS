//
//  LiveShowView.m
//  Looper
//
//  Created by lujiawei on 19/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LiveShowView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "MainViewModel.h"
#import "UIImageView+WebCache.h"

@implementation LiveShowView
{
    
    NSArray *liveShowArray;
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(NSArray*)array{

    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        [self initView:array];
        
    }
    return self;
}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
   
    if(button.tag==101){
        
        [self removeFromSuperview];
    }
}


-(int)getContentLength:(NSString*)contentStr{
    
    float num_x =0;
    NSString *perchar;
    int alength = [contentStr length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [contentStr characterAtIndex:i];
        NSString *temp = [contentStr substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            num_x = num_x+26*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>64)&&(commitChar<91)){
            num_x = num_x +19*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>96)&&(commitChar<123)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else if((commitChar>47)&&(commitChar<58)){
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }else{
            num_x = num_x +14*DEF_Adaptation_Font_x*0.5;
        }
    }
    return num_x;
}





-(void)createActiveView:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);
    
    for (int i=0;i<[liveShowArray count] ;i++){
        if([[[liveShowArray objectAtIndex:i] objectForKey:@"activityid"] intValue] ==tap.view.tag){
            [_obj createActivityView:[[liveShowArray objectAtIndex:i] objectForKey:@"activityid"]];
            
            break;
        }
    }
}



-(void)createActiveCellView:(NSDictionary*)data andBgView:(UIView*)view{
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5,44*DEF_Adaptation_Font*0.5, 210*DEF_Adaptation_Font*0.5, 308*DEF_Adaptation_Font*0.5)];
    [imageV sd_setImageWithURL:[[NSURL alloc] initWithString: [data objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    imageV.tag = [[data objectForKey:@"activityid"] intValue];
    imageV.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createActiveView:)];
    [imageV addGestureRecognizer:singleTap];
    
    imageV.layer.cornerRadius = 6*DEF_Adaptation_Font*0.5;
    imageV.layer.masksToBounds = YES;
    [view addSubview:imageV];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(276*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 66*DEF_Adaptation_Font*0.5)];
    titleLable.numberOfLines = 0;
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:20]];
    titleLable.text = [data objectForKey:@"activityname"];
    [view addSubview:titleLable];
    
    UILabel *tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,[self getContentLength:[data objectForKey:@"tag"]]+15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
    [tagLable setTextColor:[UIColor whiteColor]];
    [tagLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
    tagLable.text = [data objectForKey:@"tag"];
    [tagLable setBackgroundColor:[UIColor colorWithRed:25/255.0 green:196/255.0 blue:193/255.0 alpha:1.0]];
    [view addSubview:tagLable];
    [tagLable setTextAlignment:NSTextAlignmentCenter];
    tagLable.layer.cornerRadius = 13*DEF_Adaptation_Font*0.5;
    tagLable.layer.masksToBounds = YES;
    
    UIImageView *icon_time=[LooperToolClass createImageView:@"time.png" andRect:CGPointMake(276, 200) andTag:100 andSize:CGSizeMake(16*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:icon_time];
    
    icon_time.frame = CGRectMake(icon_time.frame.origin.x, icon_time.frame.origin.y, 24*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5);
    
    UIImageView *icon_location=[LooperToolClass createImageView:@"locaton.png" andRect:CGPointMake(276, 242) andTag:100 andSize:CGSizeMake(16*DEF_Adaptation_Font*0.5, 16*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [view addSubview:icon_location];
    
    icon_location.frame = CGRectMake(icon_location.frame.origin.x, icon_location.frame.origin.y, 24*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5);
    
    
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 200*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    [timeLable setTextColor:[UIColor whiteColor]];
    [timeLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    timeLable.text = [data objectForKey:@"starttime"];
    [view addSubview:timeLable];
    
    UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 65*DEF_Adaptation_Font*0.5)];
    [locationLable setTextColor:[UIColor whiteColor]];
    locationLable.numberOfLines=0;
    [locationLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    locationLable.text = [data objectForKey:@"location"];
    [locationLable sizeToFit];
    [view addSubview:locationLable];
    
     CGSize maximumSize = CGSizeMake(294*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5);
    NSString *dateString = [data objectForKey:@"location"];
    UIFont *dateFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    CGSize dateStringSize = [dateString sizeWithFont:dateFont
                                   constrainedToSize:maximumSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    CGRect dateFrame = CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, dateStringSize.height);
    locationLable.frame = dateFrame;
    
    if([data[@"ticketurl"] isEqualToString:@""]==true){
        
        UIImageView *icon_price=[LooperToolClass createImageView:@"icon_price.png" andRect:CGPointMake(278, 308) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_price];
    }else{
        UIImageView *icon_ticket=[LooperToolClass createImageView:@"icon_ticket.png" andRect:CGPointMake(278, 308) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_ticket];
    }
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(368*DEF_Adaptation_Font*0.5, 308*DEF_Adaptation_Font*0.5, 235*DEF_Adaptation_Font*0.5, 32*DEF_Adaptation_Font*0.5)];
    [priceLable setTextColor:[UIColor colorWithRed:191/255.0 green:252/255.0 blue:255/255.0 alpha:1.0]];
    [priceLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    priceLable.text = [data objectForKey:@"price"];
    [view addSubview:priceLable];

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, view.frame.size.height, 568*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor colorWithRed:160/255.0 green:138/255.0 blue:197/255.0 alpha:0.1f]];
    [view addSubview:line];
    
}


-(void)createHudView{
    
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    
    UILabel* titleStr = [LooperToolClass createLableView:CGPointMake(230*DEF_Adaptation_Font*0.5,54*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(180*DEF_Adaptation_Font_x*0.5, 24*DEF_Adaptation_Font_x*0.5) andText:@"Live Show" andFontSize:14 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    [self addSubview:titleStr];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self createActiveCellView:[liveShowArray objectAtIndex:indexPath.row] andBgView:cell.contentView];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  374*DEF_Adaptation_Font*0.5;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    [_obj createActivityView:[[liveShowArray objectAtIndex:indexPath.row] objectForKey:@"activityid"]];

    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [liveShowArray count];
}



-(void)createSrollView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 113*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 1025*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
    [self addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    //不出现滚动条
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    //取消button点击延迟
    tableView.delaysContentTouches = NO;
    //禁止上拉
    tableView.alwaysBounceVertical=NO;
    tableView.bounces=NO;    

}

-(void)initView:(NSArray*)liveArray{
    
    liveShowArray=liveArray;
    
    [self createHudView];
    
    [self createSrollView];
    
    
}

@end
