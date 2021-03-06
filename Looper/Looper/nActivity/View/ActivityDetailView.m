//
//  ActivityDetailView.m
//  Looper
//
//  Created by lujiawei on 22/05/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "ActivityDetailView.h"
#include "nActivityViewModel.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
#import "LooperToolClass.h"
#import "DataHander.h"
#import <MapKit/MapKit.h>
#import "LocalDataMangaer.h"


@implementation ActivityDetailView{
    UIScrollView *bkScroll;


    NSMutableDictionary *activityDic;
    
    bool isHeight;
    bool isShowBtn;
    
    UIButton *calendarBtn;
    UIButton *loopBtn;
    UIButton *ticketBtn;
    
    UIButton *touchView;
    
    KYGooeyMenu *gooeyMenu;
    
    UIButton *ownerFollowBtn;
    UIButton *joinBtn;
    
    UIView *colorView;
    
    UILabel *titleLabel;
    
    NSDictionary *_orderDic;
    WKWebView *webV;
}

-(void)setCalendar{

    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[activityDic objectForKey:@"data"]];
    [data setObject:@"1" forKey:@"issave"];
    [activityDic setObject:data forKey:@"data"];

}


-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject andDetailDic:(NSDictionary*)detailDic andActivityDic:(NSDictionary *)ActivityDic{
    
    if (self = [super initWithFrame:frame]) {
        self.obj = (nActivityViewModel*)idObject;
        activityDic = [[NSMutableDictionary alloc] initWithDictionary:detailDic];
        _orderDic=ActivityDic;
        [self initView];
    }
    return self;
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset  = scrollView.contentOffset.y;
    if(scrollView.tag==100){
        NSLog(@"%f",scrollView.contentOffset.y);
        
        if(scrollView.contentOffset.y>452){
        
            titleLabel.hidden=false;
        }else{
            titleLabel.hidden=true;
        }
    }
}



-(void)createHudView{
    isHeight = false;
    
    UIImageView *shadowV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 176*DEF_Adaptation_Font*0.5)];
    [shadowV setImage:[UIImage imageNamed:@"top_shadow.png"]];
    shadowV.alpha=2.0;
    [self addSubview:shadowV];
    
     UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(0,30*DEF_Adaptation_Font*0.5) andTag:101 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    
    [self addSubview:backBtn];
    
    UIButton *shareBtn = [LooperToolClass createBtnImageNameReal:@"btn_share.png" andRect:CGPointMake(566*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTag:102 andSelectImage:@"btn_share.png" andClickImage:@"btn_share.png" andTextStr:nil andSize:CGSizeMake(64*DEF_Adaptation_Font*0.5,68*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:shareBtn];
    
    UIButton * toPhotoWallBtn = [LooperToolClass createBtnImageNameReal:@"photoWall.png" andRect:CGPointMake(520*DEF_Adaptation_Font*0.5,140*DEF_Adaptation_Font*0.5) andTag:1019 andSelectImage:@"photoWall.png"andClickImage:nil andTextStr:nil andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5,100*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:toPhotoWallBtn];
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(68*DEF_Adaptation_Font*0.5, 46*DEF_Adaptation_Font*0.5, 408*DEF_Adaptation_Font*0.5, 36*DEF_Adaptation_Font*0.5)];
    titleLabel.text =[[activityDic objectForKey:@"data"]objectForKey:@"activityname"];
    [titleLabel setFont:[UIFont fontWithName:@"PingFangSC" size:20]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:titleLabel];
    
    titleLabel.hidden=true;
#warning-在这里进行是否进行抽奖的判断
    NSArray *roulette=[_orderDic objectForKey:@"roulette"];
    
    if (roulette.count<0) {
        UIImageView *shadowIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(self)-140*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 46*DEF_Adaptation_Font*0.5)];
        shadowIV.image=[UIImage imageNamed:@"shadow_pay_liveshow.png"];
        [self addSubview:shadowIV];
        gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(550*DEF_Adaptation_Font*0.5,925*DEF_Adaptation_Font*0.5) andDiameter:40.0f andDelegate:self themeColor:[UIColor colorWithRed:47/255.0 green:168/255.0 blue:255.0/255.0 alpha:1.0]];
        UIView *payBtnView=[[UIView alloc]initWithFrame:CGRectMake(0, DEF_HEIGHT(self)-94*DEF_Adaptation_Font*0.5, DEF_WIDTH(self), 94*DEF_Adaptation_Font*0.5)];
        payBtnView.backgroundColor=[UIColor whiteColor];
        [self addSubview:payBtnView];
        UIButton *payBtn=[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(36*DEF_Adaptation_Font*0.5, 14*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(568*DEF_Adaptation_Font*0.5, 60*DEF_Adaptation_Font*0.5) andTarget:self];
        [payBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
        [payBtn setTintColor:[UIColor whiteColor]];
        payBtn.backgroundColor=ColorRGB(42, 195, 192, 1.0);
        payBtn.layer.cornerRadius=30*DEF_Adaptation_Font*0.5;
        payBtn.layer.masksToBounds=YES;
        [payBtnView addSubview:payBtn];
    }else{
    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(550*DEF_Adaptation_Font*0.5,1025*DEF_Adaptation_Font*0.5) andDiameter:40.0f andDelegate:self themeColor:[UIColor colorWithRed:47/255.0 green:168/255.0 blue:255.0/255.0 alpha:1.0]];
    }
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 20;//大圆的1/4
    gooeyMenu.extraDistance = 45;
    gooeyMenu.MenuCount = 3;
    
}

