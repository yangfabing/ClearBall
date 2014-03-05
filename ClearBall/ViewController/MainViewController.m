//
//  MainViewController.m
//  ClearBall
//
//  Created by 杨发兵 on 14-3-4.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)start:(id)sender {
    GameViewController *controller =[[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
