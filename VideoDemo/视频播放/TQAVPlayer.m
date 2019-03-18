//
//  AVPlayer.m
//  VideoDemo
//
//  Created by maomao on 2018/5/26.
//  Copyright © 2018年 maomao. All rights reserved.
//

#import "TQAVPlayer.h"
#import <AVFoundation/AVFoundation.h>

/**
 
 AVPlayer是一个可以播放任何格式的全功能影音播放器，使用AVPlayer需导入AVFoundation.h。
 VPlayer存在于AVFoundation中，它更加接近于底层，所以灵活性极高。
 AVPlayer本身并不能显示视频，如果AVPlayer要显示必须创建一个播放器图层AVPlayerLayer用于展示，该播放器图层继承于CALayer。
 
 支持视频格式： WMV，AVI，MKV，RMVB，RM，XVID，MP4，3GP，MPG等。
 
 支持音频格式：MP3，WMA，RM，ACC，OGG，APE，FLAC，FLV等。
 
 在开发中，单纯使用AVPlayer类是无法显示视频的，要将视频层添加至AVPlayerLayer中，这样才能将视频显示出来。
 
 AVPlayer并未提供视频操作组件，需用户自定义。
 */

@interface TQAVPlayer ()
{
    AVPlayer *player;
}

@property (strong, nonatomic)AVPlayerItem *playerItem;//播放单元
@property (strong, nonatomic)AVPlayerLayer *avplayerLayer;//播放界面（layer）

@property (strong, nonatomic)UISlider *avSlider;//用来现实视频的播放进度，并且通过它来控制视频的快进快退。
@property (assign, nonatomic)BOOL isReadToPlay;//用来判断当前视频是否准备好播放。

@end

@implementation TQAVPlayer

- (IBAction)playVideo:(id)sender {
    [self playAction];
}

- (IBAction)pauseVideo:(id)sender {
    [player pause];
}


/*
 * AVPlayer播放视频流程
 
 1、创建一个AVPlayerItem对象,每个AVPlayerItem对象，就是一个视频或音频
 
 2、将AVPlayerItem对象放到一个AVPlayer对象，AVPlayer对象负责视频的暂停与开启操作
 
 3、将AVPlayer放到一个AVPlayerLayer对象里，AVPlayerLayer负责视频的一个展示，他可以设置frame
 
 4、将AVPlayLayer放到某视图的layer层
 
 5、播放
 
 */

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [player pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"TQAVPlayer";
    //1
    //网络
    _playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://192.168.10.25:8086/upload/clueNotice/mp4/2018/8/2/16132245565.mp4"]];
    //http://192.168.10.25:8086/upload/clueNotice/mp4/2018/8/2/16132245565.mp4
    //http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
    //本地
//    NSString* _moviePath= @"/Users/maomao/Desktop/day by day/VideoDemo/VideoDemo/123456.mp4";
//    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:_moviePath]];
    
    //直播
    //AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"]];

    //2
    player = [[AVPlayer alloc]initWithPlayerItem:_playerItem];
    
    //3
    _avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    _avplayerLayer.frame = CGRectMake(0, 40, self.view.frame.size.width, 450);
    
    //4
    [self.view.layer addSublayer:_avplayerLayer];
    
    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.avSlider addTarget:self action:@selector(avSliderAction) forControlEvents:
     UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchUpOutside];
    
   
    
    //更多属性介绍
    //https://www.jianshu.com/p/746cec2c3759
}

- (void)playAction{
    if ( self.isReadToPlay) {
        [player play];
    }else{
        NSLog(@"视频正在加载中");
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                self.isReadToPlay = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                self.isReadToPlay = YES;
                self.avSlider.maximumValue = self.playerItem.duration.value / self.playerItem.duration.timescale;
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                self.isReadToPlay = NO;
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

- (void)avSliderAction{
    //slider的value值为视频的时间
    float seconds = self.avSlider.value;
    //让视频从指定的CMTime对象处播放。
    CMTime startTime = CMTimeMakeWithSeconds(seconds, self.playerItem.currentTime.timescale);
    //让视频从指定处播放
    [player seekToTime:startTime completionHandler:^(BOOL finished) {
        if (finished) {
            [self playAction];
        }
    }];
}

- (UISlider *)avSlider{
    if (!_avSlider) {
        _avSlider = [[UISlider alloc]initWithFrame:CGRectMake(40, 70, self.view.bounds.size.width-80, 30)];
        [self.view addSubview:_avSlider];
    }return _avSlider;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
