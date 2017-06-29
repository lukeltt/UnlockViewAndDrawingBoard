//
//  ColorView.h
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorView : UIView
@property(nonatomic,strong) void (^backBlock)();
@property(nonatomic,strong) void (^colorBlock)(UIButton * button);
-(void)showAnimation;
@end
