//
//  UIView+Util.h
//  XYPopupViewToolsDemo
//
//  Created by 4AM_Xiao on 2019/8/1.
//  Copyright © 2019 com.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Util)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;

+ (instancetype)customViewFromXib;
@end

NS_ASSUME_NONNULL_END
