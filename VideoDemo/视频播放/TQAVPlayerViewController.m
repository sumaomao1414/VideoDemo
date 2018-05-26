//
//  TQAVPlayerViewController.m
//  VideoDemo
//
//  Created by maomao on 2018/5/26.
//  Copyright © 2018年 maomao. All rights reserved.
//

#import "TQAVPlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

/**
    AVPlayerViewController,iOS8之后新的一个视频播放类，在AVKit框架中 跟MPMoviePlayerViewController一样是一个视图控制器类，但他内部通过与AVPlayer搭配来实现播放视频
 
 
    AVPlayerViewController提供了默认的可视化控制界面，要使用AVPlayerViewController需导入AVKit.h。
 
    AVPlayerViewController整合了一个完整的播放器，可以作为控制器进行操作显示。
 
    AVPlayerViewController可以支持播放本地及网络视频文件，支持的视频编码格式很有限：H.264、MPEG-4，扩展名（压缩格式）：.mp4、.mov、.m4v、.m2v、.3gp、.3g2等，如果是RMVB就不行了，需要借助第三方的框架来实现更多格式的支持
 
    常用属性
    player：设置播放器
 
    showsPlaybackControls：设置是否显示媒体播放组件，默认YES
 
    videoGravity：设置视频拉伸模式
 
    allowsPictureInPicturePlayback：设置是否允许画中画回放，默认YES
 
    delegate：设置代理
 */

@interface TQAVPlayerViewController ()
{
    AVPlayerViewController *avPalyer;
}
@end

@implementation TQAVPlayerViewController

- (IBAction)playVideo:(id)sender {

    [self presentViewController:avPalyer animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [avPalyer.player pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"TQAVPlayerViewController";
    
    avPalyer = [[AVPlayerViewController alloc]init];
    
    avPalyer.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
    
    avPalyer.view.frame = CGRectMake(0, 64, self.view.frame.size.width, 400);
    
    [self.view addSubview:avPalyer.view];
    
    [avPalyer.player play];

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
