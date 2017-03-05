//
//  TYRecorderAnimationView.m
//  TYRecorderAnimation
//
//  Created by thomasTY on 15/11/20.
//  Copyright © 2015年 滕佳超. All rights reserved.
//

#import "TYRecorderAnimationView.h"

@interface TYRecorderAnimationView()
@property(nonatomic,strong)CALayer * micLayer;
@end

@implementation TYRecorderAnimationView
{
    //宽高
    CGFloat _height;
    CGFloat _scaleW;
    CGFloat _scaleMidW;
    //话筒
    CGFloat _micW;
    CGFloat _micH;
    CGFloat _micLineW;
    CGFloat _micCornerR;
    //弧线
    CGFloat _arcR;
    CGFloat _arcLineW;
    CGFloat _arcCenterX;
    CGFloat _arcCenterY;
    //弧线上接线
    CGFloat _arcTopLineH;
    CGFloat _arcTopLeftLineX;
    CGFloat _arcTopRightLineX;
    CGFloat _arcTopLineStartY;
    CGFloat _arcTopLineEndY;
    //弧线下竖线
    CGFloat _arcBottomVerLineH;
    CGFloat _arcBottomVerLineX;
    CGFloat _arcBottomVerLineStartY;
    CGFloat _arcBottomVerLineEndY;
    //弧线下横线
    CGFloat _arcBottomHorLineW;
    CGFloat _arcBottomHorLineStartX;
    CGFloat _arcBottomHorLineEndX;
    CGFloat _arcBottomHorLineY;
    
    CGRect _frame;
    UIColor * _themeColor;
    NSTimeInterval _timeDuration;
}

-(instancetype)initWithFrameX:(CGFloat)x frameY:(CGFloat)y height:(CGFloat)height themeColor:(UIColor *)themeColor frequency:(NSTimeInterval)timeInterval
{
    CGRect frame = CGRectMake(x, y, 2/3.0 *height, height);
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUIWithFrame:frame themeColor:themeColor frequency:timeInterval];
    }
    return self;
}

+(instancetype)recorderWithFrameX:(CGFloat)x frameY:(CGFloat)y height:(CGFloat)height themeColor:(UIColor *)themeColor frequency:(NSTimeInterval)timeInterval
{
    return [[self alloc] initWithFrameX:x frameY:y height:height themeColor:themeColor frequency:timeInterval];
}

- (void)setupUIWithFrame:(CGRect)frame themeColor:(UIColor *)themeColor frequency:(NSTimeInterval)timeInterval
{
    self.backgroundColor = [UIColor clearColor];

    _height = self.frame.size.height;
    _scaleW = 2/3.0 * _height;
    _scaleMidW = 0.5 * _scaleW;
    
    
    _micW = _scaleMidW;
    _micH = 0.7 * _height;
    _micLineW = 2.0;
    _micCornerR = 0.5 * _micW;
    
    _arcLineW = 0.1 * _scaleW;
    _arcR = 1.8 * _micCornerR;
    _arcCenterY = _micH-_micCornerR;
    
    _arcTopLineH = _micCornerR;
    _arcTopLineStartY = _arcCenterY;
    _arcTopLineEndY = _arcCenterY - _arcTopLineH;
    _arcTopLeftLineX = _scaleMidW - _arcR;
    _arcTopRightLineX = _scaleMidW + _arcR;
    
    _arcBottomVerLineH = 0.1 * _height;
    _arcBottomVerLineX = _scaleMidW;
    _arcBottomVerLineStartY = _arcCenterY + _arcR;
    _arcBottomVerLineEndY = _arcBottomVerLineStartY + _arcBottomVerLineH;
    
    _arcBottomHorLineW = 3.0 * _micCornerR;
    _arcBottomHorLineStartX = 1/2.0 * (_scaleW - _arcBottomHorLineW);
    _arcBottomHorLineEndX = _arcBottomHorLineStartX + _arcBottomHorLineW;
    _arcBottomHorLineY = _arcBottomVerLineEndY + 0.5*_arcLineW;
    
    _themeColor = themeColor;
    _timeDuration = timeInterval;
}

-(void)refreshUIWithSoundVolume : (CGFloat)soundVolume
{
    CAShapeLayer * indicateLayer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.5 * _micW, _micH)];
    [path addLineToPoint:CGPointMake(0.5 * _micW, 0)];
    
    indicateLayer.path = path.CGPath;
    indicateLayer.lineWidth = _micW;
    indicateLayer.strokeColor = _themeColor.CGColor;
    
    [_micLayer addSublayer:indicateLayer];
    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    anim.fromValue = @(0);
    anim.toValue = @(soundVolume);
    
    anim.duration = _timeDuration;
    [anim setAutoreverses:YES];
    
    anim.removedOnCompletion = NO;
    anim.fillMode = @"forwards";
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [indicateLayer addAnimation:anim forKey:nil];
}
-(void)drawRect:(CGRect)rect
{
    //话筒边框
    _micLayer = [CALayer new];
    _micLayer.frame = CGRectMake(_scaleMidW - 0.5*_micW, 0, _micW, _micH);
    _micLayer.masksToBounds = YES;
    _micLayer.cornerRadius = _micCornerR;
    _micLayer.borderWidth = _micLineW;
    _micLayer.borderColor = _themeColor.CGColor;
    [self.layer addSublayer:_micLayer];
    //弧线
    UIBezierPath * path_arc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_scaleMidW,_arcCenterY) radius:_arcR startAngle:0 endAngle:2.0*M_PI_2 clockwise:YES];
    path_arc.lineWidth = _arcLineW;
    path_arc.lineCapStyle = kCGLineCapButt;
    [_themeColor setStroke];
    [path_arc stroke];
    //弧线上左竖线
    [self strokeALineWithStartPoint:CGPointMake(_arcTopLeftLineX, _arcTopLineStartY) endPoint:CGPointMake(_arcTopLeftLineX, _arcTopLineEndY)];
    //弧线上右竖线
    [self strokeALineWithStartPoint:CGPointMake(_arcTopRightLineX, _arcTopLineStartY) endPoint:CGPointMake(_arcTopRightLineX, _arcTopLineEndY)];
    //弧线下竖线
    [self strokeALineWithStartPoint:CGPointMake(_arcBottomVerLineX, _arcBottomVerLineStartY) endPoint:CGPointMake(_arcBottomVerLineX, _arcBottomVerLineEndY)];
    //弧线下横线
    [self strokeALineWithStartPoint:CGPointMake(_arcBottomHorLineStartX, _arcBottomHorLineY) endPoint:CGPointMake(_arcBottomHorLineEndX, _arcBottomHorLineY)];
}

- (void)strokeALineWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    path.lineWidth = _arcLineW;
    path.lineCapStyle = kCGLineCapRound;
    [_themeColor setStroke];
    [path stroke];
}

@end