-(void)createWebView{
    
    
    webV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 200*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[[activityDic objectForKey:@"data"]objectForKey:@"htmlurl"]]];
    
   // [webV setBackgroundColor:[UIColor redColor]];

    webV.navigationDelegate=self;

     webV.userInteractionEnabled=false;
    
    [webV loadRequest:request];
    
    [bkScroll addSubview:webV];

    NSLog(@"%@",webV);

}



// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

    
       [[DataHander sharedDataHander] showDlg];


}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

    
    [self performSelector:@selector(reloadView) withObject:nil afterDelay:0.1];

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

     NSLog(@"%@",webView);
    
    
    NSLog(@"%f",webView.scrollView.contentSize.height);
    
    [self performSelector:@selector(reloadView) withObject:nil afterDelay:0.1];

}

-(void)reloadView{
    [[DataHander sharedDataHander] hideDlg];
    if([[activityDic objectForKey:@"dj"] count]>0){
        bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH,webV.scrollView.contentSize.height+2070*DEF_Adaptation_Font*0.5+100*DEF_Adaptation_Font*0.5);
          [webV setFrame:CGRectMake(0,2070*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,webV.scrollView.contentSize.height)];
    }else{
        bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH,webV.scrollView.contentSize.height+1650*DEF_Adaptation_Font*0.5+100*DEF_Adaptation_Font*0.5);
         [webV setFrame:CGRectMake(0,1650*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH,webV.scrollView.contentSize.height)];
    }
  
   //[self createLoopView:webV.scrollView.contentSize.height];
}




// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    

}

-(void)onClickImage:(UITapGestureRecognizer *)tap{
    
    NSArray *loopArray = [[NSArray alloc] initWithArray:[activityDic objectForKey:@"loop"]];
    NSDictionary *dic =[loopArray objectAtIndex:tap.view.tag];

    [_obj toLooperView:dic];
    
}

-(void)createLoopView:(float)scrollHeight{
    
    if(scrollHeight!=DEF_SCREEN_HEIGHT){
        if(isHeight ==false){
            
            
            UIView *writeView1 = [[UIView alloc] initWithFrame:CGRectMake(0,scrollHeight+2070*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 100*DEF_Adaptation_Font*0.5)];
            [writeView1 setBackgroundColor:[UIColor whiteColor]];
            [bkScroll addSubview:writeView1];
            
            /*
            UILabel *activityStr = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, ((scrollHeight/DEF_Adaptation_Font/0.5)+2120)*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(196*DEF_Adaptation_Font_x*0.5, 37*DEF_Adaptation_Font_x*0.5) andText:@"推荐loop" andFontSize:13 andColor:[UIColor colorWithRed:38/255.0 green:40/255.0 blue:47/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
             [activityStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:18]];
            
            //[bkScroll addSubview:activityStr];
            
            NSArray *loopArray = [[NSArray alloc] initWithArray:[activityDic objectForKey:@"loop"]];
            for(int i=0;i<[loopArray count];i++){
                NSDictionary *dic =[loopArray objectAtIndex:i];
                if(i%2==0){
                    UIImageView* loopImage =[LooperToolClass createBtnImage:[dic objectForKey:@"news_img"] andRect:CGPointMake(26, ((scrollHeight/DEF_Adaptation_Font/0.5)+2220)) andTag:i andSize:CGSizeMake(275, 415) andTarget:self];
                    [bkScroll addSubview:loopImage];
                    loopImage.layer.cornerRadius =  4*DEF_Adaptation_Font_x*0.5;
                    loopImage.layer.masksToBounds = YES;
                    
                      [loopImage addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(20, 250) andSize:CGSizeMake(176, 70) andFontSize:13]];
                    
                }else{
                    UIImageView* loopImage =[LooperToolClass createBtnImage:[dic objectForKey:@"news_img"] andRect:CGPointMake(334, ((scrollHeight/DEF_Adaptation_Font/0.5)+2220)) andTag:i andSize:CGSizeMake(275, 415) andTarget:self];
                    [bkScroll addSubview:loopImage];
                    loopImage.layer.cornerRadius =  4*DEF_Adaptation_Font_x*0.5;
                    loopImage.layer.masksToBounds = YES;
                    
                     [loopImage addSubview:[self createLabel:[dic objectForKey:@"news_title"] andPoint:CGPointMake(20, 250) andSize:CGSizeMake(176, 70) andFontSize:13]];
                }
            }
             */
            isHeight=false;
        }
    }
}


