//
//  DPLoginViewController.m
//  DuoPai
//
//  Created by yxw on 15/6/24.
//  Copyright (c) 2015年 Jacky. All rights reserved.
//

#import "DPLoginViewController.h"
#import "AppDelegate.h"

@interface DPLoginViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation DPLoginViewController
@synthesize contentView;
@synthesize accountTextField;
@synthesize passwordTextField;

#pragma mark - lifecycle
- (id)init
{
    if (self = [super init]) {
        [self setTitle:@"登录"];
    }
    return self;
}

- (void)viewDidLoad
{
    if (nil == contentView) {
        contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        [contentView setBackgroundColor:[UIColor clearColor]];
        
        [self setupLogoView];
        
        [self setupLoginViews];
        
        [self setupThirdPartyButtons];
    }
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:contentView];
}

- (void)setupLogoView
{
    CGFloat offsetY;
    if (iPhone4) {
        offsetY = 80.f/667.f * kScreenHeight;
    }else {
        offsetY = 100.f/667.f * kScreenHeight;
    }
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.contentMode = UIViewContentModeScaleAspectFill;
    logoView.image = [UIImage imageNamed:@"login_logo.png"];
    [contentView addSubview:logoView];
    
    [logoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.centerX.equalTo(contentView.centerX);
        make.width.equalTo(64);
        make.height.equalTo(64);
    }];
}

- (void)setupLoginViews
{
    CGFloat offsetY;
    if (iPhone4) {
        offsetY = 224.f/667.f * kScreenHeight;
    }else {
        offsetY = 274.f/667.f * kScreenHeight;
    }
    
    accountTextField = [[UITextField alloc] init];
    accountTextField.textAlignment = NSTextAlignmentLeft;
    accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountTextField.font = [UIFont systemFontOfSize:16];
    accountTextField.delegate = self;
    accountTextField.textColor = [UIColor whiteColor];
    accountTextField.autoresizesSubviews = YES;
    accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    accountTextField.tag = 0;
    accountTextField.returnKeyType = UIReturnKeyNext;
    accountTextField.keyboardType = UIKeyboardTypeEmailAddress;
    //accountTextField.placeholder = @"账号";
    accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"账号" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    accountTextField.adjustsFontSizeToFitWidth = YES;
    accountTextField.enablesReturnKeyAutomatically = YES;
    accountTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [contentView addSubview:accountTextField];
    [accountTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.centerX.equalTo(contentView.centerX);
        make.width.equalTo(contentView.width).multipliedBy(250.f/375.f);
        make.height.equalTo(32);
    }];
    
    UIView *lineView;
    UIColor *lineColor = [UIColor lightGrayColor];
    
    offsetY += (32 + 1);
    lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:lineColor];
    [contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.centerX.equalTo(contentView.centerX);
        make.width.equalTo(contentView.width).multipliedBy(250.f/375.f);
        make.height.equalTo(1);
    }];
    
    offsetY += 20;
    passwordTextField = [[UITextField alloc] init];
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.font = [UIFont systemFontOfSize:16];
    passwordTextField.delegate = self;
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.autoresizesSubviews = YES;
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTextField.tag = 1;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    //passwordTextField.placeholder = @"密码";
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.enablesReturnKeyAutomatically = YES;
    passwordTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [contentView addSubview:passwordTextField];
    [passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.centerX.equalTo(contentView.centerX);
        make.width.equalTo(contentView.width).multipliedBy(250.f/375.f);
        make.height.equalTo(32);
    }];
    
    offsetY += (32 + 1);
    lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:lineColor];
    [contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.centerX.equalTo(contentView.centerX);
        make.width.equalTo(contentView.width).multipliedBy(250.f/375.f);
        make.height.equalTo(1);
    }];
    
    //忘记密码按钮
    offsetY += 10;
    UIButton *retrieveButton = [[UIButton alloc] init];
    [retrieveButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [retrieveButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [retrieveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [retrieveButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [retrieveButton addTarget:self action:@selector(onResetPassword) forControlEvents:UIControlEventTouchUpInside];
    [retrieveButton setTag:1];
    [contentView addSubview:retrieveButton];
    [retrieveButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.right.equalTo(lineView.right);
        make.width.equalTo((60));
        make.height.equalTo(24);
    }];
    
    //登录按钮
    offsetY += (24 + 20);
    UIButton *loginButton = [[UIButton alloc] init];
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"login_btn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"login_btn_HL.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)] forState:UIControlStateHighlighted];
    [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [loginButton setTitleColor:UIColorFrom0xRGBA(0x1abc9c, 1.f) forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:loginButton];
    [loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.left.equalTo(lineView.left);
        make.right.equalTo(lineView.centerX).offset(-15);
        make.height.equalTo(36);
    }];
    
    //注册按钮
    UIButton *registerButton = [[UIButton alloc] init];
    [registerButton setBackgroundImage:[[UIImage imageNamed:@"register_btn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[[UIImage imageNamed:@"register_btn_HL.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7)] forState:UIControlStateHighlighted];
    [registerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:UIColorFrom0xRGBA(0x1abc9c, 1.f) forState:UIControlStateHighlighted];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(onRegister) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registerButton];
    [registerButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(offsetY);
        make.left.equalTo(lineView.centerX).offset(15);
        make.right.equalTo(lineView.right);
        make.height.equalTo(36);
    }];
}

