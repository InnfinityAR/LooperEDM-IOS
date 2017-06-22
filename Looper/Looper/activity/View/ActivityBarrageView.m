//
//  ActivityBarrageView.m
//  Looper
//
//  Created by 工作 on 2017/6/19.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "ActivityBarrageView.h"
#import "LooperToolClass.h"
#import "ActivityView.h"
#import "UIImageView+WebCache.h"
#import "LooperConfig.h"
#import "looperlistCellCollectionViewCell.h"
#import "sendMessageActivityView.h"
#import "ActivityViewModel.h"
#import "LocalDataMangaer.h"

@implementation ActivityBarrageView{
    float labelHeight;
}
-(NSMutableArray *)allShowTags{
    if (!_allShowTags) {
        _allShowTags=[[NSMutableArray alloc]init];
    }
    return _allShowTags;
}
-(NSMutableArray *)allShowImageTags{
    if (!_allShowImageTags) {
        _allShowImageTags=[NSMutableArray new];
    }
    return _allShowImageTags;
}
-(NSMutableArray *)buddleArr{
    if (!_buddleArr) {
        _buddleArr=[NSMutableArray new];
    }
    return _buddleArr;
}
-(instancetype)initWithFrame:(CGRect)frame and:(id)idObject and:(id)viewModel{
    if (self = [super initWithFrame:frame]) {
        self.obj = (ActivityView*)idObject;
        self.viewModel=viewModel;
        [self createCollectionView];
        [self initailHeaderView];
        [self initailBuddleView];
        self.activityID=[self.obj activityID];
         [self.viewModel setBarrageView:self];
         [self.viewModel getActivityInfoById:self.activityID];
        labelHeight=85.0;
        UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_looper_back.png" andRect:CGPointMake(21/2, 48/2) andTag:100 andSelectImage:@"btn_looper_back.png" andClickImage:@"btn_looper_back.png" andTextStr:nil andSize:CGSizeMake(44/2, 62/2) andTarget:self];
        [self addSubview:backBtn];
    }
    return self;

}

-(void)addImageArray:(NSArray *)imageArray{
    self.barrageInfo=imageArray;
    for (NSDictionary *buddleDic in imageArray) {
   [self.buddleArr   addObject: [buddleDic objectForKey:@"messagecontent"]];
    }
    [_collectView reloadData];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    
    if(button.tag==100){
        
        [self removeFromSuperview];
    }
    if (button.tag==101) {
        NSLog(@"这是一个发表评论button");
        sendMessageActivityView *view=[[sendMessageActivityView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) and:self.viewModel and:self];
        view.obj=self.viewModel;
        view.barrageView=self;
        [self.viewModel setSendView:view];
        [self.viewModel setBarrageView:self];
        [self addSubview:view];
    }
    if (button.tag>=2000&&button.tag<3000) {
        NSLog(@"这是一个分享button");
    }
    if (button.tag>=5000&&button.tag<6000) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowImageTags addObject:@(button.tag)];
        labelHeight=button.alpha;
        [self.collectView reloadData];
    }

    if (button.tag>=3000&&button.tag<4000) {
        NSLog(@"这是修改cell的高度的button");
        [self.allShowTags addObject:@(button.tag)];
        labelHeight=button.alpha;
        [self.collectView reloadData];
    }
    if (button.tag<5000&&button.tag>=4000) {
            //在这返回islike和thumbupcount的参数
            if (!button.selected) {
                [button setSelected:YES];
               //从第二个cell开始算的
                [self.viewModel thumbActivityMessage:@"1" andUserId: [self.barrageInfo[button.tag-4000-1]objectForKey:@"userid"] andMessageId:[self.barrageInfo[button.tag-4000-1]objectForKey:@"messageid"] andActivityID:self.activityID];
            }
            else{
                [button setSelected:NO];
                [self.viewModel thumbActivityMessage:@"0" andUserId: [self.barrageInfo[button.tag-4000-1]objectForKey:@"userid"] andMessageId:[self.barrageInfo[button.tag-4000-1]objectForKey:@"messageid"] andActivityID:self.activityID];
            }

        NSLog(@"这是一个点赞按钮");
    }
}
- (void)initailHeaderView {
    
    self.headerView = [[UIImageView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40 - self.collectView.contentOffset.y);
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:[self.obj objDic][@"activityimage"]]];
    [self addSubview:self.headerView];
}
- (void)initailBuddleView {
    
    self.buddleView = [[UIImageView alloc] init];
    self.buddleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40 - self.collectView.contentOffset.y);
    self.buddleView.contentMode = UIViewContentModeScaleAspectFill;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(initDate) userInfo:nil repeats:YES];
    [self.headerView addSubview:self.buddleView];
}

