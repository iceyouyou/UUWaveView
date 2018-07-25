//
//  UUWaveView.h
//  UUWaveViewDemo
//
//  Created by youyou on 2017/5/2.
//  Copyright © 2017年 iceyouyou. All rights reserved.
//

#import <UIKit/UIKit.h>

// 波形效果View
#pragma mark - UUWaveView
@interface UUWaveView : UIView

- (void)start;                      // 开始动画
- (void)stop;                       // 停止动画
- (void)reset;                      // 波形复位
- (void)addWaves:(NSArray*)waves;   // 添加波形线条

@end

#pragma mark - UUWaveStyle
typedef NS_ENUM(NSInteger, UUWaveStyle) {
    UUWaveStyleSin,         // 正弦曲线波形
    UUWaveStyleCos          // 余弦曲线波形
};

#pragma mark - UUWaveDirection
typedef NS_ENUM(NSInteger, UUWaveDirection) {
    UUWaveDirectionLeft,    // 波形左移
    UUWaveDirectionRight    // 波形右移
};

#pragma mark - UUWave
@interface UUWave : NSObject

@property (nonatomic, strong) CAShapeLayer *layer;          // 用于绘制波形的Layer
@property (nonatomic, assign) UUWaveStyle style;            // 波形类型：正弦/余弦
@property (nonatomic, assign) UUWaveDirection direction;    // 波形移动的方向
@property (nonatomic, assign) CGFloat width;                // 波形一个周期对应的x轴宽度
@property (nonatomic, assign) CGFloat amplitude;            // 波形振幅
@property (nonatomic, assign) CGFloat lineWidth;            // 波形线条宽度
@property (nonatomic, assign) CGFloat offsetX;              // 波形x轴偏移量
@property (nonatomic, assign) CGFloat stepX;                // 波形移动的步进值（影响波形传播速度）
@property (nonatomic, assign) CGFloat moveX;                // 波形传递时的当前x轴位置

- (instancetype)initWithStyle:(UUWaveStyle)style
                    direction:(UUWaveDirection)direction
                    amplitude:(CGFloat)amplitude
                        width:(CGFloat)width
                    lineWidth:(CGFloat)lineWidth
                      offsetX:(CGFloat)offsetX
                        stepX:(CGFloat)stepX
                 layerCreator:(CALayer* (^)(CAShapeLayer *waveLayer))layerCreator;
- (CALayer*)createLayerWithFrame:(CGRect)frame;
- (void)moveOneStep;
- (void)clearLayer;

@end

#pragma mark - UUWaveWeakProxy(Private)
@interface UUWaveWeakProxy : NSObject

+ (instancetype)proxyWithTarget:(id)target;

@end
