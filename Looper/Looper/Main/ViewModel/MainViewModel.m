//
//  MainViewModel.m
//  Looper
//
//  Created by lujiawei on 12/11/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "MainViewModel.h"
#import "MainViewController.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "LocalDataMangaer.h"
#import "SelectLooperView.h"
#import "ActivityLayer.h"
#import "HomeViewController.h"
#import "SerachViewController.h"
#import "looperViewController.h"
#import "HudView.h"
#import "LooperToolClass.h"
#import "LocalDataMangaer.h"
#import "HowToPlayView.h"
#import "messageViewController.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>

#import "Base64Class.h"

#import "RongCloudManger.h"

#import "nMainView.h"

#import "UserInfoView.h"
#import "commonTableView.h"
#import "LooperListViewController.h"
#import "SettingViewController.h"
#import "NIMCloudMander.h"
#import "SimpleChatViewController.h"
#import "CreateLoopController.h"
#import "ActivityViewController.h"


#import "HowToPlayView.h"



@implementation MainViewModel{


    NSMutableArray *loopList;
    
    NSMutableArray *typesList;
    
    NSMutableArray *mapData;
    
    int checkXposition;
    
    int checkYposition;
    
    commonTableView *commonTable;
    
    NSArray *SessionArray;
    
    
    UIImageView *bkv ;
    

}
@synthesize musicData = _musicData;
@synthesize MainData = _mainData;
@synthesize mainV = _mainV;
@synthesize selectV = _selectV;
@synthesize activityV = _activityV;
@synthesize hudV = _hudV;
@synthesize createLoopV = _createLoopV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (MainViewController*)controller;
        [self createBackView];
        [self requestData];
    }
    return  self;
}


-(void)createBackView{
    bkv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    UIImage *imageV= [UIImage imageNamed:@"640-2.png"];
    bkv.image =imageV;
    [[_obj view] addSubview:bkv];
}


-(void)getSessionArray{
    SessionArray = [[NSArray alloc] initWithArray:[[NIMCloudMander sharedManager] allRecentSessions]];
}


-(void)getUserLoopList{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyLoops" parameters:dic success:^(id responseObject){
        
        loopList = [[NSMutableArray alloc] initWithArray:responseObject[@"data"]];
        
        if(_mainV!=nil){
            [self removeSelectLoopV];
            [self createLoopViewList];
        }else{
        
            [self initView];
        }
    }fail:^{
        
    }];
}


-(void)checkMapIsUse:(CGPoint)point{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.x] forKey:@"xPosition"];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.y] forKey:@"yPosition"];
    checkXposition = (int)point.x;
    checkYposition = (int)point.y;
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"checkLoopPosition" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
            [self getTitleList];
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)getTitleList{
    NSDictionary *dic = [[NSDictionary alloc] init];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopTitles" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            typesList =[[NSMutableArray alloc] initWithArray:responseObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:@selector(createLoopView:) withObject:typesList afterDelay:0.1];
            });
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}


-(void)updateMap{
    
    if(_mainV!=nil){
        
        //[_mainV requestMapData:CGPointMake(1,1)];
    }
}

-(void)getAreaMapList:(CGPoint)point{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.x] forKey:@"xPosition"];
    [dic setObject:[[NSNumber alloc] initWithFloat:point.y] forKey:@"yPosition"];
    [dic setObject:[[NSNumber alloc] initWithFloat:100] forKey:@"range"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopByCoordinates" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            mapData = responseObject[@"data"];
            //[_mainV responeseMapData:mapData];

             
        }else{

        }
    }fail:^{
        
    }];
}





-(void)requestgetMyFavorite{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getMyFavorite" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            _musicData = responseObject[@"data"];
           
            if(_mainV ==nil){
                [self initView];
                
                
                [UIView animateWithDuration:1.5 animations:^{
                
                    bkv.alpha=0;
                }];
            }else{
                [_mainV updataView];
                
                [commonTable updataView];
                
            }

        }
    }fail:^{
        
    }];
    
}

-(void)checkLoopName:(NSString*)loopName{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:loopName forKey:@"name"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getLoopByCoordinates" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
           
        }else{
            
        }
    }fail:^{
        
    }];
}

