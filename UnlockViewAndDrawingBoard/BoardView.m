//
//  BoardView.m
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "BoardView.h"
#import "LineModel.h"

@interface BoardView ()
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) NSMutableArray *lineModels;
@end

@implementation BoardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        self.lineModels = [[NSMutableArray alloc]init];
    }
    return self;
}

// 绘图
- (void)drawRect:(CGRect)rect {
    for (LineModel * lineModel in self.lineModels) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, lineModel.path);
        CGContextSetStrokeColorWithColor(context, lineModel.color.CGColor);
        CGContextSetLineWidth(context, lineModel.lineWidth);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    if (self.path) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, self.path);
        CGContextSetStrokeColorWithColor(context, self.color.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextDrawPath(context, kCGPathStroke);
    }
}
// 开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = touches.anyObject;
    CGPoint  pt = [touch locationInView:touch.view];
    
    self.path = CGPathCreateMutable();
    CGPathMoveToPoint(self.path, NULL, pt.x, pt.y);
}
// 经过
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = touches.anyObject;
    CGPoint  pt = [touch locationInView:touch.view];
    
    CGPathAddLineToPoint(self.path, NULL, pt.x, pt.y);
    [self setNeedsDisplay];
}
// 结束
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LineModel *lineModel = [[LineModel alloc]init];
    lineModel.path = CGPathCreateMutableCopy(self.path);
    lineModel.color = self.color;
    lineModel.lineWidth = self.lineWidth;
    [self.lineModels addObject:lineModel];
    
    CGPathRelease(self.path);
    self.path = nil;
}

// 回退
-(void)undo{
    if (self.lineModels.count>0) {
        [self.lineModels removeLastObject];
        [self setNeedsDisplay];
    }
}

// 清屏
-(void)clear{
    if (self.lineModels.count>0) {
        [self.lineModels removeAllObjects];
        [self setNeedsDisplay];
    }
}
@end
