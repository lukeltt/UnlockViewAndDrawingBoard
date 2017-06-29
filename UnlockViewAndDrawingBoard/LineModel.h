//
//  LineModel.h
//  UnlockViewAndDrawingBoard
//
//  Created by luke on 2017/6/28.
//  Copyright © 2017年 luke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LineModel : NSObject
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) UIColor * color;
@property (nonatomic,assign) CGFloat lineWidth;
@end
