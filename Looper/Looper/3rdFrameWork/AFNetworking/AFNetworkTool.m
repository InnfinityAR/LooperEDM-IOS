//
//  AFNetworkTool.h
//  AFNetText2.5
//
//  Created by 吕君 on 15/1/27.
//  Copyright (c) 2015年  Clarence. All rights reserved.
//


#import "AFNetworkTool.h"
#import "DataHander.h"
#import "NSString +AES256.h"

#define URL_STR @"http://api2.innfinityar.com/web/"
//#define URL_STR @"http://api3.innfinityar.com/web/"

#define URL_JAVA_STR @"http://api2.innfinityar.com/web/"

#define LooperStr @"Looper2017"
#define Looperkey @"Chuangshi666"


@implementation AFNetworkTool



//#define URL @"http://test.baletoo.com/App/"
//菊花
+ (void)showHUDGood:(BOOL)showHUD
{
    if (showHUD)
    {
        [[DataHander sharedDataHander] showDlg];
    }
}

#pragma mark 检测网路状态破
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //        NSLog(@"%d", status);
    }];
}

#pragma mark - JSON方式获取数据
+ (void)Clarence_GET_JSONDataWithUrl:(NSString *)urlStr
                            Params:(NSDictionary*)params
                           success:(void (^)(id json))success
                              fail:(void (^)())fail;
{
    //加 菊花加载动画
    //[self showHUDGood:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [NSString stringWithFormat:@"https://api.weixin.qq.com/cgi-bin/user/info?access_token=2qXR3ng3e4FhkgEz5daqOiG5kfoWsUyoasoHKk7mps8Nx-KxezqgADSuGCtE_suR_gPzXOW84BkRhFPofoMnCzsEDz-3WkziZARq4IOmsUOCjMkG2ykVOXrYFV2DfCAmWEUbABACKA&openid=%@",urlStr];
    NSLog(@"param == %@",params);
    
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            //去掉 菊花加载动画
          //  [[DataHander sharedDataHander] hideDlg];
            
            success(responseObject);
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            //去掉 菊花加载动画
          //  [[DataHander sharedDataHander] hideDlg];
            fail();
        }
    }];
}


+(void)Post_JavaServer_JSONWithUrl:(NSString*)urlStr
                        parameters:(NSMutableDictionary*)parameters
                           success:(void (^)(id responseObject))success
                              fail:(void (^)())fail
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_JAVA_STR,urlStr];
    [parameters setValue:@"e3968d7f97b44296a16b558a6edde4e1" forKey:@"key"];
    [manager POST:url parameters:parameters constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            //去掉 菊花加载动画
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            //去掉 菊花加载动画
            fail();
        }
    }];
}



//||[urlStr isEqualToString:@"Banner/getInbox.html"]
#pragma mark - JSON方式post提交数据
+ (void)Clarnece_Post_JSONWithUrl:(NSString *)urlStr
                     parameters:(NSMutableDictionary*)parameters
                        success:(void (^)(id responseObject))success
                           fail:(void (^)())fail
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_STR,urlStr];
    
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]);
    NSString *time = [NSString stringWithFormat:@"%ldcs",nowDate];
    
    NSData *data = [time dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringBase64 = [data base64Encoding]; // base64格式的字符串
    

    NSString *aes1= [time aes256_encrypt:Looperkey];
    NSLog(@"%@",aes1);
    [parameters setObject:aes1 forKey:@"token"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",nowDate] forKey:@"timestamp"];

    
    if([urlStr isEqualToString:@"getFriendList"]||[urlStr isEqualToString:@"followUser"]||[urlStr isEqualToString:@"getUserById"]||[urlStr isEqualToString:@"unfollowUser"]||[urlStr isEqualToString:@"addPreferenceToComment"]||[urlStr isEqualToString:@"sendYunXinMessage"]||[urlStr isEqualToString:@"getThumbUpCount"]||[urlStr isEqualToString:@"getMyMessage"]||[urlStr isEqualToString:@"leaveLoop"]||[urlStr isEqualToString:@"getLoopByCoordinates"]||[urlStr isEqualToString:@"getUserInfo"]||[urlStr isEqualToString:@"sendYunXinMessage"]||[urlStr isEqualToString:@"getLoopMessage"]||[urlStr isEqualToString:@"getMyFavorite"]||[urlStr isEqualToString:@"getHome"]||[urlStr isEqualToString:@"getChatMessage"]||[urlStr isEqualToString:@"thumbActivityMessage"]||[urlStr isEqualToString:@"getActivityInfo"]||[urlStr isEqualToString:@"thumbBoardMessage"]||[urlStr isEqualToString:@"followBrand"]||[urlStr isEqualToString:@"getHeartBeat"]){
    }else{
    
          [[DataHander sharedDataHander] showDlg];
    }

    [manager POST:url parameters:parameters constructingBodyWithBlock:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            //去掉 菊花加载动画
            
            [[DataHander sharedDataHander] hideDlg];
            
            NSLog(@"%@",responseObject);
            
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            //去掉 菊花加载动画
            [[DataHander sharedDataHander] hideDlg];
            fail();
        }
    }];
}





