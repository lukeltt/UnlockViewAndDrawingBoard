//
//  ToolView.h
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolView : UIView

@property(nonatomic,copy) void (^penBlcok)();
@property(nonatomic,copy) void (^colorBlcok)();
@property(nonatomic,copy) void (^eraserBlcok)();
@property(nonatomic,copy) void (^undoBlcok)();
@property(nonatomic,copy) void (^clearBlcok)();
@property(nonatomic,copy) void (^sliderBlock)(UISlider * slider);

@end
