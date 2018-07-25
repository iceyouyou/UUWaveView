//
//  WaveViewEx.m
//  UUWaveViewDemo
//
//  Created by youyou on 2017/5/2.
//  Copyright © 2017年 iceyouyou. All rights reserved.
//

#import "UUWaveView.h"

@interface UUWaveView ()

@property (nonatomic, strong) NSMutableArray<UUWave*> *waves;
@property (nonatomic, assign) CGFloat maxWaveAmplitude;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL doUpdate;

@end

@implementation UUWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.layer.sublayers.count > 0) {
        [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
            layer.frame = self.bounds;
        }];
        [_waves enumerateObjectsUsingBlock:^(UUWave * _Nonnull wave, NSUInteger idx, BOOL * _Nonnull stop) {
            if (wave.layer) {
                wave.layer.frame = self.bounds;
            }
        }];
        [self drawOnce];
    }
}

- (void)dealloc {
    [self stop];
}

- (void)clear {
    [_waves makeObjectsPerformSelector:@selector(clearLayer)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)addWaves:(NSArray*)waves {
    if (_waves) {
        [_waves removeAllObjects];
        [_waves addObjectsFromArray:waves];
    } else {
        self.waves = [NSMutableArray arrayWithArray:waves];
    }
    [self createWaveLayer];
    [self drawOnce];
}

- (void)createWaveLayer {
    [_waves enumerateObjectsUsingBlock:^(UUWave * _Nonnull wave, NSUInteger idx, BOOL * _Nonnull stop) {
        self.maxWaveAmplitude = MAX(wave.amplitude + wave.lineWidth, self.maxWaveAmplitude);
        [self.layer addSublayer:[wave createLayerWithFrame:self.bounds]];
    }];
}

- (void)start {
    if (!_displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:[UUWaveWeakProxy proxyWithTarget:self] selector:@selector(drawWave:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stop {
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)reset {
    [_waves enumerateObjectsUsingBlock:^(UUWave * _Nonnull wave, NSUInteger idx, BOOL * _Nonnull stop) {
        if (wave.layer) {
            wave.moveX = 0.0f;
        }
    }];
    [self drawOnce];
}

- (void)drawWave:(CADisplayLink *)displayLink {
    self.doUpdate = !_doUpdate;
    if (!_doUpdate) {
        // 隔帧绘制(每隔一帧CPU占用降低一半，移动速度降低一半)
        return;
    }

    [_waves enumerateObjectsUsingBlock:^(UUWave * _Nonnull wave, NSUInteger idx, BOOL * _Nonnull stop) {
        if (wave.layer) {
            [wave moveOneStep];
            wave.layer.path = [self createWavePath:wave.style
                                         direction:wave.direction
                                         amplitude:wave.amplitude
                                             width:wave.width
                                         lineWidth:wave.lineWidth
                                           offsetX:wave.offsetX
                                             moveX:wave.moveX
                                           offsetY:self.maxWaveAmplitude].CGPath;
        }
    }];
}

- (void)drawOnce {
    [_waves enumerateObjectsUsingBlock:^(UUWave * _Nonnull wave, NSUInteger idx, BOOL * _Nonnull stop) {
        if (wave.layer) {
            wave.layer.path = [self createWavePath:wave.style
                                         direction:wave.direction
                                         amplitude:wave.amplitude
                                             width:wave.width
                                         lineWidth:wave.lineWidth
                                           offsetX:wave.offsetX
                                             moveX:wave.moveX
                                           offsetY:self.maxWaveAmplitude].CGPath;
        }
    }];
}

/*
 * 绘制正弦或余弦曲线的UIBezierPath（因为CALayer以左上角为坐标原点，所以实际绘制出的Sin、Cos曲线都是上下翻转的）
 *
 * 正弦曲线公式：
 * y = Asin(ωx + φ) + k
 * A - 振幅，即波峰的高度
 * (ωx + φ) - 相位，反应变量y所处的状态
 * ω - 角速度，控制正弦周期（单位角度内震动的次数）
 * φ - 初相，x=0时的相位，反映在坐标系上则为图像的左右移动
 * k - 偏距，反映在坐标系上则为图像的上移或下移
 *
 * 波形左移或右移：
 * y=Asin(ωx+φ)，先变形公式为：y=Asin(ω(x+φ/ω))
 * 右移m角度：y=Asin(ω(x+φ/ω-m))
 * 左移m角度：y=Asin(ω(x+φ/ω+m))
 */
- (UIBezierPath *)createWavePath:(UUWaveStyle)style
                       direction:(UUWaveDirection)direction
                       amplitude:(CGFloat)amplitude
                           width:(CGFloat)width
                       lineWidth:(CGFloat)lineWidth
                         offsetX:(CGFloat)offsetX
                           moveX:(CGFloat)moveX
                         offsetY:(CGFloat)offsetY {
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat viewWidth = CGRectGetWidth(self.bounds) + lineWidth * 0.5f;
    CGFloat endX = 0.0f;
    for (CGFloat x = 0.0f; x <= viewWidth;) {
        CGFloat y = 0.0f;
        if (style == UUWaveStyleSin) {
            if (direction == UUWaveDirectionLeft) {
                y = amplitude * sinf((2 * M_PI / width) * (x + offsetX / (2 * M_PI / width) + moveX)) + offsetY;
            } else {
                y = amplitude * sinf((2 * M_PI / width) * (x + offsetX / (2 * M_PI / width) - moveX)) + offsetY;
            }
        } else {
            if (direction == UUWaveDirectionLeft) {
                y = amplitude * cosf((2 * M_PI / width) * (x + offsetX / (2 * M_PI / width) + moveX)) + offsetY;
            } else {
                y = amplitude * cosf((2 * M_PI / width) * (x + offsetX / (2 * M_PI / width) - moveX)) + offsetY;
            }
        }

        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }

        endX = x;

        if (x == viewWidth) {
            break;
        } else {
            x = MIN(x + 10.0f, viewWidth); // 隔点绘制，降低CPU占用
        }
    }

    CGFloat endY = CGRectGetHeight(self.bounds) + lineWidth * 0.5f;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0.0f, endY)];

    return wavePath;
}

@end

#pragma mark - UUWave
@interface UUWave ()

@property (nonatomic, copy) CALayer* (^layerCreator)(CAShapeLayer *waveLayer);

@end

@implementation UUWave

- (instancetype)initWithStyle:(UUWaveStyle)style
                    direction:(UUWaveDirection)direction
                    amplitude:(CGFloat)amplitude
                        width:(CGFloat)width
                    lineWidth:(CGFloat)lineWidth
                      offsetX:(CGFloat)offsetX
                        stepX:(CGFloat)stepX
                 layerCreator:(CALayer* (^)(CAShapeLayer *waveLayer))layerCreator {
    if (self = [super init]) {
        _style = style;
        _direction = direction;
        _amplitude = amplitude;
        _width = width;
        _lineWidth = lineWidth;
        _offsetX = offsetX;
        _stepX = stepX;
        _layerCreator = layerCreator;
    }
    return self;
}

- (CALayer*)createLayerWithFrame:(CGRect)frame {
    self.layer = [CAShapeLayer layer];
    _layer.frame = frame;
    _layer.lineWidth = _lineWidth;

    if (_layerCreator) {
        CALayer *layer = _layerCreator(_layer);
        if (layer) {
            return layer;
        }
    }
    return _layer;
}

- (void)moveOneStep {
    self.moveX = ((int)(_moveX * 10.0f + _stepX * 10.0f) % (int)(_width * 10.0f)) / 10.0f;
}

- (void)clearLayer {
    [_layer removeFromSuperlayer];
    _layer = nil;
}

@end

#pragma mark - UUWaveWeakProxy(Private)
@interface UUWaveWeakProxy ()

@property (nonatomic, weak, readonly) id target;

@end

@implementation UUWaveWeakProxy

+ (instancetype)proxyWithTarget:(id)target {
    return [[UUWaveWeakProxy alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

@end