-(void)requestData{
    
    [[NIMCloudMander sharedManager] initNIMSDK];
    [self requestMainData];
    
    
}

-(void)requestMainData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getHome" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            NSLog(@"%@",responseObject);
            _mainData = [[NSDictionary alloc] initWithDictionary:responseObject];
            [self requestgetMyFavorite];
            
        }else{
            
        }
    }fail:^{
        
    }];
}

-(void)createLoopView:(NSMutableArray*)array{
    _createLoopV = [[CreateLoopView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andArray:array];
    [[_obj view] addSubview:_createLoopV];

}

-(void)createSerachView{
    
    SerachViewController *serachV = [[SerachViewController alloc] init];
   // serachV.startPoint = CGPointMake(40*DEF_Adaptation_Font*0.5, 80*DEF_Adaptation_Font*0.5);
   // serachV.bubbleColor = [UIColor colorWithRed:37/255.0 green:36/255.0 blue:42/255.0 alpha:1.0];
  // [_obj presentViewController:serachV animated:YES completion:nil];
    [[_obj navigationController]  pushViewController:serachV animated:YES];
}




-(void)JumpLooperView:(NSDictionary*)loopData{

    looperViewController *looperV = [[looperViewController alloc] init];

    [looperV initWithData:loopData];
    
    [[_obj navigationController]  pushViewController:looperV animated:NO];

}

-(void)pushControllerToUser:(NSDictionary*)dic{
    
    SimpleChatViewController *simpleC = [[SimpleChatViewController alloc] init];
    [simpleC chatTargetID:dic];
   // [_obj presentViewController:simpleC animated:NO completion:nil];
    
     [[_obj navigationController]  pushViewController:simpleC animated:YES];
}

-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [_obj presentModalViewController:picker animated:YES];
}


-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [_obj presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* MyImage = [[UIImage alloc]init];
        
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        //NSData *imageData = UIImagePNGRepresentation(image);
        
        MyImage=[LooperToolClass set_imageWithImage:image scaledToSize:CGSizeMake(400 * DEF_Adaptation_Font, 400 * DEF_Adaptation_Font)];
         NSData * data = [LooperToolClass set_ImageData_UIImageJPEGRepresentationWithImage:MyImage CGFloat_compressionQuality:0.5];
 
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:[NSDate date]];
        dateString = [NSString stringWithFormat:@"%@.png",dateString];
        NSString* filePath = [[NSString alloc]initWithFormat:@"%@/%@",DocumentsPath,dateString];
        [fileManager removeItemAtPath:filePath error:nil];
        
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
        [_createLoopV updataHeadView:filePath];
          [picker dismissViewControllerAnimated:YES completion:^(void){}];
        }
}


-(void)removeSelectLoopV{
    
    [_selectV removeCollocationV];
    [_selectV removeFromSuperview];
   
    _selectV = nil;

}


-(void)removelooperSelect{

    [_selectV removeFromSuperview];
}


-(void)pushHomeController{

    HomeViewController *home = [[HomeViewController alloc] init];
    [[_obj navigationController]  pushViewController:home animated:YES];


}

-(void)pushLooperListController{
    LooperListViewController *looperListVC= [[LooperListViewController alloc] init];
    looperListVC.startPoint = CGPointMake(217*DEF_Adaptation_Font*0.5, 585*DEF_Adaptation_Font*0.5);
    looperListVC.bubbleColor = [UIColor colorWithRed:37/255.0 green:31/255.0 blue:43/255.0 alpha:1.0];
     [[_obj navigationController]  pushViewController:looperListVC animated:YES];
    //[_obj presentViewController:looperListVC animated:YES completion:nil];
}

-(void)createMessageController{

    messageViewController *messageVc = [[messageViewController alloc] init];
//    [_obj presentViewController:messageVc animated:YES completion:nil];

      [[_obj navigationController]  pushViewController:messageVc animated:YES];
}

-(void)pushActivityViewController{
    ActivityViewController *activity = [[ActivityViewController alloc] init];
     [[_obj navigationController]  pushViewController:activity animated:YES];


}



