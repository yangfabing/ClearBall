//
//  GameViewController.m
//  ClearBall
//
//  Created by 杨发兵 on 14-3-4.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import "GameViewController.h"
#import "Ball.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *tempArray = @[@1, @2, @3, @4, @5, @6, @7];
    [self installBallsWithNumArray:tempArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - 
#pragma mark - Custom Methods

-(void)installBallsWithNumArray:(NSArray *)array;
{
    //行，从上到下
    int startYPosition = WidthToTop;
    for (int line = 0; line < 7; line++) {
        //每行球的个数
        int ballCount = [array[line] intValue];
        int startXPosition = 0;
        if (line%2 == 0) {
            startXPosition = UIScreenWidth/2 - BallWidth/2 - ((ballCount - 1)/2)*BallWidth;
        }else
        {
            startXPosition = UIScreenWidth/2 - (ballCount/2)*BallWidth;

        }
        
        //开始初始化球的位置
        for (int count = 0; count < ballCount; count++) {
            int num = arc4random()%9 + 1;
            Ball *ball = [[Ball alloc] initWithBallNum:num andXYPosition:CGPointMake(count, line)];
            [ball setFrame:CGRectMake(startXPosition + count*BallWidth, startYPosition + line*(BallHeight - 10), ball.frame.size.width, ball.frame.size.height)];
            NSLog(@"ball origin:%@",NSStringFromCGPoint(ball.frame.origin));
            [self.view addSubview:ball];
        }
        
    }
}
@end
