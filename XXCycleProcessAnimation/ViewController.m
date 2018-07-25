//
//  ViewController.m
//  XXCycleProcessAnimation
//
//  Created by 人人 on 2018/7/25.
//  Copyright © 2018年 shine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CAShapeLayer *_shapeLayer;
    UIBezierPath *_path;
    CGFloat _progress;
    CADisplayLink *_displayLink;
    UIImageView *_arrow;
    BOOL isShowArrowAnima;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isShowArrowAnima = false;
    
    _progress = 0;
    
    _path = [[UIBezierPath alloc] init];
    //线宽
    _path.lineWidth = 4;
    //拐角
    _path.lineCapStyle = kCGLineCapRound;
    _path.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (100 - 4) * 0.5;
    //旋转角度
    CGFloat rotation = M_PI  * _progress;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [_path addArcWithCenter:(CGPoint){100 * 0.5, 100 * 0.5} radius:radius startAngle:-M_PI endAngle: -M_PI + rotation clockwise:YES];
    _shapeLayer = [CAShapeLayer layer];
    
    _shapeLayer.path = _path.CGPath;
    _shapeLayer.frame = CGRectMake(100, 100, 100, 100);
    _shapeLayer.fillColor = nil;
    _shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    [self.view.layer addSublayer:_shapeLayer];
    
    _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(100 - 4, 150 - 4, 8, 8)];
    _arrow.center = CGPointMake(100 - 4, 150 - 4);
    _arrow.image = [UIImage imageNamed:@"arrow"];
    [self.view addSubview:_arrow];
    
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(progress)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)progress{
    _progress += 0.3/60;
    
    //半径
    CGFloat radius = (100 - 4) * 0.5;
    //旋转角度
    CGFloat rotation = M_PI  * _progress;
    [_path removeAllPoints];
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [_path addArcWithCenter:(CGPoint){100 * 0.5, 100 * 0.5} radius:radius startAngle:-M_PI  endAngle: -M_PI + rotation clockwise:YES];
    _shapeLayer.path = _path.CGPath;
    
    //根据角度算箭头位置, 求出圆周上的点
    _arrow.transform = CGAffineTransformMakeRotation(rotation);
    _arrow.center = CGPointMake(150 - radius * cos(rotation) , 150 - radius * sin(rotation));
    
    if (_progress >= 1.0) {
        _progress = 0;
    }
}
@end