-(void)createImage:(CGRect)rect andImageStr:(NSString*)ImageStr{
    UIImageView *line = [[UIImageView alloc] initWithFrame:rect];
    line.image=[UIImage imageNamed:ImageStr];
    [bkScroll addSubview:line];
}


-(void)addTicketView{
    if([activityDic[@"data"][@"ticketurl"] isEqualToString:@""]==true){
         [[DataHander sharedDataHander] showViewWithStr:@"当前活动 暂无购票链接" andTime:1 andPos:CGPointZero];
    }else{
    
        [_obj addTicket:activityDic[@"data"]];
    }

}

-(void)onClickHead{

    [_obj createPlayerView: [activityDic objectForKey:@"owner"]];
}


-(UILabel*)createLabel:(NSString*)str andPoint:(CGPoint)point andSize:(CGSize)size andFontSize:(int)fontSize{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x*DEF_Adaptation_Font*0.5, point.y*DEF_Adaptation_Font*0.5, size.width*DEF_Adaptation_Font*0.5, size.height*DEF_Adaptation_Font*0.5)];
    [label setText:str];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:looperFont size:fontSize]];
    label.shadowColor = [UIColor colorWithRed:36/255.0 green:30/255.0 blue:43/255.0 alpha:1.0];
    //阴影偏移  x，y为正表示向右下偏移
    label.shadowOffset = CGSizeMake(1, 1);
    label.numberOfLines=0;
    return label;
}


-(void)addcalendarView{

     [_obj savaCalendar:[activityDic objectForKey:@"data"]];
}

-(void)openMap{
    
    if([[activityDic objectForKey:@"club"] count]!=0){
    
        float latitude=0;
        float longitude=0;
        if ([[[activityDic objectForKey:@"club"]objectAtIndex:0]objectForKey:@"latitude"]==[NSNull null]||[[[activityDic objectForKey:@"club"]objectAtIndex:0]objectForKey:@"longitude"]==[NSNull null]) {
        }else{
     latitude=[[[[activityDic objectForKey:@"club"]objectAtIndex:0]objectForKey:@"latitude"] floatValue];
    longitude=[[[[activityDic objectForKey:@"club"]objectAtIndex:0]objectForKey:@"longitude"] floatValue];
        }
    //to do array
    
    MKMapItem *mylocation = [MKMapItem mapItemForCurrentLocation];

    float currentLatitude=mylocation.placemark.location.coordinate.latitude;
    
    float currentLongitude=mylocation.placemark.location.coordinate.longitude;

    CLLocationCoordinate2D coords1 = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);
    
    CLLocationCoordinate2D coordinate;
    
    
    coordinate.latitude=latitude;
    
    coordinate.longitude=longitude;
    
    CLLocationCoordinate2D coords2 = coordinate;
    
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
  
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate]];
    
    toLocation.name = [[activityDic objectForKey:@"data"]objectForKey:@"activityname"] ;
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation,toLocation, nil];
    
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    //打开苹果自身地图应用，并呈现特定的item
        if (latitude!=0&&longitude!=0) {
    [MKMapItem openMapsWithItems:items launchOptions:options];
        }else{
             [[DataHander sharedDataHander] showViewWithStr:@"暂时查不到您查询的地址" andTime:1 andPos:CGPointZero];
        }
    }
}

-(void)createBkView{
    
    colorView = [[UIView alloc] initWithFrame:CGRectMake(0,684*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, 363*DEF_Adaptation_Font*0.5)];
    [colorView setBackgroundColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:72/255.0 alpha:1.0]];
    [bkScroll addSubview:colorView];
    
    UIView *writeView = [[UIView alloc] initWithFrame:CGRectMake(0,684*DEF_Adaptation_Font*0.5+363*DEF_Adaptation_Font*0.5, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-100*DEF_Adaptation_Font*0.5)];
    [writeView setBackgroundColor:[UIColor whiteColor]];
    [bkScroll addSubview:writeView];
    
    
//    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(34*DEF_Adaptation_Font*0.5, 943*DEF_Adaptation_Font*0.5, 62*DEF_Adaptation_Font*0.5, 62*DEF_Adaptation_Font*0.5)];
//    [headView sd_setImageWithURL:[[NSURL alloc] initWithString:[[activityDic objectForKey:@"owner"]objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//    }];
//    headView.layer.cornerRadius = 62*DEF_Adaptation_Font_x*0.5/2;
//    headView.layer.masksToBounds = YES;
//
//
//    headView.userInteractionEnabled=YES;
//    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickHead)];
//    [headView addGestureRecognizer:singleTap];
//
//    [bkScroll addSubview:headView];
    
//    UILabel *ownerName = [LooperToolClass createLableView:CGPointMake(125*DEF_Adaptation_Font_x*0.5, 978*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(290*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"owner"]objectForKey:@"nickname"] andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentLeft];
//    [bkScroll addSubview:ownerName];
    
