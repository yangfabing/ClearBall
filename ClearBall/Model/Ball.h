//
//  Ball.h
//  ClearBall
//
//  Created by 杨发兵 on 14-3-4.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : UIView
//球的图片
@property (nonatomic, strong) UIImageView *ballImage;
//球的数字
@property (nonatomic, assign) int ballNum;
//标记是否被移除
@property (nonatomic, assign) BOOL isRemove;

//在二维数组中得位置
@property (nonatomic, assign) CGPoint xyPosition;

-(id)initWithBallNum:(int) num andXYPosition:(CGPoint)xy;

@end
