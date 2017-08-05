//
//  AttenceTimelineCell.m
//  Product
//
//  Created by ACTIVATION GROUP on 14-8-7.
//  Copyright (c) 2014年 eKang. All rights reserved.
//

#import "AttenceTimelineCell.h"

@implementation AttenceTimelineCell

#define DotViewCentX 20//圆点中心 x坐标
#define VerticalLineWidth 1//时间轴 线条 宽度
#define ShowLabTop 10//cell间距
#define ShowLabWidth (320 - DotViewCentX - 20)
#define ShowLabFont [UIFont systemFontOfSize:15]

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.backgroundColor=[UIColor clearColor];
        verticalLineTopView = [[UIView alloc] init];
        verticalLineTopView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:verticalLineTopView];
        
        int dotViewRadius = 5;
        dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dotViewRadius * 2, dotViewRadius * 2)];
        dotView.backgroundColor = [UIColor greenColor];
        dotView.layer.cornerRadius = dotViewRadius;
        [self addSubview:dotView];
        
        verticalLineBottomView = [[UIView alloc] init];
        verticalLineBottomView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:verticalLineBottomView];
        
        //初始化生成button并把准备好的图片作为其背景图片
        showLab = [[UIButton alloc] init];
        showLab.titleLabel.font = ShowLabFont;
        showLab.titleLabel.numberOfLines = 20;
        [showLab setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        showLab.titleLabel.textAlignment = NSTextAlignmentLeft;
        showLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        showLab.titleEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 5);
        [self addSubview:showLab];
        
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    super.frame = frame;
    dotView.center = CGPointMake(DotViewCentX, ShowLabTop + 13);
    int cutHeight = dotView.frame.size.height/2.0 - 2;
    verticalLineTopView.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0, 0, VerticalLineWidth, dotView.center.y - cutHeight);
    verticalLineBottomView.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0, dotView.center.y + cutHeight, VerticalLineWidth, frame.size.height - (dotView.center.y + cutHeight));
}

//赋值
- (void)setDataSource:(NSString *)content isFirst:(BOOL)isFirst isLast:(BOOL)isLast {
    showLab.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 5, ShowLabTop, ShowLabWidth, [AttenceTimelineCell cellHeightWithString:content isContentHeight:YES]);
    [showLab setTitle:content forState:UIControlStateNormal];
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 20, showLab.frame.origin.y+showLab.frame.size.height, ShowLabWidth, 10)];
    timeLabel.text=@"2017年10月1日";
    timeLabel.textColor=[UIColor lightGrayColor];
    timeLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:timeLabel];
    UILabel *timeLabel2=[[UILabel alloc]initWithFrame:CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 20, timeLabel.frame.origin.y+timeLabel.frame.size.height, ShowLabWidth, 10)];
    timeLabel2.text=@"2017年10月2日";
    timeLabel2.textColor=[UIColor lightGrayColor];
    timeLabel2.font=[UIFont systemFontOfSize:13];
    [self addSubview:timeLabel2];

    
    //设置最上面和最下面是否隐藏
    verticalLineTopView.hidden = isFirst;
    verticalLineBottomView.hidden = isLast;
    
    //判断是否是第一个（是第一个更改背景色）
    dotView.backgroundColor = isFirst ? [UIColor greenColor] : [UIColor lightGrayColor];
    CGRect frame=dotView.frame;
    frame.size.width=7.0;
    frame.size.height=7.0;
    dotView.frame=isFirst? dotView.frame:frame;
}


//根据字符串的高度设置cell的高度
+ (float)cellHeightWithString:(NSString *)content isContentHeight:(BOOL)b{
    float height = [content sizeWithFont:ShowLabFont constrainedToSize:CGSizeMake(ShowLabWidth - 20, 100)].height;
    return (b ? height : (height + ShowLabTop * 2+10));
}




- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
