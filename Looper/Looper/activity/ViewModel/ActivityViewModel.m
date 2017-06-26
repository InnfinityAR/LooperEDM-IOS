//
//  ActivityViewModel.m
//  Looper
//
//  Created by 工作 on 2017/5/16.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityViewModel.h"
#import "activityModel.h"
#import "ActivityViewController.h"

#import "sendMessageActivityView.h"
#import "Base64Class.h"

#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
#import "WebViewController.h"
#define ActivityURL @"getActivity"
#import "LocalDataMangaer.h"
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
#import "UserInfoViewController.h"
@implementation ActivityViewModel
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
//陆兄style
-(id)initWithController:(id)controller{
    if(self=[super init]){
        self.obj = (ActivityViewController*)controller;
        [self initView];
    }
    return  self;
}
-(void)initView{
    self.activityV = [[ActivityView alloc] initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    [[_obj view] addSubview:self.activityV];
    
}


-(void)LocalPhoto
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [_obj presentViewController:picker animated:YES completion:nil];
        
    });
}


-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
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
        
        NSDate *now= [NSDate date];
        long int nowDate = (long int)([now timeIntervalSince1970]);
        NSString *time = [NSString stringWithFormat:@"%ldcs",nowDate];

        
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@%@%@",DocumentsPath, @"/image",time,@".png"];

        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
        
        
        
        
        //得到选择后沙盒中图片的完整路径
        
        NSLog(@"%@",filePath);
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        
        
       [self.sendView showSelectImage:filePath];
    }
    
}



-(NSInteger)rowNumber{
    
    return self.dataArr.count;
}
-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber+=1;
//    [self pustDataForSomeString:(NSString *)string];
    
}
-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    self.refreshNumber=0;
    //    [self pustDataForSomeString:(NSString *)string];
    
}


-(void)thumbActivityMessage:(NSString*)like andUserId:(NSString*)userId andMessageId:(NSString*)messageID andActivityID:(NSString *)activityID{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:messageID forKey:@"messageId"];
    [dic setObject:like forKey:@"like"];
NSLog(@"%@",dic);
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"thumbActivityMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
        
            [self getActivityInfoById:activityID andUserId:userId];
        }else{
            
        }
    }fail:^{
        
    }];
}


-(void)shareH5:(NSDictionary*)dic
{
    
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL = [dic objectForKey:@"userimage"];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我在looper,你在哪里" descr:[dic objectForKey:@"messagecontent"] thumImage:thumbURL];
        //设置网页地址
        
        shareObject.webpageUrl  = [NSString stringWithFormat:@"http://topic.looper.pro/?messageid=%@",[dic objectForKey:@"messageid"]];
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





-(void)sendActivityMessage:(NSString *)activityId and:(NSString*)message and:(NSArray*)images{
    
    NSMutableArray *imageDataArray= [[NSMutableArray alloc] initWithCapacity:50];
    
    for (int i=0;i<[images count];i++){
    
        NSLog(@"%@",[images objectAtIndex:i]);
        UIImage *imagePhoto2 = [UIImage imageNamed:[images objectAtIndex:i]];
        NSData *imageDataP2 = UIImagePNGRepresentation(imagePhoto2);
        [imageDataArray addObject:[Base64Class encodeBase64Data:imageDataP2]];
    }
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:activityId forKey:@"activityId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:message forKey:@"message"];
    [dic setObject:imageDataArray forKey:@"images"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"sendActivityMessage" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            [self getActivityInfoById:activityId andUserId:[LocalDataMangaer sharedManager].uid];
            
        }
    }fail:^{
        
    }];
}

-(void)getActivityInfoById:(NSString *)activityId  andUserId:(NSString *)userId{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [dic setObject:activityId forKey:@"activityId"];
    [dic setObject:userId forKey:@"userId"];
       NSLog(@"%@",dic);
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getActivityInfo" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
      self.barrageArr= responseObject[@"message"];
            [self.barrageView addImageArray:self.barrageArr];
        }
    }fail:^{
        
    }];
}


//加载数据
-(void)pustDataForSomeString:(NSString *)string{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:ActivityURL parameters:dic  success:^(id responseObject) {
        
        if([responseObject[@"status"] intValue]==0){
            self.dataArr = responseObject[@"data"];

            [self.activityV reloadTableData:self.dataArr];
 
        }
    }fail:^{
        
    }];
}

-(void)popController{
    
    [[_obj navigationController] popViewControllerAnimated:NO];
    
 
}
-(void)dataForH5:(NSDictionary *)dic{

    WebViewController *webVc = [[WebViewController alloc] init];
    [[_obj navigationController] pushViewController:webVc animated:NO];
    [webVc webViewWithData:dic andObj:self];
    
}
//跳转到userInfo界面
-(void)jumpToAddUserInfoVC:(NSString *)userID{
    UserInfoViewController *userVC=[[UserInfoViewController alloc]init];
    userVC.userID=userID;
    [[self.obj navigationController]pushViewController:userVC animated:NO];
}

@end