-(void)hudOnClick:(int)type{

    if(type==LopperBtnTag){
        
        [self pushLooperListController];

    }else if(type==HomeBtnTag){
        [self performSelector:@selector(pushHomeController) withObject:nil afterDelay:0.3];
        
    }else if(type==DJBtnTag){
        [self pushActivityViewController];
        
    }else if(type==SearchBtnTag){
        [self createSerachView];
    }else if(type==ActivityBackBtnTag){
        [_activityV removeFromSuperview];
    }else if(type==ActivityFollowBtnTag){
        

    }else if(type==ActivityLikeBtnTag){
        
    
        
    }else if(type==createLoopBackTag){
        
        [_createLoopV removeFromSuperview];
        
    }else if(type==103){
        [self jumpToSettingC];
        
    }else if(type==104){
        [self createMessageController];
        
    }else if(type==8001){
        [self createCommonView:1];
        
    }else if(type==8002){
        [self createCommonView:2];
        
    }else if(type==8003){
        [self createCommonView:4];
        
    }else if(type==8004){
        [self createCommonView:3];
        
    } else if(type==ActivityShareBtnTag){
        
        [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
        [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            NSString* thumbURL =  @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"looper" descr:@"looper" thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl = @"www.baidu.com";
            
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
            }];
        }];
    }
}


-(void)requestCreateLoop:(NSDictionary*)dicData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:[dicData objectForKey:@"loopName"] forKey:@"name"];
    [dic setObject:[dicData objectForKey:@"selectType"] forKey:@"type"];
    [dic setObject:[dicData objectForKey:@"content"] forKey:@"description"];
    [dic setObject:[[NSNumber alloc] initWithInt:checkXposition] forKey:@"coordinateX"];
    [dic setObject:[[NSNumber alloc] initWithInt:checkYposition] forKey:@"coordinateY"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    UIImage *image = [UIImage imageNamed:[dicData objectForKey:@"head"]];
    NSData *imageData = UIImagePNGRepresentation(image);
    [dic setObject:[Base64Class encodeBase64Data:imageData] forKey:@"photo"];
    
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createLoop" parameters:dic success:^(id responseObject){
        [_createLoopV removeFromSuperview];
        if([responseObject[@"status"] intValue]==0){
             // [_mainV addLoopWithData:responseObject[@"data"]];
            
            [loopList addObject:responseObject[@"data"]];    
        }else{
            
            
        }
    }fail:^{
        
    }];
    
    
}


-(void)removeCommonView{

    [commonTable removeFromSuperview];
    

}


-(void)createCommonView:(int)type{
    commonTable=[[commonTableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self and:type];
    [[_obj view] addSubview:commonTable];

}


-(void)mapToPostition:(CGPoint)point{
    
    [_selectV removeFromSuperview];
   // [_mainV moveMap:point];
}



-(void)mainHudView{

    _hudV= [[HudView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
      _hudV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_hudV];
}


-(void)createActivityView{

    _activityV = [[ActivityLayer alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [_activityV initViewWithData:nil];
    [[_obj view] addSubview:_activityV];
}


-(void)createLoopViewList{

    _selectV = [[SelectLooperView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [_selectV initViewWithArray:loopList];
    [[_obj view] addSubview:_selectV];
}

-(void)moveLoopPos:(NSNotification*)notification{

    NSDictionary *messageDictionary = [notification object];
    NSDictionary* looperData = messageDictionary[@"data"];

    [self mapToPostition:CGPointMake([[looperData objectForKey:@"CoordinateX"] floatValue], [[looperData objectForKey:@"CoordinateY"] floatValue])];

}

-(void)toCreateLooperView{
    
    CreateLoopController *createLoop = [[CreateLoopController alloc] init];
    [[_obj navigationController]  pushViewController:createLoop animated:NO];
    
}


-(void)jumpToSettingC{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    [[_obj navigationController]  pushViewController:settingVc animated:YES];
}


-(void)initView{

    _mainV = [[nMainView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _mainV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_mainV];
    
    
    HowToPlayView *howToPlayV = [[HowToPlayView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:howToPlayV];
    [howToPlayV intoSceenViewType:1];
    
    
}




@end
