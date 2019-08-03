//
//  XYPopupViewTools.m
//  XYPopupViewToolsDemo
//
//  Created by 4AM_Xiao on 2019/8/1.
//  Copyright © 2019 com.ios. All rights reserved.
//

#import "XYPopupViewTools.h"

static dispatch_once_t              onceToken;

static XYPopupViewTools             *_popupView;        // 遮罩
static UIView                       *_fromView;         // 显示在此视图上
static UIView                       *_targetView;       // 显示的视图
static XYAnimationStyle             _showAnimStyle;     // 显示动画类型
static XYAnimationStyle             _hideAnimStyle;     // 隐藏动画类型
static BOOL                         _maskClick;         // 蒙版点击
static XYMaskSType                  _maskStyle;         // 遮罩类型
static XYTargetShowStyle            _showStyle;         // 显示类型
static completedBlock               _completed;          // 成功block
static CGFloat                      _maskAlpha;

static BOOL                         _hasPopupView;      // 遮罩是否已经显示的判断值

static UIColor                      *_backColor;        // 背景色

@implementation XYPopupViewTools

+ (instancetype)sharedManager
{
    _hasPopupView = YES;
    dispatch_once(&onceToken, ^{
        _popupView = [[XYPopupViewTools alloc]init];
    });
    return _popupView;
}

+ (void)popupTopWithTargetView:(UIView *)targetView maskClick:(BOOL)maskClick  maskAlpha:(CGFloat)maskAlpha
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel = UIWindowLevelAlert;
    [self popupTopWithFrom:window targetView:targetView maskAlpha:(CGFloat)maskAlpha showAnima:XYAnimationStyleTop hideAnima:XYAnimationStyleTop maskClick:maskClick];
}

+ (void)popupTopWithFrom:(UIView *)fromView targetView:(UIView *)targetView maskAlpha:(CGFloat)maskAlpha showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskClick:(BOOL)maskClick
{
    [self popupViewWithFrom:fromView targetView:targetView maskStyle:XYMaskSTypeAlpha  maskAlpha:(CGFloat)maskAlpha showStyle:XYTargetShowStyleTop showAnima:showAnimaStyle hideAnima:hideAnimaStyle maskCanClick:maskClick completed:^{
        
    }];
}

+ (void)popupCenterWithTargetView:(UIView *)targetView maskClick:(BOOL)maskClick  maskAlpha:(CGFloat)maskAlpha
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel = UIWindowLevelAlert;
    [self popupCenterWithFrom:window targetView:targetView maskAlpha:(CGFloat)maskAlpha showAnima:XYAnimationStyleCenter hideAnima:XYAnimationStyleCenter maskClick:maskClick];
}

+ (void)popupCenterWithFrom:(UIView *)fromView targetView:(UIView *)targetView maskAlpha:(CGFloat)maskAlpha showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskClick:(BOOL)maskClick
{
    [self popupViewWithFrom:fromView targetView:targetView maskStyle:XYMaskSTypeAlpha maskAlpha:(CGFloat)maskAlpha showStyle:XYTargetShowStyleCenter showAnima:showAnimaStyle hideAnima:hideAnimaStyle maskCanClick:maskClick completed:^{
        
    }];
}

+ (void)popupBottomWithTargetView:(UIView *)targetView maskClick:(BOOL)maskClick maskAlpha:(CGFloat)maskAlpha
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel = UIWindowLevelAlert;
    [self popupBottomWithFrom:window targetView:targetView maskAlpha:(CGFloat)maskAlpha showAnima:XYAnimationStyleBottom hideAnima:XYAnimationStyleBottom maskClick:maskClick];
}

+ (void)popupBottomWithFrom:(UIView *)fromView targetView:(UIView *)targetView maskAlpha:(CGFloat)maskAlpha showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskClick:(BOOL)maskClick
{
    [self popupViewWithFrom:fromView targetView:targetView maskStyle:XYMaskSTypeAlpha maskAlpha:(CGFloat)maskAlpha showStyle:XYTargetShowStyleBottom showAnima:showAnimaStyle hideAnima:hideAnimaStyle maskCanClick:maskClick completed:^{
        
    }];
}

+ (void)popupViewWithFrom:(UIView *)fromView targetView:(UIView *)targetView maskStyle:(XYMaskSType)maskStyle maskAlpha:(CGFloat)maskAlpha showStyle:(XYTargetShowStyle)showStyle showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskCanClick:(BOOL)maskClick completed:(nonnull completedBlock)completed
{
    if ([self hadPopupView]) {return;}
    _fromView = fromView;
    _targetView = targetView;
    _maskStyle = maskStyle;
    _maskAlpha = maskAlpha;
    _maskClick = maskClick;
    _showStyle = showStyle;
    _showAnimStyle = showAnimaStyle;
    _hideAnimStyle = hideAnimaStyle;
    _completed = completed;
    
    XYPopupViewTools *popupView = [self sharedManager];
    popupView.frame = _fromView.bounds;
    [fromView addSubview:popupView];
    _popupView = popupView;
    
    switch (maskStyle) {
        case XYMaskSTypeAlpha:
            [self setupMaskAlphaWithFrom:popupView];
            break;
        case XYMaskSTypeBlur:
            [self setupMaskBlurWithFrom:popupView];
            break;
        default:
            break;
    }
    [self showPopupView];
}