//添加弹幕
-(void)initDate
{
    NSArray *danmakus = @[@"我去",
                          @"路见不平",
                          @"拔刀相助",
                          @"额，就是负伤啊",
                          @"错了，那是勇猛无敌",
                          @"哈？！英雄救美呢！！！！！",
                          @"哈哈哈哈。。。",
                          @"你们说错啦，那个坑货！",
                          @"这是一个故事啊！",
                          @"不懂不要乱说",
                          @"额。。。",
                          @"什么情况",
                          @"hello meizi",
                          @"天理难容啊～",
                          @"放开它，让我来",
                          @"nb",
                          @"这样都可以？！",
                          @"看不懂",
                          @"不错不错，有大酱风范～",
                          @"如果有一天。。。",
                          @"我去，天掉下来了",
                          @"都挺好的",
                          @"你们看到后面了吗，貌似有背景呢，哈哈哈哈哈。。。",
                          @"真是，额，强",
                          @"可以可以"];
    if (self.buddleArr.count!=0) {
        danmakus=_buddleArr;
    }
    NSString *str = [danmakus objectAtIndex:rand()%danmakus.count];
    UILabel *label = [[UILabel alloc]init];
    if (40 - self.collectView.contentOffset.y>50) {
    label.frame =CGRectMake(DEF_WIDTH(self), rand()%(int)(40 - self.collectView.contentOffset.y-30), 240, 50*DEF_Adaptation_Font*0.5);
    label.text = str;
        CGRect frame=label.frame;
        frame.size.width=[self widthForString:str andHeight:30 andText:label]+60;
        label.frame=frame;
        label.textAlignment=1;
        label.layer.cornerRadius=25*DEF_Adaptation_Font*0.5;
        label.layer.masksToBounds=YES;
    label.textColor =[UIColor whiteColor];
    label.backgroundColor=[self randomColor];
    //将label加入本视图中去。
    [self.buddleView addSubview:label];
    [self move:label];
    }
    if (40 - self.collectView.contentOffset.y<400*DEF_Adaptation_Font*0.5) {
        [self.buddleView setHidden:YES];
    }
    else{
    [self.buddleView setHidden:NO];
    }
  }
