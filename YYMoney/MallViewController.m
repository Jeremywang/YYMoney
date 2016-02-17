//
//  MallViewController.m
//  YYMoney
//
//  Created by jeremy on 11/10/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "MallViewController.h"

@interface MallViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation MallViewController

- (void)dawnAndNightMode
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
    NSURL *url = [NSURL URLWithString:@"http://www.taobao.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.scrollView.bounces = NO;
    
    //[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"License" ofType:@"html"]]]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError - %@", error);
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
