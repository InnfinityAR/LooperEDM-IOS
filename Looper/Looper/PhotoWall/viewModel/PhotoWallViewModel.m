//
//  PhotoWallViewModel.m
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "PhotoWallViewModel.h"
#import "PhotoWallView.h"
#import "PhotoWallViewController.h"
#import "LooperConfig.h"
#import "LocalDataMangaer.h"
#import "LooperToolClass.h"
#import "AFNetworkTool.h"
#import "sendPhotoWall.h"
#import "Base64Class.h"
#import "PKFullScreenPlayerViewController.h"
#import "UIImage+PKShortVideoPlayer.h"
#import "DataHander.h"
#import "nActivityViewController.h"
#import "selectActivityView.h"
#import "PlayVideoView.h"


@implementation PhotoWallViewModel{

    sendPhotoWall *sendPhotoV;
    NSString *_activityId;
    PhotoWallView *PhotoWallV;
    nActivityViewController *activity;
    NSDictionary *_photoWallData;

}
-(id)initWithController:(id)controller andActivityId:(NSString*)activityId{
    if(self=[super init]){
        self.obj = (PhotoWallViewController*)controller;
        [self getImageBoard:activityId];
    }
    return  self;
    
}

-(void)requestData:(NSString*)activityId{

    

}

-(void)createSendPhotoWall{

    sendPhotoV =[[sendPhotoWall alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self];
    
    [[_obj view] addSubview:sendPhotoV];

    
    [sendPhotoV setLocationStr:[[_photoWallData objectForKey:@"activity"] objectForKey:@"activityname"]];
    
}





-(void)playVideoFile:(NSString*)videoFile{
    
    UIImage *image = [UIImage pk_previewImageWithVideoURL:[NSURL fileURLWithPath:videoFile]];
    PKFullScreenPlayerViewController *vc = [[PKFullScreenPlayerViewController alloc] initWithVideoPath:videoFile previewImage:image];
    [_obj presentViewController:vc animated:NO completion:NULL];

}

-(void)playNetWorkVideo:(NSString*)videoUrl{

    PlayVideoView *playVideoV  = [[PlayVideoView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andUrlStr:videoUrl];
    [[_obj view] addSubview:playVideoV];

}



-(void)createRecordVideo{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [NSProcessInfo processInfo].globallyUniqueString;
    NSString *path = [paths[0] stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"mp4"]];
    //跳转默认录制视频ViewController
    PKRecordShortVideoViewController *viewController = [[PKRecordShortVideoViewController alloc] initWithOutputFilePath:path outputSize:CGSizeMake(320, 240) themeColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:255/255.0 alpha:1]];
    //通过代理回调
    viewController.delegate = self;
    [_obj presentViewController:viewController animated:YES completion:nil];


}


- (void)didFinishRecordingToOutputFilePath:(NSString *)outputFilePath {
    //自定义的生成小视频聊天对象方法
    
    NSLog(@"%@",outputFilePath);
    
    
    [sendPhotoV videoFileSave:outputFilePath];
}


-(void)createActivityView{

    activity = [[nActivityViewController alloc] init];
    
    [[_obj navigationController]  pushViewController:activity animated:YES];
    
    [self performSelector:@selector(showActivityView) withObject:nil afterDelay:0.1];
    
    

}

-(void)showActivityView{


    [activity jumpToActivityId:_activityId];
}



-(void)popController{
    [[_obj navigationController] popViewControllerAnimated:true];

}


-(void)createImageBoardText:(NSString*)text and:(NSArray*)images andVideoPath:(NSString*)videoPath andVideoImage:(UIImage*)imageV{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_activityId forKey:@"activityId"];
    [dic setObject:text forKey:@"text"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];

    
    if(images!=nil){
        
        NSMutableArray *imageDataArray= [[NSMutableArray alloc] initWithCapacity:50];
        
        for (int i=0;i<[images count];i++){
            
            NSLog(@"%@",[images objectAtIndex:i]);
            UIImage *imagePhoto2 = [UIImage imageNamed:[images objectAtIndex:i]];
            NSData *imageDataP2 = UIImagePNGRepresentation(imagePhoto2);
            [imageDataArray addObject:[Base64Class encodeBase64Data:imageDataP2]];
        }
        
         [dic setObject:imageDataArray forKey:@"images"];
    }
    
    if(videoPath!=nil){
        NSData *imageData = UIImagePNGRepresentation(imageV);
        
        [dic setObject:[Base64Class encodeBase64Data:imageData] forKey:@"videoThumb"];

        [AFNetworkTool Clarence_Post_UploadWithUrl:@"createImageBoard" Params:dic fileUrl:[NSURL fileURLWithPath:videoPath] fileName:@"video" fileType:@"mp4" success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                
                [sendPhotoV removeFromSuperview];
                
                [[DataHander sharedDataHander] showViewWithStr:@"上传成功" andTime:1 andPos:CGPointZero];
                
                [self getImageBoard:_activityId];
            }else{
                
                
            }
        }fail:^{
            
        }];
    }else{
    
        [AFNetworkTool Clarnece_Post_JSONWithUrl:@"createImageBoard" parameters:dic success:^(id responseObject){
            if([responseObject[@"status"] intValue]==0){
                [sendPhotoV removeFromSuperview];
                
                [[DataHander sharedDataHander] showViewWithStr:@"上传成功" andTime:1 andPos:CGPointZero];
                  [self getImageBoard:_activityId];
            }else{
                
                
            }
        }fail:^{
            
        }];
    }
 
}

-(void)setActivityID:(NSDictionary*)dic{

    _activityId = [dic objectForKey:@"activityid"];
    
    [sendPhotoV setLocationStr:[dic objectForKey:@"activityname"]];
    [self getImageBoard:_activityId];
    

}


-(void)getOfflineInformationByIP{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getOfflineInformationByIP" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            selectActivityView *selectActivityV = [[selectActivityView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self andDic:responseObject];
            [[_obj view] addSubview:selectActivityV];
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}



-(void)thumbBoardMessage:(NSString*)boardId andLike:(int)isLike{


    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:boardId forKey:@"boardId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [dic setObject:[NSString stringWithFormat:@"%d",isLike] forKey:@"like"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"thumbBoardMessage" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
              [self getImageBoard:_activityId];
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}





-(void)getImageBoard:(NSString*)activityID{
    _activityId = activityID;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:activityID forKey:@"activityId"];
    [dic setObject:[LocalDataMangaer sharedManager].uid forKey:@"userId"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"getImageBoard" parameters:dic success:^(id responseObject){
        if([responseObject[@"status"] intValue]==0){
            
             _photoWallData =  [[NSDictionary alloc] initWithDictionary:responseObject];
            
            if(PhotoWallV!=nil){
                [PhotoWallV reloadData:responseObject];
            
            }else{
                PhotoWallV =[[PhotoWallView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) and:self and:responseObject];
                
                [[_obj view] addSubview:PhotoWallV];
               
            
            }
            
            
            
        }else{
            
            
        }
    }fail:^{
        
    }];
}






@end
