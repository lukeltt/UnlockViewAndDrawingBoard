//
//  ColorView.m
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "ColorView.h"

@interface ColorView ()
@property(nonatomic,strong) UIView * bottomView;
@property(nonatomic,strong) NSArray * colors;
@property(nonatomic,strong) NSMutableArray * colorButtons;
@end


@implementation ColorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.colors = [[NSArray alloc]init];
        self.colorButtons = [[NSMutableArray alloc]init];
        [self initColors];
    }
    return self;
}

// 初始化颜色按钮
-(void)initColors{
    self.colors = @[[UIColor redColor],
                    [UIColor orangeColor],
                    [UIColor yellowColor],
                    [UIColor greenColor],
                    [UIColor blueColor],
                    [UIColor purpleColor],
                    [UIColor lightGrayColor],
                    [UIColor grayColor],
                    [UIColor darkGrayColor],
                    [UIColor blackColor]
                    ];
    
    for (int i=0; i<self.colors.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(7+i%5*(70+12.5), 10+i/5*(50+5), 70, 50)];
        button.backgroundColor = self.colors[i];
        [button addTarget:self action:@selector(colorButtonsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.colorButtons addObject:button];
        [self.bottomView addSubview:button];
        if (i == self.colors.count-1) {
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 4;
        }
    }
}
-(void)colorButtonsAction:(UIButton *)button{
    NSUInteger num1 = [self.colorButtons indexOfObject:button];
    for (UIButton * btn in self.colorButtons) {
        NSUInteger num2 = [self.colorButtons indexOfObject:btn];
        if (num1 == num2) {
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
            btn.layer.borderWidth = 4;
        }else{
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 0;
        }
    }
    
    if (self.colorBlock) {
        self.colorBlock(button);
    }
}

// 初始化颜色view
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 125)];
        _bottomView.backgroundColor = [UIColor cyanColor];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

// 显示动画
-(void)showAnimation{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, -125);
    }];
}

// 隐藏动画
-(void)hideAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, 125);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

// 触摸隐藏
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideAnimation];
    if (self.backBlock) {
        self.backBlock();
    }
}
@end
