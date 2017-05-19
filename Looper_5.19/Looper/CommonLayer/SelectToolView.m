//
//  SelectView.m
//  Looper
//
//  Created by lujiawei on 12/30/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "SelectToolView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "MineView.h"
#import "PSCityPickerView.h"


#define LableStr  @"LableStr"
#define dataArray @"dataArray"

@implementation SelectToolView{
    
    NSString *LableContent;
    NSArray *arrayData;
    int ViewType;
    int tag;
    UITableView *tableView;
    
    
}

@synthesize obj = _obj;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (MineView *)idObject;
    }
    return self;
}

-(void)createBk{

    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];

}



-(void)parseData:(NSDictionary*)data andType:(int)typeNum{
    ViewType = typeNum;
    if(typeNum==1){
        LableContent= [data objectForKey:LableStr];
    }else if(typeNum==2){
        arrayData= [data objectForKey:dataArray];

    }else if(typeNum==3){
        //arrayData = [data objectForKey:dataArray];
    }
}



-(void)initView:(NSDictionary*)dic andViewType:(int)TypeNum andTypeTag:(int)tagN{
    
    tag = tagN;
    
    [self createBk];
    [self parseData:dic andType:TypeNum];
    [self createSubView];
    
}

-(void)createSubView{

    if(ViewType ==1){
        [self createShowTitleView];
    }else if(ViewType==2){
        [self createTableView];
    }else if(ViewType ==3){
        [self createSelectView];
    }

}

-(void)createTableView{
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(66*0.5*DEF_Adaptation_Font, 388*0.5*DEF_Adaptation_Font,508*DEF_Adaptation_Font_x*0.5, [arrayData count]*80*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:40.0/255.0 blue:44.0/255.0 alpha:1.0]];
      tableView.layer.cornerRadius =8*DEF_Adaptation_Font*0.5;
    [self addSubview:tableView];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    if(tableView!=nil){
        [_obj selectViewType:tag andSelectNum:200 andSelectStr:nil];

    }


}



-(void)createSelectView{
    
    
}


- (void)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
     [_obj selectViewType:tag andSelectNum:button.tag andSelectStr:nil];
    
}


-(void)createShowTitleView{
    
    UIImage *image = [UIImage imageNamed:@"caption_frame.png"];
    
    UIImageView *imageView1 =[[UIImageView alloc] initWithFrame:CGRectMake(82*0.5*DEF_Adaptation_Font, 471*0.5*DEF_Adaptation_Font, 474*0.5*DEF_Adaptation_Font, 190*0.5*DEF_Adaptation_Font)];
    [self addSubview:imageView1];
    imageView1.image = image;
    imageView1.layer.cornerRadius =8*DEF_Adaptation_Font*0.5;
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(26*0.5*DEF_Adaptation_Font, 30*0.5*DEF_Adaptation_Font,300*0.5*DEF_Adaptation_Font, 25*0.5*DEF_Adaptation_Font)];
    label.text = LableContent;
    label.textColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:looperFont size:15*DEF_Adaptation_Font];
    
    [imageView1 addSubview:label];
    
    UIButton *cannel = [LooperToolClass createBtnImageName:@"caption_cannel.png" andRect:CGPointMake(490, 473) andTag:100 andSelectImage:@"x" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:cannel];

    
    UIButton *commit = [LooperToolClass createBtnImageName:@"caption_commit.png" andRect:CGPointMake(245, 585) andTag:101 andSelectImage:@"btn_coomit.png" andClickImage:nil andTextStr:nil andSize:CGSizeZero  andTarget:self];
    [self addSubview:commit];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    [_obj selectViewType:tag andSelectNum:indexPath.row andSelectStr:nil];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  80*DEF_Adaptation_Font*0.5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(32*0.5*DEF_Adaptation_Font,29*0.5*DEF_Adaptation_Font, 200*0.5*DEF_Adaptation_Font, 22*0.5*DEF_Adaptation_Font)];
    
    lable.text = [arrayData objectAtIndex:indexPath.row];
    
    lable.font = [UIFont fontWithName:looperFont size:12*DEF_Adaptation_Font];
    
    
     lable.textColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    
    [cell.contentView addSubview:lable];
    
    return cell;
}



@end
