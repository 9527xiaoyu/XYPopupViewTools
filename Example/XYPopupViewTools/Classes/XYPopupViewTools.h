//
//  XYPopupViewTools.h
//  XYPopupViewToolsDemo
//
//  Created by 4AM_Xiao on 2019/8/1.
//  Copyright © 2019 com.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYToolsConfig.h"
#import "UIView+Util.h"

typedef void(^completedBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface XYPopupViewTools : UIView

+ (instancetype)sharedManager;

//快速布局

/**标准顶层提示模式,不接受键盘输入
 **默认顶层显示，顶部出现/回收
 * @param targetView 目标视图
 * @param maskClick 蒙版点击
 */
+ (void)popupTopWithTargetView:(UIView *)targetView maskClick:(BOOL)maskClick  maskAlpha:(CGFloat)maskAlpha;

/**标准顶层提示模式
 **默认顶层显示，顶部出现/回收，动画可变
 * @param fromView 底层视图
 * @param targetView 目标视图
 * @param showAnimaStyle 显示动画类型
 * @param hideAnimaStyle 隐藏动画类型
 * @param maskClick 蒙版点击
 */
+ (void)popupTopWithFrom:(UIView*)fromView targetView:(UIView*)targetView  maskAlpha:(CGFloat)maskAlpha showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskClick:(BOOL)maskClick;


/**标准广告模式,不接受键盘输入
 **默认居中显示，中央浮现/潜藏
 * @param targetView 目标视图
 * @param maskClick 蒙版点击
 */
+ (void)popupCenterWithTargetView:(UIView*)targetView maskClick:(BOOL)maskClick  maskAlpha:(CGFloat)maskAlpha;

/**标准广告模式
 **默认居中显示，中央浮现/潜藏，动画可变
 * @param fromView 底层视图
 * @param targetView 目标视图
 * @param showAnimaStyle 显示动画类型
 * @param hideAnimaStyle 隐藏动画类型
 * @param maskClick 蒙版点击
 */
+ (void)popupCenterWithFrom:(UIView*)fromView targetView:(UIView*)targetView  maskAlpha:(CGFloat)maskAlpha showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskClick:(BOOL)maskClick;

/**标准底部菜单模式,不接受键盘输入
 **默认底部显示，底部显示/隐藏
 * @param targetView 目标视图
 * @param maskClick 蒙版点击
 */
+ (void)popupBottomWithTargetView:(UIView*)targetView maskClick:(BOOL)maskClick  maskAlpha:(CGFloat)maskAlpha;

/**标准底部菜单模式
 **默认底部显示，底部显示/隐藏,动画可变
* @param fromView 底层视图
* @param targetView 目标视图
 * @param showAnimaStyle 显示动画类型
 * @param hideAnimaStyle 隐藏动画类型
* @param maskClick 蒙版点击
*/
+ (void)popupBottomWithFrom:(UIView*)fromView targetView:(UIView*)targetView  maskAlpha:(CGFloat)maskAlpha showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskClick:(BOOL)maskClick;

/**全部参数，可自定义弹出式视图显示方式
 * @param fromView 底层视图
 * @param targetView 目标视图
 * @param maskStyle 蒙版类型
 * @param maskAlpha 蒙版透明度
 * @param showStyle 展示方式
 * @param showAnimaStyle 显示动画类型
 * @param hideAnimaStyle 隐藏动画类型
 * @param maskClick 蒙版可点击
 * @param completed 成功返回事件
 */

+ (void)popupViewWithFrom:(UIView*)fromView targetView:(UIView*)targetView maskStyle:(XYMaskSType)maskStyle maskAlpha:(CGFloat)maskAlpha showStyle:(XYTargetShowStyle)showStyle showAnima:(XYAnimationStyle)showAnimaStyle hideAnima:(XYAnimationStyle)hideAnimaStyle maskCanClick:(BOOL)maskClick completed:(completedBlock)completed;
@end

NS_ASSUME_NONNULL_END
