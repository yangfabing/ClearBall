//
//  AppDelegate.h
//  ClearBall
//
//  Created by 杨发兵 on 14-3-4.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class GameViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *viewContoller;
@property (nonatomic, strong) GameViewController *gameViewController;
@end
