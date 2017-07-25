//
//  UserListView.m
//  Looper
//
//  Created by lujiawei on 4/11/17.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "UserListView.h"
#import "looperViewModel.h"
#import "DBSphereView.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "LocalDataMangaer.h"

@implementation UserListView{

    DBSphereView *sphereView;
    

}

@synthesize obj = _obj;
@synthesize userArray = _userArray;

-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andUserData:(NSArray *)userArrayData
{
    if (self = [super initWithFrame:frame]) {
        self.obj = (looperViewModel*)idObject;
        self.userArray = userArrayData;
        [self initView];
        
        
    }
    return self;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(point.y>0 && point.y<560*DEF_Adaptation_Font*0.5){
        
    [_obj removeUserView];
    
    }
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    
}

-(void)createDBSphereView{
    
    sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 560*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 450*DEF_Adaptation_Font*0.5)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<[_userArray count];i++) {
        NSDictionary *data = [_userArray objectAtIndex:i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
        btn.frame = CGRectMake(0, 0, 60, 60);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius =60*0.5;
        btn.tag = [[data objectForKey:@"userid"] intValue];
        
        [btn setBackgroundColor:[UIColor yellowColor]];
        [array addObject:btn];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,60,60)];
        
        if([data objectForKey:@"headimageurl"]!=[NSNull null]){
            
            [imageV sd_setImageWithURL:[[NSURL alloc] initWithString:[data objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }
        [btn addSubview:imageV];
        imageV.layer.cornerRadius = 60/2;
        imageV.layer.masksToBounds = YES;
        [sphereView addSubview:btn];
    }
    [sphereView setCloudTags:array];
    [self addSubview:sphereView];
    
}

- (void)buttonPressed:(UIButton *)btn
{
    
    [sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [sphereView timerStart];
        }];
    }];
    
    for (NSDictionary *dic in _userArray){
        if([[dic objectForKey:@"userid"] intValue]==btn.tag){
            
            
            if([[LocalDataMangaer sharedManager].uid isEqualToString:[dic objectForKey:@"userid"]]){
            
            
            }else{
            
                [self createPlayerView:dic];
            }
            
            
            
        }
    }
}

-(void)createPlayerView:(NSDictionary*)looperData{
    
    [_obj createPlayerView:looperData];
    
}




-(void)initView{
    
    [self setBackgroundColor:[UIColor colorWithRed:32/255.0 green:41/255.0 blue:64/255.0 alpha:0.54]];
    [self createDBSphereView];
    

}

@end
