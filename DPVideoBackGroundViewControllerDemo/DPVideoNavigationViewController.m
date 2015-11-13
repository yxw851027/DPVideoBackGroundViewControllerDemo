//
//  DPVideoNavigationViewController.m
//  DuoPai
//
//  Created by yxw on 15/7/9.
//  Copyright (c) 2015年 Jacky. All rights reserved.
//

#import "DPVideoNavigationViewController.h"
#import "DPMoviePlayerView.h"

@interface DPVideoNavigationViewController ()
@property (nonatomic, strong) DPMoviePlayerView *playView;
@end

@implementation DPVideoNavigationViewController
@synthesize playView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupPlayView];
}

- (void)setupPlayView
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];
    NSDictionary *opts = [[NSDictionary alloc] initWithObjectsAndKeys:@YES, AVURLAssetPreferPreciseDurationAndTimingKey, nil];
    AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:url options:opts];
    playView = [[DPMoviePlayerView alloc] initWithFrame:[self.view bounds] asset:urlAsset];
    playView.repeats = YES;
    playView.muted = YES;
    [self.view insertSubview:playView atIndex:0];
}

- (void)playIntroduceVideo
{
    [playView playOrResume];
}

- (void)stopIntroduceVideo
{
    [playView pause];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self playIntroduceVideo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIntroduceVideo) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playIntroduceVideo) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopIntroduceVideo];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (UIInterfaceOrientationPortrait == toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [playView stop];
    [playView setDelegate:nil];
    playView = nil;
}

@end
