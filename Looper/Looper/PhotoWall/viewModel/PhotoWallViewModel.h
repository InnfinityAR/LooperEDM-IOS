//
//  PhotoWallViewModel.h
//  Looper
//
//  Created by lujiawei on 10/07/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKRecordShortVideoViewController.h"
@interface PhotoWallViewModel : NSObject <PKRecordShortVideoDelegate>
{
    id obj;
    
}

@property (nonatomic )id obj;

-(id)initWithController:(id)controller andActivityId:(NSString*)activityId;

-(void)getImageBoard:(NSString*)activityID;
-(void)popController;
-(void)createSendPhotoWall;
-(void)createImageBoardText:(NSString*)text and:(NSArray*)images andVideoPath:(NSString*)videoPath;
-(void)createRecordVideo;
-(void)playVideoFile:(NSString*)videoFile;
-(void)playNetWorkVideo:(NSString*)videoUrl;
-(void)createActivityView;
@end
