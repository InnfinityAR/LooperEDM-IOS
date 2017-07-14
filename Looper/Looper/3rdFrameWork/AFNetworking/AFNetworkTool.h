//
//  AFNetworkTool.h
//  AFNetText2.5
//
//  Created by 吕君 on 15/1/27.
//  Copyright (c) 2015年  Clarnece. All rights reserved.
//

/**
 要使用常规的AFN网络访问
 
 1. AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 
 所有的网络请求,均有manager发起
 
 2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
 
 1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
 2> 如果返回格式不是JSON的,
 
 3. 请求格式
 
 AFHTTPRequestSerializer            二进制格式
 AFJSONRequestSerializer            JSON
 AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 
 4. 返回格式
 
 AFHTTPResponseSerializer           二进制格式
 AFJSONResponseSerializer           JSON
 AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
 AFXMLDocumentResponseSerializer (Mac OS X)
 AFPropertyListResponseSerializer   PList
 AFImageResponseSerializer          Image
 AFCompoundResponseSerializer       组合
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetworkTool : NSObject

/**检测网路状态**/
+ (void)netWorkStatus;


+(void)Post_JavaServer_JSONWithUrl:(NSString*)urlStr
                        parameters:(NSMutableDictionary*)parameters
                           success:(void (^)(id responseObject))success
                              fail:(void (^)())fail;



/**
 *   Get 请求 JSON 常用
 *
 *  @param urlStr   URL 名称
 *  @param params  数据字典
 *  @param success 请求成功返回值
 *  @param fail    请求失败返回值
 */
+ (void)Clarence_GET_JSONDataWithUrl:(NSString *)urlStr
                            Params:(NSDictionary*)params
                           success:(void (^)(id json))success
                              fail:(void (^)())fail;

/**
 *   Get 请求 xml  不常用
 *
 *  @param urlStr  URL 名称
 *  @param success 请求成功返回值
 *  @param fail    请求失败返回值
 */
+ (void)Clarnece_GET_XMLDataWithUrl:(NSString *)urlStr
                          success:(void (^)(id xml))success
                             fail:(void (^)())fail;

/**
 *  post 请求数据 常用
 *
 *  @param urlStr     URL 名称
 *  @param parameters 数据字典 (建议可变字典)
 *  @param success    请求成功返回的参数
 *  @param fail       请求失败返回的参数
 */
+ (void)Clarnece_Post_JSONWithUrl:(NSString *)urlStr
                     parameters:(NSDictionary*)parameters
                        success:(void (^)(id responseObject))success
                           fail:(void (^)())fail;

/**
 *  下载文件 不常用
 *
 *  @param urlStr  文件地址
 *  @param success 请求成功返回值
 *  @param fail    请求失败返回值
 */
+ (void)Clarnece_Session_DownloadWithUrl:(NSString *)urlStr
                               success:(void (^)(NSURL *fileURL))success
                                  fail:(void (^)())fail;



/**
 *  上传两个文件! 不常用
 *
 *  @param urlStr                 URL
 *  @param params                 参数字典
 *  @param idcard_front_data      文件 data1
 *  @param idcard_back_data       文件 data2
 *  @param idcard_front_file_name 文件1 上传时用的字段名
 *  @param idcard_back_fileName   文件2 上传时用的字段名
 *  @param success                请求成功返回值
 *  @param fail                   请求失败返回值
 */
+ (void)Clarnece_Post_UploadWithUrl:(NSString *)urlStr
                           Params:(NSDictionary*)params
                Idcard_front_Data:(NSData*)idcard_front_data
                 Idcard_back_Data:(NSData*)idcard_back_data
            Idcard_front_fileName:(NSString*)idcard_front_file_name
             Idcard_back_fileName:(NSString*)idcard_back_fileName
                          success:(void (^)(id responseObject))success
                             fail:(void (^)())fail;



+ (void)Clarence_Post_UploadWithUrl:(NSString *)urlStr
                             Params:(NSDictionary*)params
                            fileUrl:(NSURL *)fileURL
                           fileName:(NSString *)fileName
                           fileType:(NSString *)fileTye
                            success:(void (^)(id responseObject))success
                               fail:(void (^)())fail;


/**
 *  post 上传文件! 图片  常用
 *
 *  @param urlStr   URL 链接名/ 宏拼接
 *  @param params   除了文件以外需要上传的数据
 *  @param data_arr 图片数组 此数组只保存 data 格式的元素
 *  @param success  请求成功返回值
 *  @param fail     请求失败返回值
 */
+ (void)Clarnece_Post_UploadWithUrl:(NSString*)urlStr
                           Params:(NSDictionary*)params
                         Data_arr:(NSArray*)data_arr
                          success:(void (^)(id responseObject))success
                             fail:(void (^)())fail;
@end
