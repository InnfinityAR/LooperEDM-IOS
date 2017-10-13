//
//  FamilyApplyView.m
//  Looper
//
//  Created by 工作 on 2017/9/2.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "FamilyApplyView.h"
#import "FamilyViewModel.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "UIImageView+WebCache.h"
#import <CoreLocation/CoreLocation.h>

#import "FamilyApplyFetailView.h"
@interface FamilyApplyView()<CLLocationManagerDelegate>{//添加代理协议 CLLocationManagerDelegate
    CLLocationManager *_locationManager;//定位服务管理类
    CLGeocoder * _geocoder;//初始化地理编码器
    
    UIImageView *contentView;
    UILabel *locationLB;
    
    UIActivityIndicatorView *indicator;
//如果定位没有执行
    BOOL isLocation;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation FamilyApplyView

-(instancetype)initWithFrame:(CGRect)frame andObj:(id)obj andDataDic:(NSDictionary *)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.obj=(FamilyViewModel *)obj;
        self.dataDic=dataDic;
        [self initView];
        [self initBackView];
        isLocation=NO;
    }
    return self;
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        [_locationManager stopUpdatingLocation];
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        [self.obj getApplyFamilyDataForRfId:[self.dataDic objectForKey:@"raverid"]];
        [self removeFromSuperview];
    }
}
-(void)initBackView{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:backBtn];
}
-(void)initView{
    [self setBackgroundColor:ColorRGB(0, 0, 0, 0.4)];
    contentView=[[UIImageView alloc]initWithFrame:CGRectMake(90*DEF_Adaptation_Font*0.5, 343*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-180*DEF_Adaptation_Font*0.5, 295*DEF_Adaptation_Font*0.5)];
    contentView.userInteractionEnabled=YES;
    contentView.image=[UIImage imageNamed:@"family_apply_back.png"];
    [self addSubview:contentView];
    UIImageView*headView=[[UIImageView alloc]initWithFrame:CGRectMake(234*DEF_Adaptation_Font*0.5, 217*DEF_Adaptation_Font*0.5, 167*DEF_Adaptation_Font*0.5, 167*DEF_Adaptation_Font*0.5)];
    [headView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"images"]] placeholderImage:[UIImage imageNamed:@"btn_home.png"]options:SDWebImageRetryFailed];
    headView.layer.cornerRadius=83*DEF_Adaptation_Font*0.5;
    headView.layer.masksToBounds=YES;
    headView.layer.borderColor=[ColorRGB(193, 158, 252, 1.0)CGColor];
    headView.layer.borderWidth=6*DEF_Adaptation_Font*0.5;
    [self addSubview:headView];
    
    UILabel *nameLB=[[UILabel alloc]initWithFrame:CGRectMake(20, 60*DEF_Adaptation_Font*0.5, DEF_WIDTH(contentView)-40, 24*DEF_Adaptation_Font*0.5)];
    nameLB.textAlignment=NSTextAlignmentCenter;
    nameLB.textColor=[UIColor whiteColor];
    nameLB.font=[UIFont boldSystemFontOfSize:18];
    nameLB.text=[NSString stringWithFormat:@"%@家族",[self.dataDic objectForKey:@"ravername"]];
    [contentView addSubview:nameLB];
    
    locationLB=[[UILabel alloc]initWithFrame:CGRectMake(20, 96*DEF_Adaptation_Font*0.5, DEF_WIDTH(contentView)-40, 20*DEF_Adaptation_Font*0.5)];
    locationLB.textAlignment=NSTextAlignmentCenter;
    locationLB.textColor=ColorRGB(255, 255, 255, 0.6);
    locationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13.f];
    locationLB.text=@"正在定位";
    CGSize lblSize3 = [locationLB.text boundingRectWithSize:CGSizeMake(474*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame3=locationLB.frame;
    frame3.size=lblSize3;
    frame3.origin.x=DEF_WIDTH(contentView)/2-lblSize3.width/2;
    locationLB.frame=frame3;
    [contentView addSubview:locationLB];
    
    indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(DEF_X(locationLB)-lblSize3.height-10*DEF_Adaptation_Font*0.5, 94*DEF_Adaptation_Font*0.5,  lblSize3.height, lblSize3.height)];
    [contentView addSubview:indicator];
    [indicator startAnimating];
    
    
    UILabel *declarationLB=[[UILabel alloc]initWithFrame:CGRectMake(20*DEF_Adaptation_Font*0.5, 123*DEF_Adaptation_Font*0.5, DEF_WIDTH(contentView)-40*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5)];
    declarationLB.textColor=[UIColor whiteColor];
    declarationLB.font=[UIFont fontWithName:@"STHeitiTC-Light" size:15.f];
    declarationLB.textAlignment=NSTextAlignmentCenter;
    declarationLB.numberOfLines=2;
    declarationLB.text=[self.dataDic objectForKey:@"familydeclaration"];
    [contentView addSubview:declarationLB];
    UIButton *saveBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(DEF_WIDTH(contentView)/2-80*DEF_Adaptation_Font*0.5, 220*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5) andTarget:self];
    [saveBtn setTitle:@"申请加入" forState:(UIControlStateNormal)];
    saveBtn.titleLabel.font =  [UIFont boldSystemFontOfSize:13];
    saveBtn.layer.cornerRadius=25*DEF_Adaptation_Font*0.5;
    saveBtn.layer.borderWidth=0.8;
    saveBtn.layer.borderColor=[[UIColor whiteColor]CGColor];;
    saveBtn.layer.masksToBounds=YES;
    [saveBtn setTintColor:[UIColor whiteColor]];
    [contentView addSubview:saveBtn];

    UIButton *selectBtn=[LooperToolClass createBtnImageNameReal:@"family_apply_select.png" andRect:CGPointMake(DEF_WIDTH(contentView)+(90-25)*DEF_Adaptation_Font*0.5, (343-25)*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"family_apply_select.png" andClickImage:@"family_apply_select.png" andTextStr:nil andSize:CGSizeMake(50*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:selectBtn];

    [self initializeLocationService];
}
//location
- (void)initializeLocationService {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    //[_locationManager requestAlwaysAuthorization];//iOS8必须，这两行必须有一行执行，否则无法获取位置信息，和定位
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];//开始定位之后会不断的执行代理方法更新位置会比较费电所以建议获取完位置即时关闭更新位置服务
    //初始化地理编码器
    _geocoder = [[CLGeocoder alloc] init];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:5.0];
}
-(void)delayMethod{
    if (isLocation==NO) {
    locationLB.text=@"手动输入(可点击)";
    CGSize lblSize3 = [locationLB.text boundingRectWithSize:CGSizeMake(474*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
    CGRect frame3=locationLB.frame;
    frame3.size=lblSize3;
    frame3.origin.x=DEF_WIDTH(contentView)/2-lblSize3.width/2;
    locationLB.frame=frame3;
    locationLB.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLocation:)];
    [locationLB addGestureRecognizer:tap];
    UIImageView *locationIV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(locationLB)-40*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5,  18*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
    locationIV.image=[UIImage imageNamed:@"icon_calendar_location.png"];
    [contentView addSubview:locationIV];
[indicator stopAnimating];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    isLocation=YES;
    NSLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
    // 纬度
//    CLLocationDegrees latitude = location.coordinate.latitude;
    // 经度
//    CLLocationDegrees longitude = location.coordinate.longitude;
    NSLog(@"%@",[NSString stringWithFormat:@"%lf", location.coordinate.longitude]);
    //    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            // 位置名
            locationLB.text=[NSString stringWithFormat:@"%@/%@",placemark.locality,placemark.subLocality];
            CGSize lblSize3 = [locationLB.text boundingRectWithSize:CGSizeMake(474*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
            CGRect frame3=locationLB.frame;
            frame3.size=lblSize3;
            frame3.origin.x=DEF_WIDTH(contentView)/2-lblSize3.width/2;
            locationLB.frame=frame3;
            UIImageView *locationIV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(locationLB)-40*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5,  18*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
            locationIV.image=[UIImage imageNamed:@"icon_calendar_location.png"];
            [contentView addSubview:locationIV];
        }else{
                locationLB.text=@"手动输入(可点击)";
                CGSize lblSize3 = [locationLB.text boundingRectWithSize:CGSizeMake(474*DEF_Adaptation_Font*0.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiTC-Light" size:13.f]} context:nil].size;
                CGRect frame3=locationLB.frame;
                frame3.size=lblSize3;
                frame3.origin.x=DEF_WIDTH(contentView)/2-lblSize3.width/2;
                locationLB.frame=frame3;
            locationLB.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickLocation:)];
            [locationLB addGestureRecognizer:tap];
            UIImageView *locationIV=[[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(locationLB)-40*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5,  18*DEF_Adaptation_Font*0.5, 24*DEF_Adaptation_Font*0.5)];
            locationIV.image=[UIImage imageNamed:@"icon_calendar_location.png"];
            [contentView addSubview:locationIV];
        }
    [indicator stopAnimating];
    
    }];
    //    [manager stopUpdatingLocation];不用的时候关闭更新位置服务
}
-(void)ClickLocation:(UITapGestureRecognizer *)tap{
    FamilyApplyFetailView *familyApplyV=[[FamilyApplyFetailView alloc]initWithFrame:self.bounds andObj:self.obj andDataDic:self.dataDic];
    [[self.obj familyView] addSubview:familyApplyV];
     [indicator stopAnimating];
     [_locationManager stopUpdatingLocation];
    [self removeFromSuperview];
}

@end
