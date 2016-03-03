//
//  ViewController.m
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/27.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import "LPSViewController.h"
#import "LPSEngine+SocialSecurity.h"

@interface LPSViewController ()

@property (nonatomic, strong) UITextField *text;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    _text = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 100, 100)];
    _text.text = @"input code";
    [self.view addSubview:_text];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 130, 100, 50);
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(ssss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 60, 30)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 180, [UIScreen mainScreen].bounds.size.width, 300)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [[LPSEngine sharedEngine] getSocialSecurityVerificationCodeWithSuccess:^(UIImage *image) {
        if (image) {
            _imageView.image = image;
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ssss {
    
    [[LPSEngine sharedEngine] loginWitherificationCode:_text.text Success:^(NSString *htmlString) {
        [_webView loadHTMLString:htmlString baseURL:nil];
    } failure:^(NSInteger statusCode, NSError *error) {
        
    }];
}

@end
