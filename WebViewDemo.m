//
//  WebViewDemo.m
//  ----------------------------------------
//  公开示例：iOS 端标准 WKWebView 承载页。
//  本文件为行业通用写法，不含任何 Hook 点、目标类名、注入位置、
//  Swizzle 细节、dylib 初始化时机等核心信息。
//  ----------------------------------------
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewDemoController : UIViewController <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy)   NSString  *targetURL;
@end

@implementation WebViewDemoController

- (instancetype)initWithURL:(NSString *)url {
    if ((self = [super init])) {
        _targetURL = [url copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    cfg.allowsInlineMediaPlayback = YES;
    cfg.preferences.javaScriptEnabled = YES;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      configuration:cfg];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                  | UIViewAutoresizingFlexibleHeight;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];

    NSString *urlStr = self.targetURL.length ? self.targetURL
                                             : @"https://example.com/placeholder";
    NSURL *url = [NSURL URLWithString:urlStr];
    if (url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView
        didFailNavigation:(WKNavigation *)navigation
        withError:(NSError *)error {
    NSLog(@"[Demo] navigation failed: %@", error.localizedDescription);
}

- (void)webView:(WKWebView *)webView
        didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"[Demo] page finished: %@", webView.URL.absoluteString);
}

@end