-(void)move:(UILabel*)_label
{
    [UIView animateWithDuration:8 animations:^{
        _label.frame = CGRectMake(- _label.frame.size.width, _label.frame.origin.y, _label.frame.size.width, _label.frame.size.height);
    } completion:^(BOOL finished) {
        [_label removeFromSuperview];
    }
     ];
    
}
-(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


-(void)createCollectionView{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
//    looperListFlowLayout * flowLayout = [[looperListFlowLayout alloc]init];
//    flowLayout.delegate = self;
//    flowLayout.numberOfColumn = 2;
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self), DEF_HEIGHT(self)) collectionViewLayout:flowLayout];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.delegate = self;
    _collectView.dataSource = self;
     _collectView.alwaysBounceVertical = YES;
    //偏移量（预留出顶部图片的位置）
    _collectView.contentInset = UIEdgeInsetsMake(450*DEF_Adaptation_Font*0.5, 0, 0, 0 );
    [_collectView setBackgroundColor:[UIColor colorWithRed:45/255.0 green:20/255.0 blue:53/255.0 alpha:1.0]];
    [_collectView registerClass:[looperlistCellCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellView"];
    [self addSubview:_collectView];
}
////得到 item之间的间隙大小
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(looperListFlowLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
////最小行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(looperListFlowLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}



#pragma mark-<UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
return self.barrageInfo.count+1;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    looperlistCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellView" forIndexPath:indexPath] ;
    
    for (UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (!cell) {
        cell = [[looperlistCellCollectionViewCell alloc]init];
    }else{
        
    }
    cell.layer.cornerRadius=4.0;
    cell.layer.masksToBounds=YES;
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            UIButton *button= [LooperToolClass createBtnImageNameReal:@"writeBuddle.png" andRect:CGPointMake(0, 0) andTag:101 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(DEF_WIDTH(self)/2-10, DEF_WIDTH(self)/2-10) andTarget:self];
            [cell.contentView addSubview:button];
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
            imageView.image=[UIImage imageNamed:@"1.png"];
           imageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
            imageView.layer.masksToBounds=YES;
            [cell.contentView addSubview:imageView];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
            label.text=[NSString stringWithFormat:@"%ld",indexPath.row];
              label.font=[UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:label];
            cell.backgroundColor=[UIColor colorWithRed:45/255.0 green:20/255.0 blue:53/255.0 alpha:1.0];
            return cell;
        }
    //赋值
        if (self.barrageInfo.count) {
            NSDictionary *imageDic=self.barrageInfo[indexPath.row-1];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"userimage"]]];
        imageView.layer.cornerRadius =20*DEF_Adaptation_Font*0.5;
        imageView.layer.masksToBounds=YES;
    [cell.contentView addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(80*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)-90)*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5)];
        label.font=[UIFont boldSystemFontOfSize:14];
         label.textColor=[UIColor whiteColor];
    label.text=[imageDic objectForKey:@"username"];
    [cell.contentView addSubview:label];
    cell.backgroundColor = [UIColor redColor];
            UIButton *button= [LooperToolClass createBtnImageNameReal:@"btn_looper_share.png" andRect:CGPointMake(cell.frame.size.width-5-40*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-40*DEF_Adaptation_Font*0.5) andTag:(int)(2000+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
            [cell.contentView addSubview:button];
            UIButton *commendBtn= [LooperToolClass createBtnImageNameReal:@"commendNO.png" andRect:CGPointMake(5, cell.frame.size.height-5-30*DEF_Adaptation_Font*0.5) andTag:(int)(4000+indexPath.row) andSelectImage:@"commendYes.png" andClickImage:@"commendYes.png" andTextStr:nil andSize:CGSizeMake(30*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5) andTarget:self];
            if ([imageDic[@"like"]intValue]==1) {
                [commendBtn setSelected:YES];
            }
            [cell.contentView addSubview:commendBtn];
            UILabel *commendLB=[[UILabel alloc]initWithFrame:CGRectMake(10+30*DEF_Adaptation_Font*0.5,cell.frame.size.height-5-30*DEF_Adaptation_Font*0.5, 90*DEF_Adaptation_Font*0.5, 30*DEF_Adaptation_Font*0.5)];
            commendLB.font=[UIFont boldSystemFontOfSize:13];
            commendLB.textColor=[UIColor whiteColor];
            commendLB.text=[NSString stringWithFormat:@"%@赞",imageDic[@"thumbupcount"]];
            [cell.contentView addSubview:commendLB];

           //在这边判断是否有图片
            if ([imageDic objectForKey:@"messagePicture"]==[NSNull null]||[[imageDic objectForKey:@"messagePicture"]isEqualToString:@""]) {
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), DEF_WIDTH(self)/2-10-100*DEF_Adaptation_Font*0.5)];
        label2.textAlignment=NSTextAlignmentCenter;
               label2.text=imageDic[@"messagecontent"];