#pragma mark - 私有配置
//普通透明
+ (void)setupMaskAlphaWithFrom:(UIView*)fromView
{
    fromView.alpha = _maskAlpha?_maskAlpha:kAlpha;
    fromView.backgroundColor = _backColor?_backColor:[UIColor blackColor];
    [self setupMaskClickWithFrom:fromView];
}

//高斯模糊
+ (void)setupMaskBlurWithFrom:(UIView*)fromView
{
    fromView.backgroundColor = [UIColor clearColor];
    [self setupMaskClickWithFrom:fromView];
    // 添加高斯模糊效果,添加毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = fromView.bounds;
    fromView.alpha = _maskAlpha?_maskAlpha:kAlpha;
    [fromView addSubview:effectview];
}

+ (void)setupMaskClickWithFrom:(UIView*)fromView
{
    if (_maskClick) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopupView)];
        [fromView addGestureRecognizer:tap];
    }
}

//
+ (BOOL)hadPopupView
{
    return _hasPopupView;
}

+ (void)showPopupView
{
    [_fromView addSubview:_targetView];
    switch (_showStyle) {
        case XYTargetShowStyleTop:
            _targetView.centerX = _fromView.centerX;
            if (_showAnimStyle == XYAnimationStyleTop) {
                _targetView.y = -_targetView.height;
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.y = 0;
                } completion:^(BOOL finished) {
                    _completed?_completed():nil;
                }];
            }else{
                _targetView.y = 0;
                _completed?_completed():nil;
            }
            break;
        case XYTargetShowStyleCenter:
            _targetView.centerX = _fromView.centerX;
            if (_showAnimStyle == XYAnimationStyleTop) {
                _targetView.y = -_targetView.height;
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.center = _fromView.center;
                } completion:^(BOOL finished) {
                    _completed?_completed():nil;
                }];
            }else
            if (_showAnimStyle == XYAnimationStyleCenter){
                _targetView.centerY = _fromView.centerY;
                _targetView.hidden = YES;
                [UIView animateWithDuration:kAnimDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    _targetView.hidden = NO;
                } completion:^(BOOL finished) {
                    _completed?_completed():nil;
                }];
            }else
            if (_showAnimStyle == XYAnimationStyleBottom){
                _targetView.y = _fromView.height;
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.center = _fromView.center;
                } completion:^(BOOL finished) {
                    _completed?_completed():nil;
                }];
            }else{
                _targetView.center = _fromView.center;
                _completed?_completed():nil;
            }
            break;
        case XYTargetShowStyleBottom:
            _targetView.centerX = _fromView.centerX;
            if (_showAnimStyle == XYAnimationStyleBottom) {
                _targetView.y = _fromView.height;
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.y = _fromView.height-_targetView.height;
                } completion:^(BOOL finished) {
                    _completed?_completed():nil;
                }];
            }else{
                _targetView.y = _fromView.height-_targetView.height;
                _completed?_completed():nil;
            }
            break;
        default:
            break;
    }
}

+ (void)hidePopupView
{
    _hasPopupView = NO;
    switch (_showStyle) {
        case XYTargetShowStyleTop:
            if (_showAnimStyle == XYAnimationStyleTop) {
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.y = -_targetView.height;
                } completion:^(BOOL finished) {
                    [self removed];
                }];
            }
            break;
        case XYTargetShowStyleCenter:
            if (_showAnimStyle == XYAnimationStyleTop) {
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.y = -_targetView.height;
                } completion:^(BOOL finished) {
                    [self removed];
                }];
            }else
            if (_showAnimStyle == XYAnimationStyleCenter){
                [UIView animateWithDuration:kAnimDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    _targetView.hidden = YES;
                } completion:^(BOOL finished) {
                    [self removed];
                }];
            }else
            if (_showAnimStyle == XYAnimationStyleBottom){
                [UIView animateWithDuration:kAnimDuration animations:^{
                    _targetView.y = _fromView.height;
                } completion:^(BOOL finished) {
                    [self removed];
                }];
            }else{
                _targetView.center = _fromView.center;
                [self removed];
            }
            break;
        case XYTargetShowStyleBottom:
            [UIView animateWithDuration:kAnimDuration animations:^{
                _targetView.y = _fromView.height;
            } completion:^(BOOL finished) {
                [self removed];
            }];
            break;
        default:
            break;
    }
}

+ (void)removed
{
    onceToken = 0;
    [_popupView removeFromSuperview];
    [_targetView removeFromSuperview];
    
    _popupView       = nil;
    _fromView        = nil;
    _targetView      = nil;
    
}

@end
