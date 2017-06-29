//
//  BoardViewController.m
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardView.h"
#import "ToolView.h"
#import "ColorView.h"

@interface BoardViewController ()
@property (nonatomic,strong) UIButton * backButton;
@property (nonatomic,strong) BoardView * board;
@property (nonatomic,strong) ToolView * tool;
@property (nonatomic,strong) ColorView * colorView;

@property(nonatomic,strong) UIColor * color;
@property(nonatomic,assign) CGFloat lineWidth;
@property(nonatomic,assign) BOOL isEraserMode;
@end

@implementation BoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.color = [UIColor blackColor];
    self.lineWidth = 5;
    
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.board];
    [self.view addSubview:self.tool];
    [self.view addSubview:self.colorView];
    
    [self toolViewBlock];
}

// 返回按钮
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height-40, 150, 30)];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
-(void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 初始化画板界面
-(BoardView *)board{
    if (!_board) {
        _board = [[BoardView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-400)/2, self.view.frame.size.height-600, 400, 550)];
        _board.color = [UIColor blackColor];
        _board.lineWidth = 5;
    }
    return _board;
}

// 初始化工具界面
-(ToolView *)tool{
    if (!_tool) {
        _tool = [[ToolView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-400)/2, 21, 400, 115)];
    }
    return _tool;
}

// 初始化颜色界面
-(ColorView *)colorView{
    if (!_colorView) {
        _colorView = [[ColorView alloc]initWithFrame:self.view.frame];
    }
    return _colorView;
}

//  工具界面按钮动作
-(void)toolViewBlock{
    self.tool.penBlcok = ^{
        self.isEraserMode = NO;
        self.board.color = self.color;
        self.board.lineWidth = self.lineWidth;
    };
    
    self.tool.colorBlcok = ^{
        [self.colorView showAnimation];
        self.backButton.hidden = YES;
    };
    self.colorView.backBlock = ^{
        self.backButton.hidden = NO;
    };
    self.colorView.colorBlock = ^(UIButton *button) {
        if (self.isEraserMode == NO) {
            self.board.color = button.backgroundColor;
        }
        self.color = button.backgroundColor;
    };
   
    self.tool.eraserBlcok = ^{
        self.isEraserMode = YES;
        self.board.color = [UIColor whiteColor];
        self.board.lineWidth = 20;
    };
    
    self.tool.undoBlcok = ^{
        [self.board undo];
    };
    
    self.tool.clearBlcok = ^{
        [self.board clear];
    };
    
    self.tool.sliderBlock = ^(UISlider *slider) {
        if (self.isEraserMode == NO) {
            self.board.lineWidth = slider.value;
        }
        self.lineWidth = slider.value;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
