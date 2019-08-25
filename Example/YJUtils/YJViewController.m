//
//  YJViewController.m
//  YJUtils
//
//  Created by lyj on 08/13/2019.
//  Copyright (c) 2019 lyj. All rights reserved.
//

#import "YJViewController.h"
#import <YJUtils/YJAudioPlayer.h>
#import <YJUtils/YJAudioMerger.h>

@interface YJViewController ()<YJAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic,strong) YJAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLab;
@property (weak, nonatomic) IBOutlet UIProgressView *bufProgressView;

@property (nonatomic, assign) BOOL isSliderMoving;
@end

@implementation YJViewController

- (void)viewDidLoad{
    [super viewDidLoad];
   
}

- (YJAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        _audioPlayer = [[YJAudioPlayer alloc] init];
        _audioPlayer.delegate = self;
    }
    return _audioPlayer;
}
- (void)testAudioPlayer{
    
    NSString *urlStr = @"http://192.168.129.129:10148//lgftp/lgzyk/xl/Speaking/1/unit 3/unit 3.mp4";
    self.audioPlayer.audioUrl = urlStr;
    
    [self.slider addTarget:self action:@selector(sliderTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.slider addTarget:self action:@selector(sliderTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(sliderTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)testAudioMerger{
    NSString *audioPath1 = [[NSBundle mainBundle] pathForResource:@"Congratulations1" ofType:@"mp3"];
    NSString *audioPath2 = [[NSBundle mainBundle] pathForResource:@"keep_trying1" ofType:@"mp3"];
    NSString *audioPath3 = [[NSBundle mainBundle] pathForResource:@"三全音" ofType:@"mp3"];
    __weak typeof(self) weakSelf = self;
    [[YJAudioMerger shareAudioMerger] mergeMoreAudioWithPaths:@[audioPath1,audioPath2,audioPath3] completion:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.audioPlayer.audioUrl = [YJAudioMerger shareAudioMerger].outPutFilePath;
            [weakSelf.audioPlayer play];
        }
    }];
}

- (void)sliderTouchDown {
    _isSliderMoving = YES;
}

- (void)sliderTouchUpInside {
    _isSliderMoving = NO;
}

- (void)sliderTouchUpOutside {
    _isSliderMoving = NO;
}
- (void)sliderValueChanged:(UISlider *)sender{
    _isSliderMoving = NO;
    [self.audioPlayer seekToSecondTime:_audioPlayer.totalDuration * sender.value];
}
- (IBAction)play:(id)sender {
    [self testAudioMerger];
//    [self.audioPlayer play];
}

- (IBAction)playAmbient:(id)sender {
    [self.audioPlayer playAmbient];
}

- (IBAction)pause:(id)sender {
    [self.audioPlayer pause];
}
- (IBAction)stop:(id)sender {
    [self.audioPlayer stop];
}
- (IBAction)sliderVauleChange:(UISlider *)sender {
    NSTimeInterval time = sender.value * self.audioPlayer.totalDuration;
    [self.audioPlayer seekToSecondTime:time];
}

- (void)yj_audioPlayerReadyToPlay{
    NSLog(@"准备好了");
    NSInteger minute = (NSInteger)self.audioPlayer.totalDuration % (60*60) / 60;
    NSInteger second = (NSInteger)self.audioPlayer.totalDuration % (60*60) % 60;
    self.totalTimeLab.text = [NSString stringWithFormat:@"%02li:%02li",minute,second];
}

- (void)yj_audioPlayerCurrentPlaySeconds:(NSTimeInterval)seconds progress:(CGFloat)progress{
    NSInteger minute = (NSInteger)seconds % (60*60) / 60;
    NSInteger second = (NSInteger)seconds % (60*60) % 60;
    self.currentTimeLab.text = [NSString stringWithFormat:@"%02li:%02li",minute,second];
    
    
    if (!_isSliderMoving) {
        _slider.value = progress;
    }
}
- (void)yj_audioPlayerCurrentBufferSeconds:(NSTimeInterval)seconds progress:(CGFloat)progress{
    self.bufProgressView.progress = progress;
}
- (void)yj_audioPlayerBeginInterruption{
    [self.audioPlayer pause];
    NSLog(@"开始中断");
}
- (void)yj_audioPlayerEndInterruption{
    NSLog(@"结束中断");
}
- (void)yj_audioPlayerPlaybackBufferEmpty{
    NSLog(@"yj_audioPlayerPlaybackBufferEmpty");
}
- (void)yj_audioPlayerPlaybackLikelyToKeepUp{
    NSLog(@"yj_audioPlayerPlaybackLikelyToKeepUp");
}
@end
