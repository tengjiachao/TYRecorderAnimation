//
//  TYRecorderAnimationView.h
//  TYRecorderAnimation
//
//  Created by thomasTY on 15/11/20.
//  Copyright © 2015年 滕佳超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYRecorderAnimationView : UIView

/**
 指定初始化方法

 @param x            x
 @param y            y
 @param height       高度，宽度自适应为高度2/3倍，不需要设置
 @param themeColor   主题色
 @param timeInterval 刷新频率，范围:0.0 ~ 10.0

 @return TYRecorderAnimationView对象
 */
-(instancetype)initWithFrameX:(CGFloat)x frameY:(CGFloat)y height:(CGFloat)height themeColor:(UIColor *)themeColor frequency:(NSTimeInterval)timeInterval;

/**
 指定初始化方法
 
 @param x            x
 @param y            y
 @param height       高度，宽度自适应为高度2/3倍，不需要设置
 @param themeColor   主题色
 @param timeInterval 刷新频率，范围:0.0 ~ 10.0
 
 @return TYRecorderAnimationView对象
 */
+(instancetype)recorderWithFrameX:(CGFloat)x frameY:(CGFloat)y height:(CGFloat)height themeColor:(UIColor *)themeColor frequency:(NSTimeInterval)timeInterval;

/**
 根据音量刷新指示器动画
 
 @param soundVolume  音量，范围：0.0 ~ 1.0
 */
-(void)refreshUIWithSoundVolume : (CGFloat)soundVolume ;
@end