//        label2.text=[NSString stringWithFormat:@"说点什么...这好似一串很长很长的字符串。。。我也不知道要说啥。就先这样测试一下.还不够长，这TM写的竟然还不够长，非叫我我合reifhwe  wfkwejfnewkfkfwnfew"];
      float  label2Height= [self heightForString:label2.text andWidth:(DEF_WIDTH(self)/2-50*DEF_Adaptation_Font*0.5) andText:label2];
        label2.font=[UIFont boldSystemFontOfSize:14];
         label2.textColor=[UIColor whiteColor];
        [cell.contentView addSubview:label2];
         label2.numberOfLines=0;
        if (label2Height>85.0) {
             label2.numberOfLines=5;
        }
        UIButton *allShowBtn= [LooperToolClass createBtnImageNameReal:@"backView.png" andRect:CGPointMake(cell.frame.size.width/2-5-20*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-40*DEF_Adaptation_Font*0.5) andTag:(int)(3000+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
        allShowBtn.alpha=label2Height;
                [cell.contentView addSubview:allShowBtn];
        //用于消除allShowBtn
        for (NSNumber *tag in self.allShowTags) {
            if ([tag intValue]==indexPath.row+3000) {
                 [allShowBtn removeFromSuperview];
                [self layoutSubviewsandCell:cell AndLabelHeight:label2Height];
                CGRect frame=label2.frame;
                frame.size.height=label2Height+20*DEF_Adaptation_Font*0.5;
                label2.frame=frame;
                label2.numberOfLines=0;
                [cell layoutIfNeeded];
    }
        }
    if (label2Height<=85.0) {
            [allShowBtn removeFromSuperview];
        }
            }else{
            //在这里添加有imageView的情况
                UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), 80*DEF_Adaptation_Font*0.5)];
                [imageV sd_setImageWithURL:[NSURL URLWithString:[imageDic objectForKey:@"messagePicture"]]];
                imageV.contentMode =  UIViewContentModeScaleAspectFill;
                imageV.clipsToBounds  = YES;
                [cell.contentView addSubview:imageV];
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 135*DEF_Adaptation_Font*0.5, (DEF_WIDTH(self)/2-20), DEF_WIDTH(self)/2-10-185*DEF_Adaptation_Font*0.5)];
                label2.textAlignment=NSTextAlignmentCenter;
                label2.text=imageDic[@"messagecontent"];
                float  label2Height= [self heightForString:label2.text andWidth:(DEF_WIDTH(self)/2-50*DEF_Adaptation_Font*0.5) andText:label2];
                label2.font=[UIFont boldSystemFontOfSize:14];
                label2.textColor=[UIColor whiteColor];
                [cell.contentView addSubview:label2];
                label2.numberOfLines=0;
                if (label2Height>45.0) {
                    label2.numberOfLines=3;
                }
                UIButton *allShowBtn= [LooperToolClass createBtnImageNameReal:@"backView.png" andRect:CGPointMake(cell.frame.size.width/2-5-20*DEF_Adaptation_Font*0.5, cell.frame.size.height-5-40*DEF_Adaptation_Font*0.5) andTag:(int)(5000+indexPath.row) andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(40*DEF_Adaptation_Font*0.5, 40*DEF_Adaptation_Font*0.5) andTarget:self];
                    allShowBtn.alpha=label2Height;
                [cell.contentView addSubview:allShowBtn];
                //用于修改image和label的frame
                for (NSNumber *tag in self.allShowImageTags) {
                    if ([tag intValue]==indexPath.row+5000) {
                        [allShowBtn removeFromSuperview];
                        CGRect frame=label2.frame;
                        frame.size.height=label2Height+20*DEF_Adaptation_Font*0.5;
                        frame.origin.y=55*DEF_Adaptation_Font*0.5+ (DEF_WIDTH(self)/2-20);
                        label2.frame=frame;
                        label2.numberOfLines=0;
                        CGRect frame2=imageV.frame;
                        frame2.size.height=(DEF_WIDTH(self)/2-20);
                        imageV.frame=frame2;
                        [cell layoutIfNeeded];
                    }
                }

            }
}
    return cell;
        
        //下面是section：0
    }else{
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 80*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-10, 80*DEF_Adaptation_Font*0.5)];
        label.text=[NSString stringWithFormat:@"【LooperEDM】抖腿大战即将开始，说说你心目中的抖腿大神。大家一起嗨起来！！！"];
        label.font=[UIFont boldSystemFontOfSize:13];
        label.textColor=[UIColor whiteColor];
        label.numberOfLines=2;
        [cell.contentView addSubview:label];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 160*DEF_Adaptation_Font*0.5, DEF_WIDTH(self)-10, 80*DEF_Adaptation_Font*0.5)];
        label2.text=[NSString stringWithFormat:@"%ld个人已经进入战场，Let me lang",indexPath.row+2548];
        label2.font=[UIFont systemFontOfSize:13];
        label2.textColor=[UIColor whiteColor];
        label2.numberOfLines=2;
        [cell.contentView addSubview:label2];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,  240*DEF_Adaptation_Font*0.5-4, DEF_WIDTH(self), 4)];
        imageView.image=[UIImage imageNamed:@"btn_line.png"];
        [cell.contentView addSubview:imageView];
        cell.backgroundColor=[UIColor colorWithRed:45/255.0 green:20/255.0 blue:53/255.0 alpha:1.0];
        return cell;
    }
}
- (float) heightForString:(NSString *)value andWidth:(float)width andText:(UILabel *)label{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    label.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height+16.0;
}
- (float) widthForString:(NSString *)value andHeight:(float)height andText:(UILabel *)label{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    label.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(MAXFLOAT, height) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.width;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(DEF_WIDTH(self), 240*DEF_Adaptation_Font*0.5);
    }
    for (NSNumber *tag in self.allShowTags) {
        if ([tag intValue]==indexPath.row+3000) {
           return CGSizeMake(DEF_WIDTH(self)/2-10,DEF_WIDTH(self)/2-10+labelHeight-85.0+20);
        }
    }
    for (NSNumber *tag in self.allShowImageTags) {
        if ([tag intValue]==indexPath.row+5000) {
            return CGSizeMake(DEF_WIDTH(self)/2-10,DEF_WIDTH(self)/2-10+labelHeight-85.0+20+ (DEF_WIDTH(self)/2-20));
        }
    }
    return CGSizeMake(DEF_WIDTH(self)/2-10,DEF_WIDTH(self)/2-10);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}
