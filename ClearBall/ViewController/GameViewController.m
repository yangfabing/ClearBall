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
{
    //能被移除的数字（3个数字）
    int canRemoveNum0;
    int canRemoveNum;
    int canRemoveNum2;
}

//二维数组
@property (nonatomic, strong) NSMutableArray *ballArray;
//能被移除的小球
@property (nonatomic, strong) Ball *canRemoveBall;

@property (weak, nonatomic) IBOutlet UIButton *replaceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pillarImageView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel0;
@property (weak, nonatomic) IBOutlet UILabel *numLabel1;
@property (weak, nonatomic) IBOutlet UILabel *numLabel2;

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
        NSMutableArray *lineArray = [NSMutableArray array];
        for (int count = 0; count < ballCount; count++) {
            int num = arc4random()%9 + 1;
            Ball *ball = [[Ball alloc] initWithBallNum:num andXYPosition:CGPointMake(count, line)];
            [ball setFrame:CGRectMake(startXPosition + count*BallWidth, startYPosition + line*(BallHeight - 10), ball.frame.size.width, ball.frame.size.height)];
            
            [lineArray addObject:ball];
//            NSLog(@"ball origin:%@",NSStringFromCGPoint(ball.frame.origin));
            [self.view addSubview:ball];
        }
        if (!self.ballArray) {
            self.ballArray = [NSMutableArray arrayWithCapacity:30];
        }
        [self.ballArray addObject:lineArray];

    }
}


//通过球在二维数组中得位置来判断是否能被移除
-(BOOL)checkBallCanRemove:(Ball *)ball
{
//    int x = (int)ball.xyPosition.x;
    int y = (int)ball.xyPosition.y;
    
//如果是最下面一行球的话,就直接判断是否是可以被移除的数字
    if (y != 6) {
        NSArray *lineArray = self.ballArray[y+1];
        for (id obj in lineArray) {
            Ball *tempBall = (Ball *)obj;
            if (tempBall && CGRectIntersectsRect(ball.frame, tempBall.frame)){
                return NO;
            }
        }
    }
    if (ball.ballNum == canRemoveNum0 || ball.ballNum == canRemoveNum || ball.ballNum == canRemoveNum2) {
        return YES;
    }

    

    return NO;
}

//通过选择的一个数字来确定能移除的3个数字
-(void)confirmRemoveNums:(int)num
{
//    NSLog(@"selected num--->%d",num);
    canRemoveNum = num;
    canRemoveNum0 = (num - 1) > 0?(num - 1):9;
    canRemoveNum2 = (num + 1) < 10?(num + 1):1;
    if (self.canRemoveBall) {
        [self.canRemoveBall removeFromSuperview];
    }
    self.canRemoveBall = [[Ball alloc] initWithBallNum:canRemoveNum andXYPosition:CGPointMake(0, 0)];
    [self.canRemoveBall setFrame:CGRectMake(self.replaceBtn.frame.origin.x, self.replaceBtn.frame.origin.y, BallWidth, BallHeight)];
    [self.view addSubview:self.canRemoveBall];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.canRemoveBall setFrame:CGRectMake( self.pillarImageView.frame.origin.x, self.pillarImageView.frame.origin.y + 8 - BallHeight, BallWidth, BallHeight)];
    }completion:^(BOOL finished) {
        
    }];
    
    self.numLabel0.text = [NSString stringWithFormat:@"%d",canRemoveNum0];
    self.numLabel1.text = [NSString stringWithFormat:@"%d",canRemoveNum];
    self.numLabel2.text = [NSString stringWithFormat:@"%d",canRemoveNum2];
}

#pragma mark-
#pragma mark- UITouch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    for (NSMutableArray *array in self.ballArray) {
        
        for (Ball *ball in array) {
            if (!ball) {
                return;
            }
            CGRect rect = ball.frame;
            //选中小球
            if (CGRectContainsPoint(rect, touchPoint)) {
                //判断小球是否被其他小球压住
                if ([self checkBallCanRemove:ball]) {
//                    NSLog(@"can remove:%@",NSStringFromCGPoint(ball.xyPosition));
                    [UIView animateWithDuration:0.5 animations:^{
                        [ball setAlpha:0];
                    }completion:^(BOOL finish){
                        [array removeObject:ball];
                        [ball removeFromSuperview];
                    }];
                    
                    [self confirmRemoveNums:ball.ballNum];
                }
                return;
            }
        }

    }
}


#pragma mark - 
#pragma mark - Action
- (IBAction)replaceBall:(id)sender {
    
     canRemoveNum = arc4random()%9 + 1;
    [self confirmRemoveNums:canRemoveNum];
}
@end
