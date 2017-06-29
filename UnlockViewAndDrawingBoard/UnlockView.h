//
//  UnlockView.h
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/27.
//  Copyright © 2017年 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnlockView : UIView
@property (nonatomic,copy) void(^MyBlock)(UnlockView *unlockView,BOOL sucess);
-(void)reset;
@end
