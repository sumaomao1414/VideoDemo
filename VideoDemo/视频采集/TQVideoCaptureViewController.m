//
//  TQVideoCaptureViewController.m
//  VideoDemo
//
//  Created by maomao on 2018/5/26.
//  Copyright © 2018年 maomao. All rights reserved.
//

#import "TQVideoCaptureViewController.h"
#import "TQImagePicker.h"
#import "FMFileVideoController.h"
#import "FMWriteVideoController.h"

@interface TQVideoCaptureViewController ()

@end

@implementation TQVideoCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"视频采集";
    
}

- (IBAction)imagePicker:(id)sender {
    TQImagePicker *picker = [[TQImagePicker alloc] init];
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)fileOutput:(id)sender {
    FMFileVideoController *fileVC = [[FMFileVideoController alloc] init];
    UINavigationController *NAV = [[UINavigationController alloc] initWithRootViewController:fileVC];
    [self presentViewController:NAV animated:YES completion:nil];
}

- (IBAction)assetWriter:(id)sender {
    FMWriteVideoController *writeVC = [[FMWriteVideoController alloc] init];
    UINavigationController *NAV = [[UINavigationController alloc] initWithRootViewController:writeVC];
    [self presentViewController:NAV animated:YES completion:nil];
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