//返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={320,45};
//    return size;
//    
//}
//这个cell的contentView改变没有用
- (void)layoutSubviewsandCell:(looperlistCellCollectionViewCell*)cell  AndLabelHeight:(float)label2Height{
    [super layoutSubviews];
//    CGRect cellFrame=cell.contentView.frame;
//    cellFrame.size.height=DEF_WIDTH(self)/2-10+label2Height-85.0;
//    cell.contentView.frame=cellFrame;
    cell.backgroundColor=[UIColor greenColor];
}

#pragma mark - < UITableViewDatasource >

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * settingCell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    settingCell.textLabel.text = @"随意";
    return settingCell;
}

#pragma mark - < UITableViewDelegate >
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
       CGRect newFrame = self.headerView.frame;
    CGRect newFrame2= self.collectView.frame;
    CGFloat settingViewOffsetY = 40 - scrollView.contentOffset.y;
//    CGPoint point =  [scrollView.panGestureRecognizer translationInView:self];
//        NSLog(@"scrollViewContent:%f==%f===%f",scrollView.contentOffset.y,settingViewOffsetY,250*DEF_Adaptation_Font*0.5);
    newFrame.size.height = settingViewOffsetY;
//    if (settingViewOffsetY <=500*DEF_Adaptation_Font*0.5) {
//        newFrame.size.height =settingViewOffsetY;
//        newFrame.origin.y=(settingViewOffsetY-500*DEF_Adaptation_Font*0.5)*0.2;
//    }
       if (settingViewOffsetY<=500*DEF_Adaptation_Font*0.5) {
//        self.settingView.contentInset = UIEdgeInsetsMake(settingViewOffsetY, 0, 0, 0);
           self.collectView.contentInset = UIEdgeInsetsMake(settingViewOffsetY, 0, 0, 0);
            newFrame.origin.y=(settingViewOffsetY-500*DEF_Adaptation_Font*0.5)*0.2;

     }
    self.headerView.frame = newFrame;
    self.collectView.frame=newFrame2;
}

@end
