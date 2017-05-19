//
//  MineView.m
//  Looper
//
//  Created by lujiawei on 12/30/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "MineView.h"
#import "HomeViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "SelectToolView.h"

@implementation MineView{

    NSMutableArray *mineArray;
    SelectToolView *select;

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

-(void)initView{
    
    [self createBackGround];
    [self createHubView];
    [self createTableView];
}




-(void)addArrayImage:(NSString*)str andTag:(int)tag{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:str forKey:@"str"];
    [dic setObject:[NSNumber numberWithInt:tag] forKey:@"imageTag"];
    [mineArray addObject:dic];
    
}


-(void)selectViewType:(int)type andSelectNum:(int)selNum andSelectStr:(NSString*)Selstr{

    [select removeFromSuperview];
    if(type==101){
        if(selNum==0){
            [_obj takePhoto];
        }else if(selNum==1){
            [_obj LocalPhoto];
        }
    }else if(type==102){
        
    
    
    }else if(type==103){
        
        
        
    }
    
    

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    int num=[[[mineArray objectAtIndex:indexPath.row] objectForKey:@"imageTag"] intValue];
    
    if(num==101){
        select =[[SelectToolView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        select.multipleTouchEnabled=true;
        [self addSubview:select];
        NSMutableArray *array =[[NSMutableArray alloc] initWithCapacity:50];
        [array addObject:@"拍照"];
        [array addObject:@"从相册中选择"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:array forKey:@"dataArray"];
        [select initView:dic andViewType:2 andTypeTag:num];
    }else if(num==102){
    
    
    }else if(num==103){
        
        
    }else if(num==104){
        
        
    }else if(num==105){
        
        
    }else if(num==106){
        select =[[SelectToolView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        select.multipleTouchEnabled=true;
        [self addSubview:select];
        [select initView:nil andViewType:3 andTypeTag:num];

        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  50*DEF_Adaptation_Font*0.5;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mineArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];

    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(60*0.5*DEF_Adaptation_Font,14*0.5*DEF_Adaptation_Font, 200*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
    
    lable.text = [[mineArray objectAtIndex:indexPath.row] objectForKey:@"str"];
    
    lable.font = [UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    
    
    lable.textColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    
    [cell.contentView addSubview:lable];
    
    int num=[[[mineArray objectAtIndex:indexPath.row] objectForKey:@"imageTag"] intValue];
    
    if(num==101){
       // UIImageView *head = [LooperToolClass createImageView:@"icon_headPic.png" andRect:<#(CGPoint)#> andTag:100 andSize:<#(CGSize)#> andIsRadius:false];
        //[cell.contentView addSubview:head];
    }
    
    
    

    return cell;
}



-(void)createTableView{
    mineArray = [[NSMutableArray alloc] initWithCapacity:50];
    [self addArrayImage:@"头像" andTag:101];
    [self addArrayImage:@"昵称" andTag:102];
    [self addArrayImage:@"性格标签" andTag:103];
    [self addArrayImage:@"性别" andTag:104];
    [self addArrayImage:@"生日" andTag:105];
    [self addArrayImage:@"所在地" andTag:106];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(20*0.5*DEF_Adaptation_Font, 200*0.5*DEF_Adaptation_Font,605*DEF_Adaptation_Font_x*0.5, 300*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
    
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
    [self.obj hudOnClick:button.tag];
    
}

-(void)createHubView{

    UIButton *backBtn = [LooperToolClass createBtnImageName:@"btn_mine_back.png" andRect:CGPointMake(48, 76) andTag:MineBackTag andSelectImage:@"btn_mine_back.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:backBtn];
    
}


-(void)createBackGround{
    
    UIView *bk1 = [[UIView alloc] initWithFrame:CGRectMake(18*DEF_Adaptation_Font*0.5,39*DEF_Adaptation_Font*0.5,604*DEF_Adaptation_Font_x*0.5, 1006*DEF_Adaptation_Font*0.5)];
    
    [bk1  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addSubview:bk1];
    bk1.layer.cornerRadius =16*DEF_Adaptation_Font*0.5;
    
    UIImageView *bk=[LooperToolClass createImageView:@"bg_setting_behind.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    
    [self addSubview:bk];
    
    UIImageView *bk_font=[LooperToolClass createImageView:@"bg_setting_front.png" andRect:CGPointMake(7, 30) andTag:100 andSize:CGSizeMake(626*DEF_Adaptation_Font_x*0.5, 1028*DEF_Adaptation_Font*0.5) andIsRadius:false];
    [self addSubview:bk_font];
    
}








@end
