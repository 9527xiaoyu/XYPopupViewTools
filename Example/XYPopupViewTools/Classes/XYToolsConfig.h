//
//  XYToolsConfig.h
//  XYPopupViewToolsDemo
//
//  Created by 4AM_Xiao on 2019/8/1.
//  Copyright © 2019 com.ios. All rights reserved.
//

#ifndef XYToolsConfig_h
#define XYToolsConfig_h

#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height

//动画时长
#define kAnimDuration 0.2
//默认透明度
#define kAlpha 0.6

//蒙版透明度
typedef NS_ENUM(NSUInteger,XYMaskSType) {
    XYMaskSTypeAlpha = 0,//透明度
    XYMaskSTypeBlur,//高斯模糊
};

//目标显示模式
typedef NS_ENUM(NSUInteger,XYTargetShowStyle){
    /*屏幕上方*/
    XYTargetShowStyleTop = 10,
    /*屏幕中央*/
    XYTargetShowStyleCenter,
    /*屏幕下方*/
    XYTargetShowStyleBottom,
    /*屏幕左侧*/
    XYTargetShowStyleLeft,
    /*屏幕右侧*/
    XYTargetShowStyleRight,
};

//展示动画样式
typedef NS_ENUM(NSUInteger,XYAnimationStyle){
    /*无动画*/
    XYAnimationStyleNone = 20,
    /*上方出现*/
    XYAnimationStyleTop,
    /*中央浮现*/
    XYAnimationStyleCenter,
    /*底部出现*/
    XYAnimationStyleBottom,
    /*左侧抽屉*/
    XYAnimationStyleLeft,
    /*右侧抽屉*/
    XYAnimationStyleRight,
};

#endif /* XYToolsConfig_h */
