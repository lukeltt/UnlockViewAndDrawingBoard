//
//  ToolView.m
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "ToolView.h"

#define width 70
#define height 50

@interface ToolView ()

@property (nonatomic,strong) UIButton * penButton;  
@property (nonatomic,strong) UIButton * colorButton;
@property (nonatomic,strong) UIButton * eraserButton;
@property (nonatomic,strong) UIButton * undoButton;
@property (nonatomic,strong) UIButton * clearButton;
@property (nonatomic,strong) UISlider * lineWidthSlider;
@property (nonatomic,strong) UILabel * lineWidthLabel;

@end


@implementation ToolView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.penButton];
        [self addSubview:self.colorButton];
        [self addSubview:self.eraserButton];
        [self addSubview:self.undoButton];
        [self addSubview:self.clearButton];
        [self addSubview:self.lineWidthSlider];
        [self addSubview:self.lineWidthLabel];
    }
    return self;
}

// 画笔按钮
-(UIButton *)penButton{
    if (!_penButton) {
        _penButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, width, height)];
        _penButton.backgroundColor = [UIColor orangeColor];
        [_penButton setTitle:@"画笔" forState:UIControlStateNormal];
        [_penButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_penButton addTarget:self action:@selector(penButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _penButton;
}
-(void)penButtonAction{
    if (self.penBlcok) {
        self.penBlcok();
    }
    [self.penButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.eraserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

// 颜色按钮
-(UIButton *)colorButton{
    if (!_colorBlcok) {
        _colorButton = [[UIButton alloc]initWithFrame:CGRectMake(70+12.5, 5, width, height)];
        _colorButton.backgroundColor = [UIColor orangeColor];
        [_colorButton setTitle:@"颜色" forState:UIControlStateNormal];
        [_colorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_colorButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_colorButton addTarget:self action:@selector(colorButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colorButton;
}
-(void)colorButtonAction{
    if (self.colorBlcok) {
        self.colorBlcok();
    }
}

// 橡皮按钮
-(UIButton *)eraserButton{
    if (!_eraserButton) {
        _eraserButton = [[UIButton alloc]initWithFrame:CGRectMake((70+12.5)*2, 5, width, height)];
        _eraserButton.backgroundColor = [UIColor orangeColor];
        [_eraserButton setTitle:@"橡皮" forState:UIControlStateNormal];
        [_eraserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_eraserButton addTarget:self action:@selector(eraserButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eraserButton;
}
-(void)eraserButtonAction{
    if (self.eraserBlcok) {
        self.eraserBlcok();
    }
    [self.eraserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.penButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

// 回退按钮
-(UIButton *)undoButton{
    if (!_undoButton) {
        _undoButton = [[UIButton alloc]initWithFrame:CGRectMake((70+12.5)*3, 5, width, height)];
        _undoButton.backgroundColor = [UIColor orangeColor];
        [_undoButton setTitle:@"回退" forState:UIControlStateNormal];
        [_undoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_undoButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_undoButton addTarget:self action:@selector(undoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _undoButton;
}
-(void)undoButtonAction{
    if (self.undoBlcok) {
        self.undoBlcok();
    }
}

// 清屏按钮
-(UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc]initWithFrame:CGRectMake((70+12.5)*4, 5, width, height)];
        _clearButton.backgroundColor = [UIColor orangeColor];
        [_clearButton setTitle:@"清屏" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}
-(void)clearButtonAction{
    if (self.clearBlcok) {
        self.clearBlcok();
    }
}

// 线宽滑动条
-(UISlider *)lineWidthSlider{
    if (!_lineWidthSlider) {
        _lineWidthSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 60, 152.5, 50)];
        _lineWidthSlider.minimumValue = 1;
        _lineWidthSlider.maximumValue = 10;
        _lineWidthSlider.value = 5;
        [_lineWidthSlider addTarget:self action:@selector(lineWidthSliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _lineWidthSlider;
}
-(void)lineWidthSliderAction:(UISlider *)slider{
    if (self.sliderBlock) {
        self.lineWidthLabel.text = [NSString stringWithFormat:@"%.0f",slider.value];
        self.sliderBlock(slider);
    }
}

// 线宽标签
-(UILabel *)lineWidthLabel{
    if (!_lineWidthLabel) {
        _lineWidthLabel = [[UILabel alloc]initWithFrame:CGRectMake(165, 60, 70, 50)];
        _lineWidthLabel.text = @"5";
        _lineWidthLabel.textColor = [UIColor orangeColor];
        _lineWidthLabel.font = [UIFont systemFontOfSize:25];
    }
    return _lineWidthLabel;
}

@end
