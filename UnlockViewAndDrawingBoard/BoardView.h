//
//  BoardView.h
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView
@property(nonatomic,strong) UIColor * color;
@property(nonatomic,assign) CGFloat lineWidth;
-(void)undo;
-(void)clear;
@end
