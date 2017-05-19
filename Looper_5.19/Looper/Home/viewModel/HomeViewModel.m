//
//  HomeViewModel.m
//  Looper
//
//  Created by lujiawei on 12/23/16.
//  Copyright © 2016 lujiawei. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeViewController.h"
#import "LooperConfig.h"
#import "meView.h"
#import "AccountView.h"
#import "MessageView.h"
#import "MineView.h"
#import "SelectToolView.h"
#import "PhoneViewController.h"
#import "CalendarView.h"
#import "LocalDataMangaer.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
#import "aboutView.h"
#import "WebViewController.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>

@implementation HomeViewModel{

    NSString*  filePath;
    SelectToolView *select;
    
    NSDictionary *mineDic;

}

@synthesize homeV = _homeV;
@synthesize obj = _obj;
@synthesize meV = _meV;
@synthesize settingV = _settingV;
@synthesize accountV = _accountV;
@synthesize messageV = _messageV;
@synthesize mineV = _MineV;
@synthesize calendarV = _calendarV;
@synthesize aboutV  =  _aboutV;

-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (HomeViewController*)controller;
        [self initView];
    }
    return  self;
}


-(void)getActivity{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"activity" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
           
        }else{
            
        }
    }fail:^{
        
    }];
    
}


-(void)getHomeInfo{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getHomeInfo" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            mineDic = responseObject[@"data"];
        }else{
            
        }
    }fail:^{
        
    }];

}

-(void)deallocViewAnimation{

    [_homeV removeAllAnimation];

}


-(void)initView{
    dispatch_async(dispatch_get_main_queue(), ^{
         [[DataHander sharedDataHander] showDlg];
          [self getHomeInfo];
          [self getActivity];
    });
    
    _homeV = [[HomeView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
     _homeV.multipleTouchEnabled=true;
    
    [[_obj view] addSubview:_homeV];
}


-(void)createSettingView{

    _settingV = [[SettingView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _settingV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_settingV];

}

-(void)createMeView{
    _meV = [[meView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _meV.multipleTouchEnabled=true;
    [_meV initWithData:mineDic];
    [[_obj view] addSubview:_meV];
}

-(void)createAccountView{

    _accountV = [[AccountView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _accountV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_accountV];

}

-(void)createMessageView{
    
    _messageV = [[MessageView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _messageV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_messageV];
    
}

-(void)createMineView{

    _MineV =[[MineView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _MineV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_MineV];

}


-(void)jumpToPhone
{

    PhoneViewController *phoneVc = [[PhoneViewController alloc] init];
    
    [[_obj navigationController] pushViewController:phoneVc animated:NO];


}

-(void)createCalendarV
{
    _calendarV = [[CalendarView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _calendarV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_calendarV];
}

-(void)removeCalendar{

    [_calendarV removeFromSuperview];

}



-(void)jumpToView:(int)TagView{
    if(TagView==2){
        [self createMeView];
    }else if(TagView==3){
        
  
    }
}


-(void)selectViewType:(int)type andSelectNum:(int)selNum andSelectStr:(NSString*)Selstr{
    NSLog(@"%d",type);
    if(type==settingWidhCache){
        if(selNum==100){
        
        }else if(selNum ==101){
        
        
        }
        [select removeFromSuperview];
    }
    
}

-(void)popViewController{
    
    [[_obj navigationController] popViewControllerAnimated:YES];

}

-(void)createAboutV{

    _aboutV = [[aboutView alloc]initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    _aboutV.multipleTouchEnabled=true;
    [[_obj view] addSubview:_aboutV];

}




-(void)jumpToH5:(NSDictionary*)h5Data{
    WebViewController *webVc = [[WebViewController alloc] init];
    [webVc webViewWithData:h5Data andObj:self];
    [[_obj navigationController] pushViewController:webVc animated:NO];
}

-(void)removeAboutV{

    [_aboutV removeFromSuperview];
      [self createMeView];
}

-(void)shareH5
{
    

    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL = @"https://looper.blob.core.chinacloudapi.cn/images/looperlogo_dark.jpg";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我在looper,你在哪里" descr:@"looper 带着电音 一目前行" thumImage:thumbURL];
        //设置网页地址
     
        shareObject.webpageUrl  = @"http://www.innfinityar.com/?mod=main&share";
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





-(void)hudOnClick:(int)type{
    if(type==meBackTag){
        [_meV removeFromSuperview];
    }else if(type==meSettingTag){
        [_meV removeFromSuperview];
        [self createSettingView];
    }else if(type==meShareTag){
        
        
        [self shareH5];
        
        
    }else if(type==meAboutTag){
        [_meV removeFromSuperview];
        [self createAboutV];
    }else if(type==meHeadTag){
      //  [_meV removeFromSuperview];
      //  [self createMineView];
    }else if(type==meLogOutTag){
        
    }else if(type==settingBack){
        [_settingV removeFromSuperview];
        [self createMeView];
    }else if(type==settingAccount){
        [_settingV removeFromSuperview];
        [self createAccountView];
    }else if(type==settingMessage){
        [_settingV removeFromSuperview];
        [self createMessageView];
    }else if(type==settingWidhCache){
        
        select =[[SelectToolView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
        select.multipleTouchEnabled=true;
        [[_obj view] addSubview:select];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
        [dic setObject:@"确认要清除缓存吗？" forKey:@"LableStr"];
        [select initView:dic andViewType:1 andTypeTag:settingWidhCache];

    }else if(type==AccountBackTag){
        [_accountV removeFromSuperview];
        [self createSettingView];
    }else if(type==MessageBackTag){
        [_messageV removeFromSuperview];
        [self createSettingView];
    }else if(type==MineBackTag){
        [_MineV removeFromSuperview];
        [self createMeView];
    }
    
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

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    
        NSLog(@"%@",filePath);
    
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
    } 
    
}






@end
