//
//  ViewController.m
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/27.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "ViewController.h"
#import "UnlockView.h"
#import "BoardViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UnlockView * unlock = [[UnlockView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:unlock];
    [unlock setNeedsDisplay];
    
    unlock.MyBlock = ^(UnlockView *unlockView,BOOL sucess) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"提示" message:sucess?@"解锁成功":@"解锁失败"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [unlockView reset];
            if (sucess) {
                BoardViewController * board = [[BoardViewController alloc]init];
                [self presentViewController:board animated:YES completion:nil];
            }
        }];
        
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