#pragma mark - Session 下载下载文件
+ (void)Clarence_Session_DownloadWithUrl:(NSString *)urlStr
                               success:(void (^)(NSURL *fileURL))success
                                  fail:(void (^)())fail
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSString* url_file = [NSString stringWithFormat:@"%@%@",URL_STR,urlStr];
    NSString *urlString = [url_file stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        //        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        if (success) {
            success(fileURL);
        }
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
        if (fail) {
            fail();
        }
    }];
    
    [task resume];
}


#pragma mark - 文件上传 自己定义文件名
+ (void)Clarence_Post_UploadWithUrl:(NSString *)urlStr
                           Params:(NSMutableDictionary*)params
                          fileUrl:(NSURL *)fileURL
                         fileName:(NSString *)fileName
                         fileType:(NSString *)fileTye
                          success:(void (^)(id responseObject))success
                             fail:(void (^)())fail
{
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_STR,urlStr];
    
    
    NSDate *now= [NSDate date];
    long int nowDate = (long int)([now timeIntervalSince1970]);
    NSString *time = [NSString stringWithFormat:@"%ldcs",nowDate];
    
    NSData *data = [time dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringBase64 = [data base64Encoding]; // base64格式的字符串
    
    NSString *aes1= [time aes256_encrypt:Looperkey];
    
    [params setObject:aes1 forKey:@"token"];
    [params setObject:[NSString stringWithFormat:@"%ld",nowDate] forKey:@"timestamp"];
    
    [[DataHander sharedDataHander] showDlg];
    
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileURL:fileURL name:@"video" error:NULL];
   
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSLog(@"%@",responseObject);
             [[DataHander sharedDataHander] hideDlg];
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
             [[DataHander sharedDataHander] hideDlg];
            fail();
        }
    }];
}

#pragma mark - POST上传文件
+ (void)Clarence_Post_UploadWithUrl:(NSString *)urlStr
                           Params:(NSDictionary*)params
                Idcard_front_Data:(NSData*)idcard_front_data
                 Idcard_back_Data:(NSData*)idcard_back_data
            Idcard_front_fileName:(NSString*)idcard_front_file_name
             Idcard_back_fileName:(NSString*)idcard_back_fileName
                          success:(void (^)(id responseObject))success
                             fail:(void (^)())fail;
{
    [params setValue:@"2" forKey:@"f"];
    //加 菊花加载动画
//    [self showHUDGood:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_STR,urlStr];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //name 为服务器规定的图片字段 mimeType 为图片类型
        if (idcard_front_file_name.length > 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone systemTimeZone]];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString* dateString = [formatter stringFromDate:[NSDate date]];
            dateString = [NSString stringWithFormat:@"%@.png",dateString];
            NSData* data = [NSData data];
            data = idcard_front_data;
            NSString  *path = NSHomeDirectory();
            NSLog(@"path:%@",path);
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString* documentsDirectory = [paths objectAtIndex:0];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:dateString];
            
            [data writeToFile:fullPathToFile atomically:NO];
            [formData appendPartWithFileData:data name:idcard_front_file_name fileName:dateString mimeType:@"image/png"];
        }
        
        if (idcard_back_fileName.length > 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone systemTimeZone]];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString* dateString = [formatter stringFromDate:[NSDate date]];
            dateString = [NSString stringWithFormat:@"%@.png",dateString];
            NSData* data = [NSData data];
            data = idcard_back_data;
            NSString  *path = NSHomeDirectory();
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString* documentsDirectory = [paths objectAtIndex:0];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:dateString];
            
            [data writeToFile:fullPathToFile atomically:NO];
            [formData appendPartWithFileData:data name:idcard_back_fileName fileName:dateString mimeType:@"image/png"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
            //去掉 菊花加载动画
            [[DataHander sharedDataHander] hideDlg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
            //去掉 菊花加载动画
            [[DataHander sharedDataHander] hideDlg];
        }
    }];
}


/**
 *文件上传,文件名由服务器端决定 适合传多张图片
 *urlStr:    需要上传的服务器url
 *Idcard_front_Data:   需要上传的本地文件data
 *Idcard_front_fileName:  需要上传文件名以及扩展名
 */
+ (void)Clarence_Post_UploadWithUrl:(NSString*)urlStr
                           Params:(NSDictionary*)params
                         Data_arr:(NSArray*)data_arr
                          success:(void (^)(id responseObject))success
                             fail:(void (^)())fail;
{
    
    [self showHUDGood:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_STR,urlStr];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < data_arr.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone systemTimeZone]];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString* dateString = [formatter stringFromDate:[NSDate date]];
            dateString = [NSString stringWithFormat:@"%@_%lu.png",dateString,data_arr.count + 1];
            
            NSData* data = [NSData data];
            data = [data_arr objectAtIndex:i];
            NSString  *path = NSHomeDirectory();
            NSLog(@"path:%@",path);
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString* documentsDirectory = [paths objectAtIndex:0];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:dateString];
            
            [data writeToFile:fullPathToFile atomically:NO];
            NSString* name = [NSString stringWithFormat:@"file_%d",i + 1];
            
            [formData appendPartWithFileData:data name:name fileName:dateString mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            //去掉 菊花加载动画
            [[DataHander sharedDataHander] hideDlg];
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            //去掉 菊花加载动画
            [[DataHander sharedDataHander] hideDlg];
            fail();
        }
    }];
}
@end