- (void)setupThirdPartyButtons
{
    UILabel *tpLabel = [[UILabel alloc] init];
    tpLabel.backgroundColor = [UIColor clearColor];
    tpLabel.font = [UIFont systemFontOfSize:14];
    tpLabel.textColor = UIColorFrom0xRGBA(0xFFFFFF, 1.f);
    tpLabel.textAlignment = NSTextAlignmentCenter;
    tpLabel.text = @"第三方账号登录";
    [contentView addSubview:tpLabel];
    [tpLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.bottom).offset(-116);
        make.centerX.equalTo(contentView.centerX);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    UIView *lineView;
    lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:UIColorFrom0xRGBA(0xFFFFFF, 0xB2/255.f)];
    [contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.bottom).offset(-106);
        make.left.equalTo(contentView.left).offset(contentView.bounds.size.width*(((375.f - 250.f)/375.f)/2.f));
        make.right.equalTo(tpLabel.left).offset(-10);
        make.height.equalTo(1);
    }];
    
    lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:UIColorFrom0xRGBA(0xFFFFFF, 0xB2/255.f)];
    [contentView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.bottom).offset(-106);
        make.left.equalTo(tpLabel.right).offset(10);
        make.right.equalTo(contentView.right).offset(contentView.bounds.size.width*(-((375.f - 250.f)/375.f)/2.f));
        make.height.equalTo(1);
    }];
    
    int platformCount = 3;
    int tags[3] = { 0, 1, 2};
    
    const CGFloat padding = 40.f;
    const int contentWidth = kScreenWidth - padding * 2;
    const CGFloat unitWidth = contentWidth / (CGFloat)platformCount;
    const CGFloat buttonWidth = 64.f;
    NSString *normalImageNames[3] = { @"login_thirdparty_Weibo.png", @"login_thirdparty_QQ.png", @"login_thirdparty_Weixin.png"};
    NSString *highlightedImageNames[3] = { @"login_thirdparty_Weibo_HL.png", @"login_thirdparty_QQ_HL.png", @"login_thirdparty_Weixin_HL.png" };
    CGFloat x = (unitWidth - buttonWidth) / 2.f;
    
    for (int i = 0; i < platformCount; i++) {
        UIButton *button = [[UIButton alloc] init];
        const int tag = tags[i];
        [button setTag:tag];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [button setImage:[UIImage imageNamed:normalImageNames[tag]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:highlightedImageNames[tag]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(onThirdPartyLogin:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.bottom).offset(-(64.f + 24.f));
            make.left.equalTo(contentView.left).offset(x + padding);
            make.width.equalTo(buttonWidth);
            make.height.equalTo(buttonWidth);
        }];
        
        x += unitWidth;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
    self.view.alpha = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [accountTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    self.view.alpha = 0;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    contentView = nil;
    accountTextField = nil;
    passwordTextField = nil;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == accountTextField) {
        [passwordTextField becomeFirstResponder];
    } else if (textField == passwordTextField) {
        [self onLogin];
    }
    return YES;
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [accountTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

#pragma mark - Register
- (void)onRegister
{
    NSLog(@"onRegister");
}

#pragma mark - ResetPassword
- (void)onResetPassword
{
    NSLog(@"onResetPassword");
}

#pragma mark - Login
- (void)onLogin
{
    [accountTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    NSLog(@"onLogin");
}

#pragma mark - ThirdPartyLogin
- (void)onThirdPartyLogin:(UIButton *)sender
{
    const NSUInteger tag = [sender tag];
    
    NSLog(@"onThirdPartyLogin %@", @(tag));
}

@end
