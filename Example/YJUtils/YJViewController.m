//
//  YJViewController.m
//  YJUtils
//
//  Created by lyj on 08/13/2019.
//  Copyright (c) 2019 lyj. All rights reserved.
//

#import "YJViewController.h"
#import <YJUtils/YJAudioPlayer.h>

@interface YJViewController ()<YJAudioPlayerDelegate>
@property (nonatomic,strong) YJAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLab;
@property (weak, nonatomic) IBOutlet UIProgressView *playProgressView;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLab;
@property (weak, nonatomic) IBOutlet UIProgressView *bufProgressView;
@end

@implementation YJViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    NSString *urlStr = @"http:/192.168.129.129:10145/CoursewareResFile/bktea5/eabed9c81eed492f86877b518dbd66cf/res/0/1/f8a7660cbc854e199cde7100eb94527e/data.mp3";
    self.audioPlayer = [[YJAudioPlayer alloc] init];
    self.audioPlayer.delegate = self;
    self.audioPlayer.audioUrl = urlStr;
}
- (IBAction)play:(id)sender {
    [self.audioPlayer play];
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
    
    
    self.playProgressView.progress = progress;
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
@end