//    UILabel *ownerLable = [LooperToolClass createLableView:CGPointMake(125*DEF_Adaptation_Font_x*0.5, 939*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(290*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:@"发起人" andFontSize:12 andColor:[UIColor colorWithRed:145/255.0 green:185/255.0 blue:197/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
//    [bkScroll addSubview:ownerLable];

    
    UILabel *activityName = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 723*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 90*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"activityname"] andFontSize:17 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    activityName.numberOfLines=0;
    [activityName sizeToFit];
    
    [bkScroll addSubview:activityName];
    
    UILabel *lableTime = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1080*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"活动时间" andFontSize:11 andColor:[UIColor colorWithRed:57/255.0 green:61/255.0 blue:71/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [lableTime sizeToFit];
    [bkScroll addSubview:lableTime];
    
    UILabel *lableLocation = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1165*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"活动地点" andFontSize:11 andColor:[UIColor colorWithRed:57/255.0 green:61/255.0 blue:71/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [lableLocation sizeToFit];
    [bkScroll addSubview:lableLocation];
    
    UILabel *lableSpace = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1255*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"场地名称" andFontSize:11 andColor:[UIColor colorWithRed:57/255.0 green:61/255.0 blue:71/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [lableSpace sizeToFit];
    [bkScroll addSubview:lableSpace];
    
    UIButton *locatonBtn = [[UIButton alloc] initWithFrame:CGRectMake(26*DEF_Adaptation_Font_x*0.5, 1165*DEF_Adaptation_Font_x*0.5, 602*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5)];
    [locatonBtn addTarget:self action:@selector(openMap) forControlEvents:UIControlEventTouchDown];
    [bkScroll addSubview:locatonBtn];

    UILabel *lableTicket = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1344*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"售票链接" andFontSize:11 andColor:[UIColor colorWithRed:57/255.0 green:61/255.0 blue:71/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [lableTicket sizeToFit];
    [bkScroll addSubview:lableTicket];
    
    UILabel *brandTicket = [LooperToolClass createLableView:CGPointMake(70*DEF_Adaptation_Font_x*0.5, 1433*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(565*DEF_Adaptation_Font_x*0.5, 25*DEF_Adaptation_Font_x*0.5) andText:@"主办方" andFontSize:11 andColor:[UIColor colorWithRed:57/255.0 green:61/255.0 blue:71/255.0 alpha:1.0] andType:NSTextAlignmentCenter];
    [brandTicket sizeToFit];
    [bkScroll addSubview:brandTicket];
    
    UIButton *calendarBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(526*DEF_Adaptation_Font_x*0.5, 1055*DEF_Adaptation_Font_x*0.5, 100*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5)];
    [calendarBtn1 addTarget:self action:@selector(addcalendarView) forControlEvents:UIControlEventTouchDown];
    [bkScroll addSubview:calendarBtn1];

    UIButton *ticketBtn = [[UIButton alloc] initWithFrame:CGRectMake(26*DEF_Adaptation_Font_x*0.5, 1316*DEF_Adaptation_Font_x*0.5, 602*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5)];
    [ticketBtn addTarget:self action:@selector(addTicketView) forControlEvents:UIControlEventTouchDown];
    [bkScroll addSubview:ticketBtn];
    
    UILabel *TimeStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1078*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"timetag"] andFontSize:13 andColor:[UIColor colorWithRed:97/255.0 green:101/255.0 blue:114/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [TimeStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    [bkScroll addSubview:TimeStr];
    
    UILabel *locationStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1164*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"location"] andFontSize:13 andColor:[UIColor colorWithRed:97/255.0 green:101/255.0 blue:114/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [locationStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    [bkScroll addSubview:locationStr];
    
    UILabel *SpaceStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1256*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"place"] andFontSize:13 andColor:[UIColor colorWithRed:97/255.0 green:101/255.0 blue:114/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [SpaceStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:14]];
    [bkScroll addSubview:SpaceStr];
    
    
    UIButton *SpaceBtn = [[UIButton alloc] initWithFrame:CGRectMake(26*DEF_Adaptation_Font_x*0.5, 1256*DEF_Adaptation_Font_x*0.5, 602*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5)];
    [SpaceBtn addTarget:self action:@selector(SpaceView) forControlEvents:UIControlEventTouchDown];
    [bkScroll addSubview:SpaceBtn];
    
    
    UILabel *ticketStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1343*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:@"去购票" andFontSize:14 andColor:[UIColor colorWithRed:97/255.0 green:101/255.0 blue:114/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [ticketStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
    [bkScroll addSubview:ticketStr];
    
    
    UIButton *brandBtn = [[UIButton alloc] initWithFrame:CGRectMake(26*DEF_Adaptation_Font_x*0.5, 1430*DEF_Adaptation_Font_x*0.5, 602*DEF_Adaptation_Font*0.5, 85*DEF_Adaptation_Font*0.5)];
    [brandBtn addTarget:self action:@selector(addbrandView) forControlEvents:UIControlEventTouchDown];
    [bkScroll addSubview:brandBtn];
#warning-在这里加入多个主办方
    UILabel *brandStr = [LooperToolClass createLableView:CGPointMake(181*DEF_Adaptation_Font_x*0.5, 1430*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(406*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[[activityDic objectForKey:@"host"]objectAtIndex:0] objectForKey:@"hostname"] andFontSize:14 andColor:[UIColor colorWithRed:97/255.0 green:101/255.0 blue:114/255.0 alpha:1.0] andType:NSTextAlignmentRight];
    [brandStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
    [bkScroll addSubview:brandStr];
    
    
    UILabel *title = [LooperToolClass createLableView:CGPointMake(20*DEF_Adaptation_Font_x*0.5, 670*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(196*DEF_Adaptation_Font_x*0.5, 46*DEF_Adaptation_Font_x*0.5) andText:[[activityDic objectForKey:@"data"]objectForKey:@"tag"] andFontSize:12 andColor:[UIColor whiteColor] andType:NSTextAlignmentCenter];
    
    [title setBackgroundColor:[UIColor colorWithRed:45/255.0 green:59/255.0 blue:91/255.0 alpha:1.0]];
    [bkScroll addSubview:title];
    
    if([[activityDic objectForKey:@"dj"] count]>0){
    
        UILabel *DjStr = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 1540*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(196*DEF_Adaptation_Font_x*0.5, 37*DEF_Adaptation_Font_x*0.5) andText:@"参与艺人" andFontSize:13 andColor:[UIColor colorWithRed:38/255.0 green:40/255.0 blue:47/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [DjStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:18]];
        [bkScroll addSubview:DjStr];
        
    }

    if([[activityDic objectForKey:@"dj"] count]>0){
        
          [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1914*DEF_Adaptation_Font*0.5, 640*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
        
        UILabel *activityStr = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 1960*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(196*DEF_Adaptation_Font_x*0.5, 37*DEF_Adaptation_Font_x*0.5) andText:@"活动详情" andFontSize:13 andColor:[UIColor colorWithRed:38/255.0 green:40/255.0 blue:47/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [activityStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:18]];
        [bkScroll addSubview:activityStr];
        
    }else{
        
        UILabel *activityStr = [LooperToolClass createLableView:CGPointMake(42*DEF_Adaptation_Font_x*0.5, 1540*DEF_Adaptation_Font_x*0.5) andSize:CGSizeMake(196*DEF_Adaptation_Font_x*0.5, 37*DEF_Adaptation_Font_x*0.5) andText:@"活动详情" andFontSize:13 andColor:[UIColor colorWithRed:38/255.0 green:40/255.0 blue:47/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        
        [activityStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:18]];
        [bkScroll addSubview:activityStr];
    
    }
    
    
    title.layer.cornerRadius =  46*DEF_Adaptation_Font_x*0.5/2;
    title.layer.masksToBounds = YES;

    joinBtn = [LooperToolClass createBtnImageNameReal:@"btn_joinActivity.png" andRect:CGPointMake(222*DEF_Adaptation_Font*0.5,840*DEF_Adaptation_Font*0.5) andTag:1010 andSelectImage:@"btn_JoinedActivity_1.png"andClickImage:nil andTextStr:nil andSize:CGSizeMake(196*DEF_Adaptation_Font*0.5,46*DEF_Adaptation_Font*0.5) andTarget:self];
    [bkScroll addSubview:joinBtn];
    
        if([[[activityDic objectForKey:@"data"] objectForKey:@"newjoincount"] intValue]==0){
            [joinBtn setSelected:false];
        }else{
    
            [joinBtn setSelected:true];
        }

    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 906*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 17*DEF_Adaptation_Font*0.5) andImageStr:@"line_activity_join.png"];
    
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1077*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"time1.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1163*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"locaton1.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1253*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"home.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1342*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"ticket.png"];
    [self createImage:CGRectMake(30*DEF_Adaptation_Font*0.5, 1431*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5, 28*DEF_Adaptation_Font*0.5) andImageStr:@"icon_brand.png"];
    
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1043*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1135*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1224*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1313*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1401*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    [self createImage:CGRectMake(34*DEF_Adaptation_Font*0.5, 1489*DEF_Adaptation_Font*0.5, 572*DEF_Adaptation_Font*0.5, 2*DEF_Adaptation_Font*0.5) andImageStr:@"activity_line.png"];
    
    
    [self createImage:CGRectMake(590*DEF_Adaptation_Font*0.5, 1070*DEF_Adaptation_Font*0.5, 37*DEF_Adaptation_Font*0.5, 39*DEF_Adaptation_Font*0.5) andImageStr:@"tirp.png"];
    [self createImage:CGRectMake(597*DEF_Adaptation_Font*0.5, 1258*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5) andImageStr:@"buy_ticket.png"];
    [self createImage:CGRectMake(597*DEF_Adaptation_Font*0.5, 1345*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5) andImageStr:@"buy_ticket.png"];
    [self createImage:CGRectMake(597*DEF_Adaptation_Font*0.5, 1431*DEF_Adaptation_Font*0.5, 10*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5) andImageStr:@"buy_ticket.png"];
    
    
    UIScrollView *userScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(34*DEF_Adaptation_Font*0.5, 945*DEF_Adaptation_Font*0.5, 554*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
    userScrollV.showsVerticalScrollIndicator = NO;
    userScrollV.showsHorizontalScrollIndicator = NO;
    [bkScroll addSubview:userScrollV];
    userScrollV.userInteractionEnabled=true;
    
    
    for (int i=0;i<[[activityDic objectForKey:@"joineduser"] count];i++){
        
        UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(0+(i*96*DEF_Adaptation_Font*0.5),0, 76*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
        [userImage sd_setImageWithURL:[[NSURL alloc] initWithString:[[[activityDic objectForKey:@"joineduser"]objectAtIndex:i] objectForKey:@"headimageurl"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        userImage.tag= [[[[activityDic objectForKey:@"joineduser"] objectAtIndex:i] objectForKey:@"userid"] intValue];
        
        userImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserBtn:)];
        [userImage addGestureRecognizer:singleTap];
        
        
        userImage.layer.cornerRadius = 76*DEF_Adaptation_Font_x*0.5/2;
        userImage.layer.masksToBounds = YES;
        
        
        
        [userScrollV addSubview:userImage];
    }
    [userScrollV setContentSize:CGSizeMake([[activityDic objectForKey:@"joineduser"] count]*96*DEF_Adaptation_Font*0.5, 76*DEF_Adaptation_Font*0.5)];
    
    
    
    [self createActivityBtn];
    isShowBtn=0;
    
//    ownerFollowBtn = [LooperToolClass createBtnImageNameReal:@"ownerFollow.png" andRect:CGPointMake(475*DEF_Adaptation_Font*0.5,936*DEF_Adaptation_Font*0.5) andTag:1009 andSelectImage:@"owenFollowed.png"andClickImage:nil andTextStr:nil andSize:CGSizeMake(144*DEF_Adaptation_Font*0.5,63*DEF_Adaptation_Font*0.5) andTarget:self];
//    [bkScroll addSubview:ownerFollowBtn];
//
//    if([[[activityDic objectForKey:@"owner"] objectForKey:@"isfollowowner"] intValue]==0){
//        [ownerFollowBtn setSelected:false];
//    }else{
    
//        [ownerFollowBtn setSelected:true];
//    }
    
    [self createDjView];
}

-(void)clickUserBtn:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%d",tap.view.tag);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[NSString stringWithFormat:@"%d",tap.view.tag] forKey:@"userid"];
    
    [_obj createPlayerView:dic];
    
}

-(void)SpaceView{
    if([[activityDic objectForKey:@"club"] count]!=0){
        
        if ([[activityDic objectForKey:@"club"] objectAtIndex:0]==nil||[[activityDic objectForKey:@"club"] objectAtIndex:0]==[NSNull null]) {
            
        }else{
           [_obj getDataById:@"2" andId:[[[activityDic objectForKey:@"club"]objectAtIndex:0] objectForKey:@"clubid"]];
//            [_obj getFamilyOfficialWithRaverId:nil];
        }
    }
}


-(void)addbrandView{
    
       if([[activityDic objectForKey:@"host"] count]!=0){
    
    if ([[activityDic objectForKey:@"host"] objectAtIndex:0]==nil||[[activityDic objectForKey:@"host"] objectAtIndex:0]==[NSNull null]) {
        
    }else{
        if ([[[activityDic objectForKey:@"host"] objectAtIndex:0]objectForKey:@"hostid"]==nil||[[[activityDic objectForKey:@"host"]objectAtIndex:0] objectForKey:@"hostid"]==[NSNull null]) {
            [[DataHander sharedDataHander]showViewWithStr:@"还没有主办方" andTime:1 andPos:CGPointZero];
        }else{
        [_obj getDataById:@"4" andId:[[[activityDic objectForKey:@"host"] objectAtIndex:0]objectForKey:@"hostid"]];
        }
    }
           
       }
}


-(void)djViewJump:(UITapGestureRecognizer *)tap{
    [_obj getDataById:@"1" andId:[NSString stringWithFormat:@"%ld",tap.view.tag]];
}

-(void)createDjView{

    UIScrollView *DjView = [[UIScrollView alloc] initWithFrame:CGRectMake(28*DEF_Adaptation_Font*0.5, 1590*DEF_Adaptation_Font_x*0.5, DEF_SCREEN_WIDTH-28*DEF_Adaptation_Font*0.5, 281*DEF_Adaptation_Font*0.5)];
    DjView.showsVerticalScrollIndicator = NO;
    DjView.showsHorizontalScrollIndicator = NO;
    [bkScroll addSubview:DjView];

    for (int i=0;i<[[activityDic objectForKey:@"dj"] count];i++)
    {
        UIImageView *djViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(0*DEF_Adaptation_Font*0.5+(i*238*DEF_Adaptation_Font*0.5), 30*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5, 192*DEF_Adaptation_Font*0.5)];
        [djViewHead sd_setImageWithURL:[[NSURL alloc] initWithString:[[[[activityDic objectForKey:@"dj"]objectAtIndex:i] objectForKey:@"avatar"] objectAtIndex:0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image != nil) {
                if (image.size.height>image.size.width) {//图片的高要大于与宽
                    CGRect rect = CGRectMake(0, image.size.height/2-image.size.width/2, image.size.width, image.size.width);//创建矩形框
                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                    djViewHead.image=[UIImage imageWithCGImage:cgimg];
                    CGImageRelease(cgimg);
                }else{
                    CGRect rect = CGRectMake(image.size.width/2-image.size.height/2, 0, image.size.height, image.size.height);//创建矩形框
                    CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
                    djViewHead.image=[UIImage imageWithCGImage:cgimg];
                    CGImageRelease(cgimg);
                }
            }
        }];
        djViewHead.tag = [[[[activityDic objectForKey:@"dj"]objectAtIndex:i] objectForKey:@"djid"] intValue];
        [DjView addSubview:djViewHead];
        djViewHead.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(djViewJump:)];
        [djViewHead addGestureRecognizer:singleTap];

        UILabel *ticketStr = [LooperToolClass createLableView:CGPointMake(15*DEF_Adaptation_Font*0.5+(i*238*DEF_Adaptation_Font*0.5),245*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(192*DEF_Adaptation_Font_x*0.5, 26*DEF_Adaptation_Font_x*0.5) andText:[[[activityDic objectForKey:@"dj"]objectAtIndex:i] objectForKey:@"djname"] andFontSize:14 andColor:[UIColor colorWithRed:97/255.0 green:101/255.0 blue:114/255.0 alpha:1.0] andType:NSTextAlignmentLeft];
        [ticketStr setFont:[UIFont fontWithName:@"PingFangSC-Light" size:13]];
        [DjView addSubview:ticketStr];
        
    }
    
     DjView.contentSize = CGSizeMake([[activityDic objectForKey:@"dj"] count]*238*DEF_Adaptation_Font*0.5, 281*DEF_Adaptation_Font*0.5);
}

-(void)initView{
    
    
    UIImageView *bkView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    
    [bkView sd_setImageWithURL:[[NSURL alloc] initWithString:[[activityDic objectForKey:@"data"]objectForKey:@"photo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self addSubview:bkView];
    
    bkScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT)];
    
   // [UIColor colorWithRed:18/255.0 green:19/255.0 blue:78/255.0 alpha:1.0]
    [bkScroll setBackgroundColor:[UIColor clearColor]];
    bkScroll.tag = 100;
    bkScroll.delegate=self;
    [self addSubview:bkScroll];

    bkScroll.contentSize= CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT*2);
  
    [self createBkView];
    [self createHudView];
    
   // [self performSelector:@selector(createWebView) withObject:nil afterDelay:0.5];
    
    [self createWebView];
}

-(void)closeTouchView{

   // [self moveActivityBtn];
    
    
    //[gooeyMenu tapToSwitchOpenOrClose];
}


-(void)createActivityBtn{
    
    touchView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [touchView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [touchView addTarget:self action: @selector(closeTouchView) forControlEvents:UIControlEventTouchDown];
    [self addSubview:touchView];
    
    touchView.hidden = true;
    
    ticketBtn = [LooperToolClass createBtnImageNameReal:@"btn_ticket.png" andRect:CGPointMake(550*DEF_Adaptation_Font*0.5,1045*DEF_Adaptation_Font*0.5) andTag:106 andSelectImage:@"btn_ticket.png" andClickImage:@"btn_ticket.png" andTextStr:nil andSize:CGSizeMake(70*DEF_Adaptation_Font*0.5,99*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:ticketBtn];
     ticketBtn.alpha=0;

    loopBtn = [LooperToolClass createBtnImageNameReal:@"btn_activity_looper.png" andRect:CGPointMake(550*DEF_Adaptation_Font*0.5,1045*DEF_Adaptation_Font*0.5) andTag:107 andSelectImage:@"btn_activity_looper.png" andClickImage:@"btn_activity_looper.png" andTextStr:nil andSize:CGSizeMake(70*DEF_Adaptation_Font*0.5,99*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:loopBtn];
     loopBtn.alpha=0;

    calendarBtn = [LooperToolClass createBtnImageNameReal:@"btn_calendar.png" andRect:CGPointMake(550*DEF_Adaptation_Font*0.5,1045*DEF_Adaptation_Font*0.5) andTag:108 andSelectImage:@"btn_calendar.png" andClickImage:@"btn_calendar.png" andTextStr:nil andSize:CGSizeMake(70*DEF_Adaptation_Font*0.5,99*DEF_Adaptation_Font*0.5) andTarget:self];
    [self addSubview:calendarBtn];
    calendarBtn.alpha=0;
}

-(void)moveActivityBtn{
    if(isShowBtn==0){
          touchView.hidden = false;
        [UIView animateWithDuration:0.3 animations:^{
            ticketBtn.alpha=1.0;
            loopBtn.alpha=1.0;
            calendarBtn.alpha=1.0;
            [ticketBtn setFrame:CGRectMake(553*DEF_Adaptation_Font*0.5, 857*DEF_Adaptation_Font*0.5, ticketBtn.frame.size.width, ticketBtn.frame.size.height)];
            [loopBtn setFrame:CGRectMake(430*DEF_Adaptation_Font*0.5, 897*DEF_Adaptation_Font*0.5, loopBtn.frame.size.width, loopBtn.frame.size.height)];
            [calendarBtn setFrame:CGRectMake(366*DEF_Adaptation_Font*0.5, 1015*DEF_Adaptation_Font*0.5, calendarBtn.frame.size.width, calendarBtn.frame.size.height)];
        }];
        isShowBtn=1;
    }else{
         touchView.hidden = true;
        [UIView animateWithDuration:0.3 animations:^{
            ticketBtn.alpha=0;
            loopBtn.alpha=0;
            calendarBtn.alpha=0;
            [ticketBtn setFrame:CGRectMake(550*DEF_Adaptation_Font*0.5, 1045*DEF_Adaptation_Font*0.5, ticketBtn.frame.size.width, ticketBtn.frame.size.height)];
            [loopBtn setFrame:CGRectMake(550*DEF_Adaptation_Font*0.5, 1045*DEF_Adaptation_Font*0.5, loopBtn.frame.size.width, loopBtn.frame.size.height)];
            [calendarBtn setFrame:CGRectMake(550*DEF_Adaptation_Font*0.5, 1045*DEF_Adaptation_Font*0.5, calendarBtn.frame.size.width, calendarBtn.frame.size.height)];
        }];
        isShowBtn=0;
    }
}
		
-(void)menuDidSelected:(NSInteger)index{
    NSLog(@"选中第%ld",(long)index);
     
    if(index==1){
        [self addTicketView];
    }else if(index==2){
         [_obj savaCalendar:[activityDic objectForKey:@"data"]];
    }else if(index==3){
        
        [[DataHander sharedDataHander] showViewWithStr:@"coming soon" andTime:1 andPos:CGPointZero];
//        NSArray *loopArray = [[NSArray alloc] initWithArray:[activityDic objectForKey:@"loop"]];
//        NSDictionary *dic =[loopArray objectAtIndex:0];
//        [_obj toLooperView:dic];
    }else if(index==100){
        if(isShowBtn==0){
             touchView.hidden = false;
            isShowBtn=1;
        }else{
            touchView.hidden = true;
            isShowBtn=0;
        }
       
    }
    
}



- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if (button.tag==100) {
        //payBtn
        [self.obj jumpToSaleTicketController:[activityDic objectForKey:@"data"] orderDic:_orderDic];
    }
    if(button.tag==101){
        
        [bkScroll removeFromSuperview];
        [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
       // [webV stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
        [webV removeFromSuperview];
        
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        [self removeFromSuperview];
        if (_isFromSearchView) {
            [self.obj popController];
        }

    }else if(button.tag==102){
        [_obj shareh5View:activityDic[@"data"]];
    }else if(button.tag==103){
        //[self moveActivityBtn];
    }else if(button.tag==106){
        [self addTicketView];
    }else if(button.tag==107){
       
        
        NSArray *loopArray = [[NSArray alloc] initWithArray:[activityDic objectForKey:@"loop"]];
        NSDictionary *dic =[loopArray objectAtIndex:0];
        [_obj toLooperView:dic];

    }else if(button.tag==108){
        [_obj savaCalendar:[activityDic objectForKey:@"data"]];
    }else if(button.tag==1009){
//添加关注
        if([ownerFollowBtn isSelected]==true){
            [_obj unfollowUser:[[activityDic objectForKey:@"owner"] objectForKey:@"userid"]];
            [ownerFollowBtn setSelected:false];
        [[DataHander sharedDataHander] showViewWithStr:@"取消关注" andTime:1 andPos:CGPointZero];
        }else{
            [_obj followUser:[[activityDic objectForKey:@"owner"] objectForKey:@"userid"]];
         [[DataHander sharedDataHander] showViewWithStr:@"成功关注" andTime:1 andPos:CGPointZero];
            [ownerFollowBtn setSelected:true];
        }
    }else if(button.tag==1010){

        if([joinBtn isSelected]==true){
            [joinBtn setSelected:false];
            [_obj addInformationToJoin:[LocalDataMangaer sharedManager].uid andActivityId:[[activityDic objectForKey:@"data"] objectForKey:@"activityid"] andLike:0];
            
        }else{
            [joinBtn setSelected:true];
            [_obj addInformationToJoin:[LocalDataMangaer sharedManager].uid andActivityId:[[activityDic objectForKey:@"data"] objectForKey:@"activityid"] andLike:1];
          
        }
       
    }else if(button.tag==1019){
        
        [_obj jumpToPhotoWall:[[activityDic objectForKey:@"data"] objectForKey:@"activityid"]];
        
    }
}

@end
