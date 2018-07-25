//
//  ViewController.m
//  UUWaveViewDemo
//
//  Created by Ye Yang on 2018/7/24.
//  Copyright © 2018年 iceyouyou. All rights reserved.
//

#import "ViewController.h"
#import "UUWaveView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *firstWaveViewBg;
@property (nonatomic, strong) UUWaveView *firstWaveView;

@property (nonatomic, strong) UIView *secondWaveViewBg;
@property (nonatomic, strong) UUWaveView *secondWaveView;

@property (nonatomic, strong) UIView *thirdWaveViewBg;
@property (nonatomic, strong) UUWaveView *thirdWaveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self nothingImportant];

    // Demo 1
    UUWave *firstWave1 = [[UUWave alloc] initWithStyle:UUWaveStyleSin
                                             direction:UUWaveDirectionRight
                                             amplitude:5.0f
                                                 width:CGRectGetWidth(_firstWaveViewBg.bounds) * 1.5f
                                             lineWidth:2.0f
                                               offsetX:CGRectGetWidth(_firstWaveViewBg.bounds) * 1.5f * 0.5f
                                                 stepX:0.6f
                                          layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                              waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                              waveLayer.fillColor = [UIColor colorWithRed:(118.0f / 255.0f) green:(214.0f / 255.0f) blue:(255.0f / 255.0f) alpha:0.5f].CGColor;
                                              waveLayer.strokeColor = [UIColor clearColor].CGColor;
                                              return waveLayer;
                                          }];
    UUWave *firstWave2 = [[UUWave alloc] initWithStyle:UUWaveStyleSin
                                             direction:UUWaveDirectionLeft
                                             amplitude:10.0f
                                                 width:CGRectGetWidth(_firstWaveViewBg.bounds) * 1.5f
                                             lineWidth:2.0f
                                               offsetX:0.0f
                                                 stepX:1.2f
                                          layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                              waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                              waveLayer.fillColor = [UIColor colorWithRed:(118.0f / 255.0f) green:(214.0f / 255.0f) blue:(255.0f / 255.0f) alpha:1.0f].CGColor;
                                              waveLayer.strokeColor = [UIColor clearColor].CGColor;
                                              return waveLayer;
                                          }];
    _firstWaveView = [[UUWaveView alloc] initWithFrame:CGRectMake(0.0f, 45.0f, CGRectGetWidth(_firstWaveViewBg.bounds), 55.0f)];
    [_firstWaveView addWaves:@[firstWave1, firstWave2]];
    [_firstWaveViewBg addSubview:_firstWaveView];

    // Demo 2
    UUWave *secondWave1 = [[UUWave alloc] initWithStyle:UUWaveStyleSin
                                              direction:UUWaveDirectionRight
                                              amplitude:20.0f
                                                  width:CGRectGetWidth(_secondWaveViewBg.bounds)
                                              lineWidth:1.0f
                                                offsetX:0.0f
                                                  stepX:1.2f
                                           layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                               waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                               waveLayer.fillColor = [UIColor clearColor].CGColor;
                                               waveLayer.strokeColor = [UIColor whiteColor].CGColor;
                                               return waveLayer;
                                           }];
    UUWave *secondWave2 = [[UUWave alloc] initWithStyle:UUWaveStyleCos
                                              direction:UUWaveDirectionLeft
                                              amplitude:20.0f
                                                  width:CGRectGetWidth(_secondWaveViewBg.bounds)
                                              lineWidth:1.0f
                                                offsetX:0.0f
                                                  stepX:1.2f
                                           layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                               waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                               waveLayer.fillColor = [UIColor clearColor].CGColor;
                                               waveLayer.strokeColor = [UIColor whiteColor].CGColor;
                                               return waveLayer;
                                           }];
    _secondWaveView = [[UUWaveView alloc] initWithFrame:CGRectMake(0.0f, 35.0f, CGRectGetWidth(_secondWaveViewBg.bounds), 65.0f)];
    [_secondWaveView addWaves:@[secondWave1, secondWave2]];
    [_secondWaveViewBg addSubview:_secondWaveView];

    // Demo 3
    UUWave *thirdWave1 = [[UUWave alloc] initWithStyle:UUWaveStyleCos
                                             direction:UUWaveDirectionLeft
                                             amplitude:16.0f
                                                 width:CGRectGetWidth(_thirdWaveViewBg.bounds)
                                             lineWidth:1.0f
                                               offsetX:CGRectGetWidth(_thirdWaveViewBg.bounds) * 0.5f
                                                 stepX:1.2f
                                          layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                              waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                              waveLayer.fillColor = [UIColor whiteColor].CGColor;

                                              CAGradientLayer *gradientLayer = [CAGradientLayer layer];
                                              gradientLayer.frame = waveLayer.bounds;
                                              [gradientLayer setColors:@[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor,
                                                                         (id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor,
                                                                         (id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor]];
                                              [gradientLayer setLocations:@[@0.1, @0.6, @1.0]];
                                              [gradientLayer setStartPoint:CGPointMake(0.5f, 1.0f)];
                                              [gradientLayer setEndPoint:CGPointMake(0.5f, 0.0f)];
                                              [gradientLayer setMask:waveLayer];

                                              return gradientLayer;
                                          }];
    UUWave *thirdWave2 = [[UUWave alloc] initWithStyle:UUWaveStyleSin
                                             direction:UUWaveDirectionRight
                                             amplitude:16.0f
                                                 width:CGRectGetWidth(_thirdWaveViewBg.bounds)
                                             lineWidth:1.0f
                                               offsetX:CGRectGetWidth(_thirdWaveViewBg.bounds) * 0.25f
                                                 stepX:0.8f
                                          layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                              waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                              waveLayer.fillColor = [UIColor whiteColor].CGColor;

                                              CAGradientLayer *gradientLayer = [CAGradientLayer layer];
                                              gradientLayer.frame = waveLayer.bounds;
                                              [gradientLayer setColors:@[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor,
                                                                         (id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor,
                                                                         (id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor]];
                                              [gradientLayer setLocations:@[@0.1, @0.6, @1.0]];
                                              [gradientLayer setStartPoint:CGPointMake(0.5f, 1.0f)];
                                              [gradientLayer setEndPoint:CGPointMake(0.5f, 0.0f)];
                                              [gradientLayer setMask:waveLayer];

                                              return gradientLayer;
                                          }];
    UUWave *thirdWave3 = [[UUWave alloc] initWithStyle:UUWaveStyleCos
                                             direction:UUWaveDirectionLeft
                                             amplitude:16.0f
                                                 width:CGRectGetWidth(_thirdWaveViewBg.bounds)
                                             lineWidth:1.0f
                                               offsetX:CGRectGetWidth(_thirdWaveViewBg.bounds)
                                                 stepX:0.4f
                                          layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                                              waveLayer.backgroundColor = [UIColor clearColor].CGColor;
                                              waveLayer.fillColor = [UIColor whiteColor].CGColor;

                                              CAGradientLayer *gradientLayer = [CAGradientLayer layer];
                                              gradientLayer.frame = waveLayer.bounds;
                                              [gradientLayer setColors:@[(id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor,
                                                                         (id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor,
                                                                         (id)[[UIColor whiteColor] colorWithAlphaComponent:0.15f].CGColor]];
                                              [gradientLayer setLocations:@[@0.1, @0.6, @1.0]];
                                              [gradientLayer setStartPoint:CGPointMake(0.5f, 1.0f)];
                                              [gradientLayer setEndPoint:CGPointMake(0.5f, 0.0f)];
                                              [gradientLayer setMask:waveLayer];

                                              return gradientLayer;
                                          }];
    _thirdWaveView = [[UUWaveView alloc] initWithFrame:CGRectMake(0.0f, 35.0f, CGRectGetWidth(_thirdWaveViewBg.bounds), 65.0f)];
    [_thirdWaveView addWaves:@[thirdWave1, thirdWave2, thirdWave3]];
    [_thirdWaveViewBg addSubview:_thirdWaveView];
}

- (void)nothingImportant {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 40.0f, screenWidth - 40.0f, 20.0f)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"UUWaveView Demo";
    title.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:title];

    // first WaveView
    UILabel *firstWaveViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, screenWidth - 40.0f, 20.0f)];
    firstWaveViewTitle.text = @"Demo 1";
    firstWaveViewTitle.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:firstWaveViewTitle];

    _firstWaveViewBg = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 105.0f, screenWidth, 100.0f)];
    [self.view addSubview:_firstWaveViewBg];

    UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 205.0f, screenWidth, 1.0f)];
    firstLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstLine];

    // second WaveView
    UILabel *secondWaveViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 225.0f, screenWidth - 40.0f, 20.0f)];
    secondWaveViewTitle.text = @"Demo 2";
    secondWaveViewTitle.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:secondWaveViewTitle];

    _secondWaveViewBg = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 250.0f, screenWidth, 100.0f)];
    [self.view addSubview:_secondWaveViewBg];

    CAGradientLayer *secondWaveViewBgGradientLayer = [[CAGradientLayer alloc] init];
    secondWaveViewBgGradientLayer.frame = _secondWaveViewBg.bounds;
    secondWaveViewBgGradientLayer.startPoint = CGPointMake(1.0f, 0.5f);
    secondWaveViewBgGradientLayer.endPoint   = CGPointMake(0.0f, 0.5f);
    secondWaveViewBgGradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:(255.0f / 255.0f) green:(127.0f / 255.0f) blue:(115.0f / 255.0f) alpha:1.0f].CGColor,
                                             (__bridge id)[UIColor colorWithRed:(255.0f / 255.0f) green:(76.0f / 255.0f) blue:(59.0f / 255.0f) alpha:1.0f].CGColor];
    [_secondWaveViewBg.layer addSublayer:secondWaveViewBgGradientLayer];

    // third WaveView
    UILabel *thirdWaveViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 370.0f, screenWidth - 40.0f, 20.0f)];
    thirdWaveViewTitle.text = @"Demo 3";
    thirdWaveViewTitle.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:thirdWaveViewTitle];

    _thirdWaveViewBg = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 395.0f, screenWidth, 100.0f)];
    [self.view addSubview:_thirdWaveViewBg];

    CAGradientLayer *thirdWaveViewBgGradientLayer = [CAGradientLayer layer];
    thirdWaveViewBgGradientLayer.frame = _thirdWaveViewBg.bounds;
    [thirdWaveViewBgGradientLayer setColors:@[(id)[UIColor colorWithRed:(80.0f / 255.0f) green:(140.0f / 255.0f) blue:(238.0f / 255.0f) alpha:1.0f].CGColor,
                                              (id)[UIColor colorWithRed:(0.0f / 255.0f) green:(211.0f / 255.0f) blue:(151.0f / 255.0f) alpha:1.0f].CGColor]];
    [thirdWaveViewBgGradientLayer setStartPoint:CGPointMake(0.0f, 0.5f)];
    [thirdWaveViewBgGradientLayer setEndPoint:CGPointMake(1.0f, 0.5f)];
    [_thirdWaveViewBg.layer addSublayer:thirdWaveViewBgGradientLayer];

    // start button
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 515.0f, 50.0f, 20.0f)];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startBtn setTitle:@"Start" forState:UIControlStateNormal];
    startBtn.layer.cornerRadius = 4.0f;
    startBtn.layer.borderWidth = 1.0f;
    [self.view addSubview:startBtn];
    [startBtn addTarget:self action:@selector(handleStartAction:) forControlEvents:UIControlEventTouchUpInside];

    // stop button
    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(80.0f, 515.0f, 50.0f, 20.0f)];
    stopBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    stopBtn.layer.cornerRadius = 4.0f;
    stopBtn.layer.borderWidth = 1.0f;
    [self.view addSubview:stopBtn];
    [stopBtn addTarget:self action:@selector(handleStopAction:) forControlEvents:UIControlEventTouchUpInside];

    // reset button
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(140.0f, 515.0f, 50.0f, 20.0f)];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetBtn setTitle:@"Reset" forState:UIControlStateNormal];
    resetBtn.layer.cornerRadius = 4.0f;
    resetBtn.layer.borderWidth = 1.0f;
    [self.view addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(handleResetAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleStartAction:(id)sender {
    [_firstWaveView start];
    [_secondWaveView start];
    [_thirdWaveView start];
}

- (void)handleStopAction:(id)sender {
    [_firstWaveView stop];
    [_secondWaveView stop];
    [_thirdWaveView stop];
}

- (void)handleResetAction:(id)sender {
    [_firstWaveView reset];
    [_secondWaveView reset];
    [_thirdWaveView reset];
}

@end
