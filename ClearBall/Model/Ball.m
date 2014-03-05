//
//  Ball.m
//  ClearBall
//
//  Created by 杨发兵 on 14-3-4.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import "Ball.h"

@interface Ball ()
{
    UILabel *numLabel;
}

@end

@implementation Ball

-(id)initWithBallNum:(int)num andXYPosition:(CGPoint)xy
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, BallWidth, BallHeight);
        self.ballNum = num;
        self.xyPosition = xy;
        self.ballImage = [[UIImageView alloc] initWithFrame:self.frame];
//        CGFloat red = arc4random()%255;
//        CGFloat green = arc4random()%255;
//        CGFloat blue = arc4random()%255;
//
//        [self.ballImage setBackgroundColor:[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1]];
        
        [self.ballImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ball_%d.png",num]]];
        
        numLabel = [[UILabel alloc] initWithFrame:self.frame];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.center = self.center;
        [numLabel setFont:[UIFont systemFontOfSize:14]];
        numLabel.text = [NSString stringWithFormat:@"%d",self.ballNum];
        
        [self addSubview:_ballImage];
        [self addSubview:numLabel];
    }
    
    return self;
}
@end
