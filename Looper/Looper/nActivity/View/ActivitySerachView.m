//
//  ActivitySerachView.m
//  Looper
//
//  Created by lujiawei on 26/09/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "ActivitySerachView.h"
#import "nActivityViewModel.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"



@implementation ActivitySerachView{
    
    
    UISearchBar* mySeatchBar;
    NSMutableArray *activityData;
    UITableView *tableView;
    
    
    
}

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject {
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        
        [self initView];
        
    }
    return self;
}

-(void)updateDataView:(NSArray*)dataArray{

    activityData = [[NSMutableArray alloc] initWithArray:dataArray];
    [tableView reloadData];
    
}

-(void)initView{
  [self setBackgroundColor:[UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0]];
    
    [self createSerachViewHud];

}


- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        [self removeFromSuperview];
        //[_obj popController];
    }else if(button.tag==101){
        [_obj searchOfflineInformation:mySeatchBar.text];
        [self endEditing:true];
        
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
     [_obj searchOfflineInformation:mySeatchBar.text];
    
    [self endEditing:true];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    
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




-(void)createTableView{
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0*0.5*DEF_Adaptation_Font, 133*0.5*DEF_Adaptation_Font,640*DEF_Adaptation_Font_x*0.5, 998*0.5*DEF_Adaptation_Font)style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = NO;
    [tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 48*DEF_Adaptation_Font*0.5;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){

    }
    
}

-(void)createActiveView:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  410*DEF_Adaptation_Font*0.5;
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return [activityData count];
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
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:143.0/255.0 blue:146.0/255.0 alpha:0.5];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, 410*DEF_Adaptation_Font*0.5)];
    
    [cell addSubview:bgView];
    
    
   // bgView.tag = [[[[_djData objectForKey:@"information"] objectAtIndex:i] objectForKey:@"activityid"] intValue];
    bgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createActiveView:)];
    [bgView addGestureRecognizer:singleTap];
    
    
    [self createActiveCellView:[activityData objectAtIndex:indexPath.row] andBgView:bgView];

    
    
    return cell;
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
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(276*DEF_Adaptation_Font*0.5, 54*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 78*DEF_Adaptation_Font*0.5)];
    titleLable.numberOfLines = 0;
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:20]];
    titleLable.text = [data objectForKey:@"activityname"];
    [view addSubview:titleLable];
    UILabel *tagLable=nil;
    if ([data objectForKey:@"tag"]==[NSNull null]) {
        tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
    }else{
        tagLable = [[UILabel alloc] initWithFrame:CGRectMake(277*DEF_Adaptation_Font*0.5, 139*DEF_Adaptation_Font*0.5,[self getContentLength:[data objectForKey:@"tag"]]+15*DEF_Adaptation_Font*0.5, 27*DEF_Adaptation_Font*0.5)];
        tagLable.text = [data objectForKey:@"tag"];
    }
    [tagLable setTextColor:[UIColor whiteColor]];
    [tagLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
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
  //  timeLable.text = [data objectForKey:@"starttime"];
    [view addSubview:timeLable];
    
    
    UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(310*DEF_Adaptation_Font*0.5, 242*DEF_Adaptation_Font*0.5, 294*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5)];
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
        
        UIImageView *icon_price=[LooperToolClass createImageView:@"icon_price.png" andRect:CGPointMake(278, 328) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_price];
    }else{
        UIImageView *icon_ticket=[LooperToolClass createImageView:@"icon_ticket.png" andRect:CGPointMake(278, 328) andTag:100 andSize:CGSizeMake(69*DEF_Adaptation_Font_x*0.5, 32*DEF_Adaptation_Font*0.5) andIsRadius:false];
        [view addSubview:icon_ticket];
    }
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(368*DEF_Adaptation_Font*0.5, 328*DEF_Adaptation_Font*0.5, 235*DEF_Adaptation_Font*0.5, 32*DEF_Adaptation_Font*0.5)];
    [priceLable setTextColor:[UIColor colorWithRed:191/255.0 green:252/255.0 blue:255/255.0 alpha:1.0]];
    [priceLable setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    priceLable.text = [data objectForKey:@"price"];
    [view addSubview:priceLable];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(36*DEF_Adaptation_Font*0.5, view.frame.size.height, 568*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5)];
    [line setBackgroundColor:[UIColor colorWithRed:160/255.0 green:138/255.0 blue:197/255.0 alpha:0.1f]];
    [view addSubview:line];
    
}


-(void)createSerachViewHud{
    
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,45*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
    
    UIButton *serachBtn = [LooperToolClass createBtnImageName:@"btn_serach_select.png" andRect:CGPointMake(553, 36) andTag:101 andSelectImage:@"btn_serach_select.png" andClickImage:@"btn_serach_select.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self addSubview:serachBtn];
    
    mySeatchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(76 * DEF_Adaptation_Font*0.5, 65 * DEF_Adaptation_Font*0.5, 477*0.5*DEF_Adaptation_Font, 50 * DEF_Adaptation_Font*0.5)];
    
    mySeatchBar.delegate = self;
    [mySeatchBar setBackgroundColor:[UIColor clearColor]];
    [[[mySeatchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    mySeatchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
    mySeatchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    mySeatchBar.barStyle = UIBarStyleBlack;
    mySeatchBar.placeholder = @"搜索活动";
    [mySeatchBar becomeFirstResponder];
    
    [self addSubview:mySeatchBar];
    
    UITextField *txfSearchField = [mySeatchBar valueForKey:@"_searchField"];
    [txfSearchField setBackgroundColor:[UIColor clearColor]];
    [txfSearchField setLeftViewMode:UITextFieldViewModeNever];
    [txfSearchField setRightViewMode:UITextFieldViewModeNever];
    [txfSearchField setBackground:[UIImage imageNamed:@"searchbar_bgImg.png"]];
    [txfSearchField setBorderStyle:UITextBorderStyleNone];
    txfSearchField.layer.borderColor = [UIColor clearColor].CGColor;
    txfSearchField.clearButtonMode=UITextFieldViewModeNever;
    
    UIImageView *line = [LooperToolClass createImageView:@"bg_serach_line.png" andRect:CGPointMake(76, 120) andTag:100 andSize:CGSizeMake(519, 1) andIsRadius:false];
    [self addSubview:line];
       [self createTableView];
}

@end
