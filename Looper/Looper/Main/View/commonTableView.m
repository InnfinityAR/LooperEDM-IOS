
//
//  commonTableView.m
//  Looper
//
//  Created by lujiawei on 24/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "commonTableView.h"
#import "LooperConfig.h"
#import "MainViewModel.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import "UserInfoViewModel.h"

#import "LooperScorllLayer.h"

@implementation commonTableView
{

    NSInteger VMNumber;
    UITableView *tableView;
    NSArray *commonArray;

}

@synthesize obj = _obj;
@synthesize typeView = _typeView;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(int)type
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MainViewModel*)idObject;
        VMNumber=[self.obj VMNumber];
        self.typeView= type;
        [self initView];
        
    }
    return self;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_typeView==1){
        NSDictionary *dic = [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"Follow"] objectAtIndex:indexPath.row];
        [_obj pushControllerToUser:dic];
    }else if(_typeView==2){
          NSDictionary *dic = [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"Fans"] objectAtIndex:indexPath.row];
        [_obj pushControllerToUser:dic];
    }else if(_typeView==3){
        NSDictionary *dic = [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"MyLoop"] objectAtIndex:indexPath.row];
        [_obj JumpLooperView:dic];
    }else if(_typeView==4){
       
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_typeView==1){
        return 94*DEF_Adaptation_Font*0.5;
    }else if(_typeView==2){
        return 94*DEF_Adaptation_Font*0.5;
    }else if(_typeView==3){
        return 162*DEF_Adaptation_Font*0.5;
    }else if(_typeView==4){
        return 130*DEF_Adaptation_Font*0.5;
    }
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_typeView==1){
         return [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"Follow"] count];
    }else if(_typeView==2){
         return [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"Fans"] count];
    }else if(_typeView==3){
        return [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"MyLoop"] count];
    }else if(_typeView==4){
         return [[_obj musicData] count];
    }
    return 0;
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

    if(_typeView==1){
        NSDictionary *dic = [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"Follow"] objectAtIndex:indexPath.row];
        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(31*0.5*DEF_Adaptation_Font,21*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =66*DEF_Adaptation_Font*0.5/2;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        UIImageView * lineV1=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(128, 93) andTag:100 andSize:CGSizeZero andIsRadius:false];
        [cell.contentView addSubview:lineV1];
        
        UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(128*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font)];
        userName.text =[dic objectForKey:@"nickname"];
        [userName setTextColor:[UIColor whiteColor]];
        [userName setFont:[UIFont fontWithName:looperFont size:17]];
        [cell.contentView addSubview:userName];
        
    }else if(_typeView==2){
        NSDictionary *dic = [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"Fans"] objectAtIndex:indexPath.row];
        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(31*0.5*DEF_Adaptation_Font,21*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font, 66*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =66*DEF_Adaptation_Font*0.5/2;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        UIImageView * lineV1=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(128, 93) andTag:100 andSize:CGSizeZero andIsRadius:false];
        [cell.contentView addSubview:lineV1];
        
        UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(128*0.5*DEF_Adaptation_Font, 23*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font)];
        userName.text =[dic objectForKey:@"nickname"];
        [userName setTextColor:[UIColor whiteColor]];
        [userName setFont:[UIFont fontWithName:looperFont size:17]];
        [cell.contentView addSubview:userName];
        
    }else if(_typeView==3){
        NSDictionary *dic = [[[[_obj MainData] objectForKey:@"data"] objectForKey:@"MyLoop"] objectAtIndex:indexPath.row];
        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(31*0.5*DEF_Adaptation_Font,22*0.5*DEF_Adaptation_Font, 111*0.5*DEF_Adaptation_Font, 111*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"loopcover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =6*DEF_Adaptation_Font*0.5;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];
        
        UILabel *loopName = [[UILabel alloc] initWithFrame:CGRectMake(160*0.5*DEF_Adaptation_Font, 17*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 53*0.5*DEF_Adaptation_Font)];
        loopName.text =[dic objectForKey:@"looptitle"];
        [loopName setTextColor:[UIColor whiteColor]];
        [loopName setFont:[UIFont fontWithName:looperFont size:17]];
        [cell.contentView addSubview:loopName];

        UIImageView * lineV1=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(26, 159) andTag:100 andSize:CGSizeZero andIsRadius:false];
        [cell.contentView addSubview:lineV1];
        
        
        LooperScorllLayer *sildeV = [[LooperScorllLayer alloc] initWithFrame:CGRectMake(160*DEF_Adaptation_Font*0.5, 95*DEF_Adaptation_Font*0.5, 470*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5) and:self];
        [cell.contentView addSubview:sildeV];
        
        [sildeV initView:CGRectMake(0,0, 470*DEF_Adaptation_Font*0.5, 35*DEF_Adaptation_Font*0.5) andStr:[ [dic objectForKey:@"news_tag"] componentsSeparatedByString:@","] andType:1];
        

    }else if(_typeView==4){
        NSDictionary *dic = [[_obj musicData] objectAtIndex:indexPath.row];

        UIImageView *loopHead = [[UIImageView alloc] initWithFrame:CGRectMake(26*0.5*DEF_Adaptation_Font,18*0.5*DEF_Adaptation_Font, 74*0.5*DEF_Adaptation_Font, 74*0.5*DEF_Adaptation_Font)];
        [loopHead sd_setImageWithURL:[[NSURL alloc] initWithString: [dic objectForKey:@"music_cover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        loopHead.layer.cornerRadius =6*DEF_Adaptation_Font*0.5;
        loopHead.layer.masksToBounds = YES;
        [cell.contentView addSubview:loopHead];

        UILabel *loopName = [[UILabel alloc] initWithFrame:CGRectMake(142*0.5*DEF_Adaptation_Font, 18*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 30*0.5*DEF_Adaptation_Font)];
        loopName.text =[dic objectForKey:@"filename"];
        [loopName setTextColor:[UIColor whiteColor]];
        [loopName setTextAlignment:NSTextAlignmentLeft];
        [loopName setFont:[UIFont fontWithName:looperFont size:15]];
        [cell.contentView addSubview:loopName];
        
        UILabel *loopartist = [[UILabel alloc] initWithFrame:CGRectMake(142*0.5*DEF_Adaptation_Font, 62*0.5*DEF_Adaptation_Font, 418*0.5*DEF_Adaptation_Font, 30*0.5*DEF_Adaptation_Font)];
        loopartist.text =[dic objectForKey:@"artist"];
        [loopartist setTextColor:[UIColor whiteColor]];
        [loopartist setTextAlignment:NSTextAlignmentLeft];
        [loopartist setFont:[UIFont fontWithName:looperFont size:13]];
        [cell.contentView addSubview:loopartist];
        

        UIImageView * lineV1=[LooperToolClass createImageView:@"bg_line.png" andRect:CGPointMake(25, 128) andTag:100 andSize:CGSizeZero andIsRadius:false];
        [cell.contentView addSubview:lineV1];

    }
    
    
    return cell;
}

-(void)updataView{

    [tableView reloadData];


}


-(void)createTableView{

    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 170*0.5*DEF_Adaptation_Font,DEF_SCREEN_WIDTH, 1030*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
//    if (VMNumber) {
//    UserInfoViewModel *viewModel=self.obj;
    if(button.tag==2000){
        [_obj removeCommonView];
    }else if(button.tag==201){
         [_obj toCreateLooperView];
    }

}

-(void)initView{
    
    UIImageView * bk=[LooperToolClass createImageView:@"bg_setting.png" andRect:CGPointMake(0, 0) andTag:100 andSize:CGSizeMake(DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT) andIsRadius:false];
    [self addSubview:bk];
    
    UIButton *backBtn =[LooperToolClass createBtnImageName:@"btn_looper_back.png" andRect:CGPointMake(15, 65) andTag:2000 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview: backBtn];
    
    NSString *titleStr;
    
    [self createTableView];
    
    if(_typeView==1){
        titleStr = @"关注";
    }else if(_typeView==2){
        titleStr = @"粉丝";
    }else if(_typeView==3){
         titleStr = @"我的loop";
        if (VMNumber) {
            titleStr=@"他的loop";
        }
        UIButton *createLoopBtn =[LooperToolClass createBtnImageName:@"createLoopbtn.png" andRect:CGPointMake(271, 950) andTag:201 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeZero andTarget:self];
        [self addSubview:createLoopBtn];
        
    }else if(_typeView==4){
         titleStr = @"我喜欢的音乐";
        if (VMNumber) {
            titleStr=@"他的收藏";
        }
    }
    
    UILabel *titleNum = [LooperToolClass createLableView:CGPointMake(232*DEF_Adaptation_Font_x*0.5, 50*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(176*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font_x*0.5) andText:titleStr andFontSize:13 andColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [self addSubview:titleNum];
    
    
    

}


@end
