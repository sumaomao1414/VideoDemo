//
//  MPMoviePlayerController.m
//  VideoDemo
//
//  Created by maomao on 2018/5/26.
//  Copyright © 2018年 maomao. All rights reserved.
//

#import "TQMPMoviePlayerController.h"
#import <MediaPlayer/MediaPlayer.h>

//宽高的设置
#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

/**
 MPMoviePlayerController是iOS中进行视频播放开发的一个控制类，里面涵盖了视频播放中大部分的需求功能，在使用这个框架时，需要导入头文件<MediaPlayer/MediaPlayer.h>
 
 MPMoviePlayerController具备一般的播放器控制功能，例如播放、暂停、停止等。但是MPMediaPlayerController自身并不是一个完整的视图控制器，如果要在UI中展示视频需要将view属性添加到界面中。
 
 扩充MPMoviePlayerViewController：其实MPMoviePlayerController如果不作为嵌入视频来播放（例如在新闻中嵌入一个视频），通常在播放时都是占满一个屏幕的，特别是在iPhone、iTouch上。因此从iOS3.2以后苹果也在思考既然MPMoviePlayerController在使用时通常都是将其视图view添加到另外一个视图控制器中作为子视图，那么何不直接创建一个控制器视图内部创建一个MPMoviePlayerController属性并且默认全屏播放，开发者在开发的时候直接使用这个视图控制器。这个内部有一个MPMoviePlayerController的视图控制器就是MPMoviePlayerViewController，它继承于UIViewController。MPMoviePlayerViewController内部多了一个moviePlayer属性和一个带有url的初始化方法，同时它内部实现了一些作为模态视图展示所特有的功能，例如默认是全屏模式展示、弹出后自动播放、作为模态窗口展示时如果点击“Done”按钮会自动退出模态窗口等。
 
 */


@interface TQMPMoviePlayerController ()
{
    MPMoviePlayerController *mpPlayer;
}
@end

@implementation TQMPMoviePlayerController

- (IBAction)startVideo:(UIButton *)sender {
    [mpPlayer play];
}
- (IBAction)pauseVideo:(UIButton *)sender {
    [mpPlayer pause];
}
- (IBAction)stopVideo:(UIButton *)sender {
    [mpPlayer stop];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [mpPlayer stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MPMoviePlayerController";
    
    //网络
    //mpPlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
    
    //本地
    NSString* _moviePath= @"/Users/maomao/Desktop/day by day/VideoDemo/VideoDemo/123456.mp4";
    mpPlayer=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:_moviePath]];
    mpPlayer.movieSourceType = MPMovieSourceTypeFile;
    
    //直播
//    NSURL* url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
//    mpPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    mpPlayer.movieSourceType=MPMovieSourceTypeStreaming;
//
   
    
    [self.view addSubview:mpPlayer.view];
    
    mpPlayer.view.frame = CGRectMake(0, 50, WIDTH, 350);
    
    [mpPlayer play];
    
    //监听状态
    
    //监听视频播放结束
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //监听当前视频播放状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];

    
    //详细更多参数：
    //https://blog.csdn.net/qq_29892943/article/details/60960525
}

#pragma mark - Notification function

-(void)endPlay
{
    NSLog(@"播放结束");
}

-(void)loadStateDidChange:(NSNotification*)sender
{
    switch (mpPlayer.loadState) {
        case MPMovieLoadStatePlayable:
        {
            NSLog(@"加载完成,可以播放");
        }
            break;
        case MPMovieLoadStatePlaythroughOK:
        {
            NSLog(@"缓冲完成，可以连续播放");
        }
            break;
        case MPMovieLoadStateStalled:
        {
            NSLog(@"缓冲中");
        }
            break;
        case MPMovieLoadStateUnknown:
        {
            NSLog(@"未知状态");
        }
            break;
        default:
            break;
    }
}

#pragma mark - dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
