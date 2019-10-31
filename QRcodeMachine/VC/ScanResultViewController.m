//
//  ScanResultViewController.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/29.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "ScanResultViewController.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKNavigationDelegate.h>
@interface ScanResultViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView  *webview;
@property (nonatomic,copy)NSString *mainAdress;
@property (nonatomic,strong)UIImageView *nodataImageview;
@end

@implementation ScanResultViewController

- (instancetype)initWithAdress:(NSString *)adress{
    if(self = [super init]){
        self.mainAdress = adress;
       
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.mainAdress]]];
    [self.view addSubview:self.webview];
    [self.webview addSubview:self.nodataImageview];
    
    
    [self.nodataImageview mas_makeConstraints:^(MASConstraintMaker *make) {
               make.center.equalTo(self.view);
               make.size.mas_equalTo(CGSizeMake(197, 128));
           }];
  
}

- (WKWebView *)webview{
    if(!_webview){
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
        //_webview.backgroundColor = [UIColor redColor];
               // UI代理
         _webview.UIDelegate = self;
        [_webview goBack];
        [_webview goForward];
        
              // 导航代理
        _webview.navigationDelegate = self;
      
    }
    return _webview;
}
   // 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
    // 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
   NSLog(@"加载失败");
      self.nodataImageview.hidden = NO;
      self.navigationItem.title = @"加载失败";
}
    // 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
    // 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
     [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
      self.nodataImageview.hidden = YES;
      //[self.progressView setProgress:0.0f animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
  
}


- (UIImageView *)nodataImageview{
    if(!_nodataImageview){
        _nodataImageview = [[UIImageView alloc]init];
        _nodataImageview.hidden = YES;
        _nodataImageview.image = [UIImage imageNamed:@"scan_nodata128"];
    }
    return _nodataImageview;
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
