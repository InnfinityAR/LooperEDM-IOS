//
//  addMusicViewModel.h
//  Looper
//
//  Created by lujiawei on 28/04/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addMusicViewModel : NSObject{
    
    id obj;
    
    
}
@property(nonatomic)id obj;
@property(nonatomic) NSArray *artistData;
@property(nonatomic) NSArray *musicList;
@property(nonatomic) NSString *looperId;


-(void)backView;
-(void)removeSongSelectV;
-(id)initWithController:(id)controller andLooperId:(NSString*)looperID;
-(void)getMusicByArtistName:(NSString*)ArtistName;
-(void)addMusics:(NSArray*)songArray;
@end
