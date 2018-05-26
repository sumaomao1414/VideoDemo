//
//  TQMPMoviePlayerViewController.m
//  VideoDemo
//
//  Created by maomao on 2018/5/26.
//  Copyright © 2018年 maomao. All rights reserved.
//

#import "TQMPMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TQMPMoviePlayerViewController ()
{
    MPMoviePlayerViewController *mpVcPlayer;
}
@end

@implementation TQMPMoviePlayerViewController

- (IBAction)playVideo:(UIButton *)sender {
    
    //MPMoviePlayerController 是继承制NSObect类的，
    //MPMoviePlayerViewController是继承制UIViewController，里面包含MPMoviePlayerController属性。
    //MPMoviePlayerController和MPMoviePlayerViewController 的使用需要引用库，MediaPlayer.framework库。
    
    self.title = @"TQMPMoviePlayerViewController";
    
    mpVcPlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
    [self presentViewController:mpVcPlayer animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
