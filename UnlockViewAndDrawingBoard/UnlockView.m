//
//  UnlockView.m
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/27.
//  Copyright © 2017年 luke. All rights reserved.
//

#import "UnlockView.h"
#import "NodeView.h"

@interface UnlockView()

@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) NSMutableArray * nodeViews;
@property (nonatomic,strong) NSMutableArray * throughNodeViews;
@property (nonatomic,assign) BOOL isValidateGesture;
@property (nonatomic,strong) NSMutableString * secret;

@end

@implementation UnlockView

// 自定义init
-(instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor cyanColor];
        self.nodeViews = [[NSMutableArray alloc]init];
        self.throughNodeViews = [[NSMutableArray alloc]init];
        self.secret = [[NSMutableString alloc]init];
        [self initNodeViews];
    }
    return self;
}

// 设置手势点数组
-(void)initNodeViews{
    CGFloat x = self.frame.size.width/4;
    CGFloat startY = (self.frame.size.height-self.frame.size.width)/2;
    CGFloat y = x;
    
    for (int i=0; i<9; i++) {
        NodeView * node = [[NodeView alloc]init];
        node.userInteractionEnabled = NO;
        node.center = CGPointMake((i%3+1)*x, startY+(i/3+1)*y);
        node.bounds = CGRectMake(0, 0, 50, 50);
        node.layer.cornerRadius = 25;
        node.backgroundColor = [UIColor blackColor];
        node.number = [NSString stringWithFormat:@"%d",i+1];
        [self addSubview:node];
        [self.nodeViews addObject:node];
    }
}

// 判断点是否落入手势点中
-(NodeView *)throughNodeViewsByPoint:(CGPoint)pt{
    NodeView * nodeview;
    for (NodeView * node in self.nodeViews) {
        CGRect rect = node.frame;
        if (CGRectContainsPoint(rect, pt)) {
            nodeview = node;
            break;
        }
    }
    return nodeview;
}

// 画线
- (void)drawRect:(CGRect)rect {
    if (self.path) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, self.path);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 5);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

// 开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = touches.anyObject;
    CGPoint pt = [touch locationInView:touch.view];
    
    NodeView * nodeView = [self throughNodeViewsByPoint:pt];
    if (nodeView) {
        self.isValidateGesture = YES;
        self.path = CGPathCreateMutable();
        CGPathMoveToPoint(self.path, NULL, nodeView.center.x, nodeView.center.y);
        [self.throughNodeViews addObject:nodeView];
        [self.secret appendString:nodeView.number];
    }
}

// 经过
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (! self.isValidateGesture) {
        return;
    }
    
    UITouch * touch = touches.anyObject;
    CGPoint pt = [touch locationInView:touch.view];
    
    NodeView * nodeView = [self throughNodeViewsByPoint:pt];
    if (nodeView) {
        if (! [self.throughNodeViews containsObject:nodeView]) {
            CGPathAddLineToPoint(self.path, NULL, nodeView.center.x, nodeView.center.y);
            [self setNeedsDisplay];
            [self.throughNodeViews addObject:nodeView];
            [self.secret appendString:nodeView.number];
        }
    }
}

// 结束
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (! self.isValidateGesture) {
        return;
    }
    
    CGPathRelease(self.path);
    self.path = nil;
    
    [self checkSecret];
}

// 密码校验
-(void)checkSecret{
    BOOL isRight = NO;
    if ([self.secret isEqualToString:@"14789"]) {
        isRight = YES;
    }
    if (self.MyBlock) {
        self.MyBlock(self, isRight);
    }
}

// 重置
-(void)reset{
    [self.throughNodeViews removeAllObjects];
    self.isValidateGesture = NO;
    [self.secret setString:@""];
    [self setNeedsDisplay];
}
@end
