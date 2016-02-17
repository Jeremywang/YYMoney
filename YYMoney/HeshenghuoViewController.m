//
//  HeshenghuoViewController.m
//  iosapp
//
//  Created by jeremy on 9/24/15.
//  Copyright © 2015 oschina. All rights reserved.
//

#import "HeshenghuoViewController.h"
#import "UIColor+Util.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFOnoResponseSerializer.h"
#import "ONOXMLDocument.h"
#import "MBProgressHUD.h"
#import "Utils.h"

@interface HeshenghuoViewController () <MBProgressHUDDelegate>

@property (nonatomic, strong) UILabel *progressLebel;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger refreshCount;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, copy) NSString *areacodeString;

@property (nonatomic, copy) NSString *imei;
@property (nonatomic, copy) NSString *imeiString;
@property (nonatomic, copy) NSString *deviceidString;
@property (nonatomic, copy) NSString *useridString;

@property (nonatomic, copy) NSString *urlString;

@end

@implementation HeshenghuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"和生活";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //_testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //_testBtn.titleLabel.textColor = [UIColor whiteColor];
    //[_testBtn setTitle:@"TEST" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"team-create"] style:UIBarButtonItemStylePlain target:self action:@selector(RefreshAsync)];
    
    _currentIndex = 0;
//    _refreshCount = 6500;//达州
//    _refreshCount = 500;//遂宁
// _refreshCount = 000;
    _refreshCount = 2000;
    
    
    
    
    _progressLebel = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 200, 200)];
    [_progressLebel setText:[NSString stringWithFormat:@"%d", 0]];
    [_progressLebel setTextColor:[UIColor redColor]];
    [self.view addSubview:_progressLebel];
    
    NSString *suiningAreaCode = @"510900";
    NSString *mianyangAreaCode = @"510700";
    NSString *luzhouAreaCode = @"510500";
    NSString *dazhouAreaCode = @"511700";
    NSString *suiningareacodeString = [NSString stringWithFormat:@"<areacode>%@</areacode>", suiningAreaCode];
    NSString *mianyangareacodeString = [NSString stringWithFormat:@"<areacode>%@</areacode>", mianyangAreaCode];
    NSString *luzhougareacodeString = [NSString stringWithFormat:@"<areacode>%@</areacode>", luzhouAreaCode];
    NSString *dazhouareacodeString = [NSString stringWithFormat:@"<areacode>%@</areacode>", dazhouAreaCode];
    
    _areacodeString = luzhougareacodeString;
    
    _urlString = @"http://client.wap.wxcs.cn/client/service/rpc";
    
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

- (void)RefreshAsync
{
    _HUD = [Utils createHUD];
    _HUD.mode = MBProgressHUDModeAnnularDeterminate;
    _HUD.labelText = [NSString stringWithFormat:@"%ld%s", _currentIndex, "\%"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self RefreshAll];
    });
}

- (void)RefreshAll
{
    while (_currentIndex <= _refreshCount) {
        
        //生成imei
        char data[15];
        for (int x=0;x<15;data[x++] = (char)('0' + (arc4random_uniform(10))));
        _imei = [[NSString alloc] initWithBytes:data length:15 encoding:NSUTF8StringEncoding];
        _imeiString = [NSString stringWithFormat:@"<imei>%@</imei>", _imei];
        _deviceidString = [NSString stringWithFormat:@"<deviceid>%@</deviceid>", _imei];
        _useridString = [NSString stringWithFormat:@"<userid>%@</userid>", _imei];

        
        [self RequestHTTP1];
        //post8
        //post9
        //post10
        //post11
        
        
        _currentIndex++;
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            
            CGFloat progressFloat = (CGFloat)_currentIndex/(CGFloat)_refreshCount;
            _HUD.progress = progressFloat;
            
//            _HUD.labelText = [NSString stringWithFormat:@"%ld%s", _currentIndex, "\%"];
            [_progressLebel setText:[NSString stringWithFormat:@"%ld", _currentIndex]];
        });
        
        NSLog(@"currentindex = %ld", _currentIndex);
        
        
        [NSThread sleepForTimeInterval:20];
    }

    [_HUD hide:YES];
}

- (void)RefreshOne
{
    
    while (_currentIndex <= _refreshCount ) {
        
        
        NSString *urlString = @"http://client.wap.wxcs.cn/client/service/rpc";
        
        //生成imei
        char data[15];
        for (int x=0;x<15;data[x++] = (char)('0' + (arc4random_uniform(10))));
        _imei = [[NSString alloc] initWithBytes:data length:15 encoding:NSUTF8StringEncoding];
        _imeiString = [NSString stringWithFormat:@"<imei>%@</imei>", _imei];
        _deviceidString = [NSString stringWithFormat:@"<deviceid>%@</deviceid>", _imei];
        _useridString = [NSString stringWithFormat:@"<userid>%@</userid>", _imei];
        
        
        //获取当前时间
        NSDate *dateNow11 = [NSDate new];
        NSDateFormatter *dataFormat = [NSDateFormatter new];
        [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
        NSString* dateTime = [dataFormat stringFromDate:dateNow11];
        NSString *timestamp = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow12 = [NSDate new];
        NSString* dateTime12 = [dataFormat stringFromDate:dateNow12];
        NSString *entertime = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime12];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow13 = [NSDate new];
        NSString* dateTime13 = [dataFormat stringFromDate:dateNow13];
        NSString *leavetime = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime13];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow14 = [NSDate new];
        NSString* dateTime14 = [dataFormat stringFromDate:dateNow14];
        NSString *skiptime = [NSString stringWithFormat:@"<skiptime>%@</skiptime>", dateTime14];
        
        

        
        
        
        NSMutableURLRequest *request= [NSMutableURLRequest new];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *contentType = [NSString stringWithFormat:@"text/xml"];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request addValue:@"20029" forHTTPHeaderField:@"transactionid"];
        [request addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[[NSString stringWithFormat:@"<root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><visitinfos><account></account><mobile></mobile><portaltype>2</portaltype>%@<reqtype>4</reqtype><reqobjectcode>切换城市_CityManagerActivity</reqobjectcode>%@<jumprange>0</jumprange><innerjumptype></innerjumptype><innerjumpcode></innerjumpcode><externjumpcode></externjumpcode><netaccesstype>5</netaccesstype><result></result><successid>1</successid><pixel>720_1242</pixel><uatype>1</uatype>%@%@<visittime>500</visittime><userid></userid><uainfo>Mi2</uainfo><sessionid></sessionid><lastjump></lastjump><src_type>200005</src_type>%@<areacode>440100</areacode><portalversion>ModernUI</portalversion><clientversion>3.3.1</clientversion></visitinfos></body></root>", timestamp, _deviceidString, entertime, leavetime, skiptime, _imeiString] dataUsingEncoding:NSUTF8StringEncoding]];
        //    [postBody appendData:[[NSString stringWithFormat:@"<timestamp>20150921225108</timestamp>"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:postBody];
        
//        NSHTTPURLResponse *urlResponse = nil;
//        
//        NSError *error = [NSError new];
//        
//        NSData *responseDATA = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//        
//        NSString *result = [[NSString alloc] initWithData:responseDATA encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"Response1 Code: %ld", [urlResponse statusCode]);
//        
//        if ([urlResponse statusCode] >=200 && [urlResponse statusCode]<300) {
//            NSLog(@"Response1: %@", result);
//        }
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error)
            {
                NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
                NSLog(@"reponse1 code %ld", [resPonse statusCode]);
                
                NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"Post1 dataStr = %@", dataStr);
            }
            else
            {
                NSLog(@"post1 error is :%@",error.localizedDescription);
            }

                }];
        
        [dataTask resume];
        
        
        //post2
        [NSThread sleepForTimeInterval:1];
        //获取当前时间
        NSDate *dateNow21 = [NSDate new];
        
        NSString* dateTime21 = [dataFormat stringFromDate:dateNow21];
        NSString *timestamp21 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime21];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow22 = [NSDate new];
        NSString* dateTime22 = [dataFormat stringFromDate:dateNow22];
        NSString *entertime22 = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime22];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow23 = [NSDate new];
        NSString* dateTime23 = [dataFormat stringFromDate:dateNow23];
        NSString *leavetime23 = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime23];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow24 = [NSDate new];
        NSString* dateTime24 = [dataFormat stringFromDate:dateNow24];
        NSString *skiptime24 = [NSString stringWithFormat:@"<skiptime>%@</skiptime>", dateTime24];
        
        
        NSMutableURLRequest *request2= [NSMutableURLRequest new];
        [request2 setURL:[NSURL URLWithString:urlString]];
        [request2 setHTTPMethod:@"POST"];
        
        [request2 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request2 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request2 addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request2 addValue:@"20029" forHTTPHeaderField:@"transactionid"];
        [request2 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request2 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request2 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request2 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request2 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request2 addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody2 = [NSMutableData data];
        [postBody2 appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><pagelocationinfos><pagecode>切换城市_CityManagerActivity</pagecode><userid></userid>%@%@</pagelocationinfos></body></root>", timestamp21, entertime22, leavetime23] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request2 setHTTPBody:postBody2];
        
        NSHTTPURLResponse *urlResponse2 = nil;
        
        NSError *error2 = [NSError new];
        
        NSData *responseDATA2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:&urlResponse2 error:&error2];
        
        NSString *result2 = [[NSString alloc] initWithData:responseDATA2 encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response2 Code: %ld", [urlResponse2 statusCode]);
        
        if ([urlResponse2 statusCode] >=200 && [urlResponse2 statusCode]<300) {
            NSLog(@"Response2: %@", result2);
        }
        
        
        
        //post3
        [NSThread sleepForTimeInterval:1];
        //获取当前时间
        NSDate *dateNow31 = [NSDate new];
        
        NSString* dateTime31 = [dataFormat stringFromDate:dateNow31];
        NSString *timestamp31 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime31];
        
        
        
        NSMutableURLRequest *request3= [NSMutableURLRequest new];
        [request3 setURL:[NSURL URLWithString:urlString]];
        [request3 setHTTPMethod:@"POST"];
        
        [request3 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request3 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request3 addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request3 addValue:@"20038" forHTTPHeaderField:@"transactionid"];
        [request3 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request3 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request3 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request3 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request3 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request3 addValue:@"getweathernewreq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody3 = [NSMutableData data];
        
        [postBody3 appendData:[[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><root>%@<msgname>getweathernewreq</msgname><result></result><resultdesc></resultdesc><body>%@<days>1</days></body></root>", timestamp31, _areacodeString] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request3 setHTTPBody:postBody3];
        
        NSHTTPURLResponse *urlResponse3 = nil;
        
        NSError *error3 = [NSError new];
        
        NSData *responseDATA3 = [NSURLConnection sendSynchronousRequest:request3 returningResponse:&urlResponse3 error:&error3];
        
        NSString *result3 = [[NSString alloc] initWithData:responseDATA3 encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response3 Code: %ld", [urlResponse3 statusCode]);
        
        if ([urlResponse3 statusCode] >=200 && [urlResponse3 statusCode]<300) {
            NSLog(@"Response3: %@", result3);
        }
        
        //post4
        [NSThread sleepForTimeInterval:1];
        //获取当前时间
        NSDate *dateNow41 = [NSDate new];
        
        NSString* dateTime41 = [dataFormat stringFromDate:dateNow41];
        NSString *timestamp41 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime41];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow42 = [NSDate new];
        NSString* dateTime42 = [dataFormat stringFromDate:dateNow42];
        NSString *entertime42 = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime42];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow43 = [NSDate new];
        NSString* dateTime43 = [dataFormat stringFromDate:dateNow43];
        NSString *leavetime43 = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime43];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow44 = [NSDate new];
        NSString* dateTime44 = [dataFormat stringFromDate:dateNow44];
        NSString *skiptime44 = [NSString stringWithFormat:@"<skiptime>%@</skiptime>", dateTime44];
        
        
        NSMutableURLRequest *request4= [NSMutableURLRequest new];
        [request4 setURL:[NSURL URLWithString:urlString]];
        [request4 setHTTPMethod:@"POST"];
        
        [request4 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request4 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request4 addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request4 addValue:@"20029" forHTTPHeaderField:@"transactionid"];
        [request4 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request4 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request4 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request4 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request4 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request4 addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody4 = [NSMutableData data];
        
        [postBody4 appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><visitinfos><account></account><mobile></mobile><portaltype>2</portaltype>%@<reqtype>4</reqtype><reqobjectcode>首页_WicityMainActivity</reqobjectcode>%@<jumprange>0</jumprange><innerjumptype></innerjumptype><innerjumpcode></innerjumpcode><externjumpcode></externjumpcode><netaccesstype>5</netaccesstype><result></result><successid>1</successid><pixel>720_1242</pixel><uatype>1</uatype>%@%@<visittime>500</visittime><userid></userid><uainfo>Mi2</uainfo><sessionid></sessionid><lastjump></lastjump><src_type>200005</src_type>%@%@<portalversion>ModernUI</portalversion><clientversion>3.3.1</clientversion></visitinfos></body></root>", timestamp41, _deviceidString, entertime42, leavetime43, skiptime44, _imeiString, _areacodeString] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request4 setHTTPBody:postBody4];
        
        NSHTTPURLResponse *urlResponse4 = nil;
        
        NSError *error4 = [NSError new];
        
        NSData *responseDATA4 = [NSURLConnection sendSynchronousRequest:request4 returningResponse:&urlResponse4 error:&error4];
        
        NSString *result4 = [[NSString alloc] initWithData:responseDATA4 encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response4 Code: %ld", [urlResponse4 statusCode]);
        
        if ([urlResponse4 statusCode] >=200 && [urlResponse4 statusCode]<300) {
            NSLog(@"Response4: %@", result4);
        }
        
        
        
        
        //post5
        [NSThread sleepForTimeInterval:1];
        NSDate *dateNow51 = [NSDate new];
        
        NSString* dateTime51 = [dataFormat stringFromDate:dateNow51];
        NSString *timestamp51 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime51];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow52 = [NSDate new];
        NSString* dateTime52 = [dataFormat stringFromDate:dateNow52];
        NSString *entertime52 = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime52];
        
        [NSThread sleepForTimeInterval:0.2];
        NSDate *dateNow53 = [NSDate new];
        NSString* dateTime53 = [dataFormat stringFromDate:dateNow53];
        NSString *leavetime53 = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime53];
        
        
        
        NSMutableURLRequest *request5= [NSMutableURLRequest new];
        [request5 setURL:[NSURL URLWithString:urlString]];
        [request5 setHTTPMethod:@"POST"];
        
        [request5 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request5 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request5 addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request5 addValue:@"20029" forHTTPHeaderField:@"transactionid"];
        [request5 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request5 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request5 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request5 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request5 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request5 addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody5 = [NSMutableData data];
        
        [postBody5 appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><pagelocationinfos><pagecode>首页_WicityMainActivity</pagecode><userid></userid>%@%@</pagelocationinfos></body></root>", timestamp51, entertime52, leavetime53] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request5 setHTTPBody:postBody5];
        
        NSHTTPURLResponse *urlResponse5 = nil;
        
        NSError *error5 = [NSError new];
        
        NSData *responseDATA5 = [NSURLConnection sendSynchronousRequest:request5 returningResponse:&urlResponse5 error:&error5];
        
        NSString *result5 = [[NSString alloc] initWithData:responseDATA5 encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response5 Code: %ld", [urlResponse5 statusCode]);
        
        if ([urlResponse5 statusCode] >=200 && [urlResponse5 statusCode]<300) {
            NSLog(@"Response5: %@", result5);
        }
        
        //post6
        [NSThread sleepForTimeInterval:1];
        NSDate *dateNow61 = [NSDate new];
        
        NSString* dateTime61 = [dataFormat stringFromDate:dateNow61];
        NSString *timestamp61 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime61];
        
        NSMutableURLRequest *request6= [NSMutableURLRequest new];
        [request6 setURL:[NSURL URLWithString:urlString]];
        [request6 setHTTPMethod:@"POST"];
        
        [request6 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request6 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request6 addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request6 addValue:@"201209101200002221" forHTTPHeaderField:@"transactionid"];
        [request6 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request6 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request6 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request6 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request6 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request6 addValue:@"querymsgcountreq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody6 = [NSMutableData data];
        
        [postBody6 appendData:[[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><root>%@<msgname>querymsgcountreq</msgname><transactionid>201209101200002221</transactionid><body>%@<msgtype>1</msgtype><citycode>510900</citycode></body></root>", timestamp61, _useridString] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request6 setHTTPBody:postBody6];
        
        NSHTTPURLResponse *urlResponse6 = nil;
        
        NSError *error6 = [NSError new];
        
        NSData *responseDATA6 = [NSURLConnection sendSynchronousRequest:request6 returningResponse:&urlResponse6 error:&error6];
        
        NSString *result6 = [[NSString alloc] initWithData:responseDATA6 encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response6 Code: %ld", [urlResponse6 statusCode]);
        
        if ([urlResponse6 statusCode] >=200 && [urlResponse6 statusCode]<300) {
            NSLog(@"Response6: %@", result6);
        }
        
        
        
        //post7
        [NSThread sleepForTimeInterval:1];
        NSDate *dateNow71 = [NSDate new];
        
        NSString* dateTime71 = [dataFormat stringFromDate:dateNow71];
        NSString *timestamp71 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime71];
        
        NSMutableURLRequest *request7= [NSMutableURLRequest new];
        [request7 setURL:[NSURL URLWithString:urlString]];
        [request7 setHTTPMethod:@"POST"];
        
        [request7 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        [request7 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
        [request7 addValue:@"android" forHTTPHeaderField:@"versionos"];
        [request7 addValue:@"2009" forHTTPHeaderField:@"transactionid"];
        [request7 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
        [request7 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
        [request7 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
        [request7 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
        [request7 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
        [request7 addValue:@"checkupdatereq" forHTTPHeaderField:@"msgname"];
        
        
        NSMutableData *postBody7 = [NSMutableData data];
        
        [postBody7 appendData:[[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><root>%@<msgname>checkupdatereq</msgname><result></result><resultdesc></resultdesc><body><curversion>1012</curversion><ostype>android</ostype><osversion>4.4.2</osversion><resolution>720_1242</resolution><clienttype>1</clienttype></body></root>", timestamp71] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request7 setHTTPBody:postBody7];
        
        NSHTTPURLResponse *urlResponse7 = nil;
        
        NSError *error7 = [NSError new];
        
        NSData *responseDATA7 = [NSURLConnection sendSynchronousRequest:request7 returningResponse:&urlResponse7 error:&error7];
        
        NSString *result7 = [[NSString alloc] initWithData:responseDATA7 encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response7 Code: %ld", [urlResponse7 statusCode]);
        
        if ([urlResponse7 statusCode] >=200 && [urlResponse7 statusCode]<300) {
            NSLog(@"Response7: %@", result7);
        }
        //post8
        //post9
        //post10
        //post11
        ///AFHTTPNetwork test
        
        
        _currentIndex++;
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            
            CGFloat progressFloat = (CGFloat)_currentIndex/(CGFloat)_refreshCount;
            _HUD.progress = progressFloat;
            
            _HUD.labelText = [NSString stringWithFormat:@"%ld%s", _currentIndex, "\%"];
            [_progressLebel setText:[NSString stringWithFormat:@"%ld", _currentIndex]];
        });
        
        NSLog(@"currentindex = %ld", _currentIndex);
        
        
        [NSThread sleepForTimeInterval:30];
        
    }
    
    [_HUD hide:YES];
    
    
}


- (void)RequestHTTP1
{
    //获取当前时间
    NSDate *dateNow11 = [NSDate new];
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    NSString* dateTime = [dataFormat stringFromDate:dateNow11];
    NSString *timestamp = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow12 = [NSDate new];
    NSString* dateTime12 = [dataFormat stringFromDate:dateNow12];
    NSString *entertime = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime12];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow13 = [NSDate new];
    NSString* dateTime13 = [dataFormat stringFromDate:dateNow13];
    NSString *leavetime = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime13];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow14 = [NSDate new];
    NSString* dateTime14 = [dataFormat stringFromDate:dateNow14];
    NSString *skiptime = [NSString stringWithFormat:@"<skiptime>%@</skiptime>", dateTime14];
    
    

    
    NSMutableURLRequest *request= [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:_urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request addValue:@"20029" forHTTPHeaderField:@"transactionid"];
    [request addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><visitinfos><account></account><mobile></mobile><portaltype>2</portaltype>%@<reqtype>4</reqtype><reqobjectcode>切换城市_CityManagerActivity</reqobjectcode>%@<jumprange>0</jumprange><innerjumptype></innerjumptype><innerjumpcode></innerjumpcode><externjumpcode></externjumpcode><netaccesstype>5</netaccesstype><result></result><successid>1</successid><pixel>720_1242</pixel><uatype>1</uatype>%@%@<visittime>500</visittime><userid></userid><uainfo>Mi2</uainfo><sessionid></sessionid><lastjump></lastjump><src_type>200005</src_type>%@<areacode>440100</areacode><portalversion>ModernUI</portalversion><clientversion>3.3.1</clientversion></visitinfos></body></root>", timestamp, _deviceidString, entertime, leavetime, skiptime, _imeiString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse1 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post1 dataStr = %@", dataStr);
            
            [self RequestHTTP2];
        }
        else
        {
            NSLog(@"post1 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];
}

- (void)RequestHTTP2
{
    //post2
    [NSThread sleepForTimeInterval:1];
    
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    
    //获取当前时间
    NSDate *dateNow21 = [NSDate new];
    
    NSString* dateTime21 = [dataFormat stringFromDate:dateNow21];
    NSString *timestamp21 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime21];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow22 = [NSDate new];
    NSString* dateTime22 = [dataFormat stringFromDate:dateNow22];
    NSString *entertime22 = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime22];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow23 = [NSDate new];
    NSString* dateTime23 = [dataFormat stringFromDate:dateNow23];
    NSString *leavetime23 = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime23];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow24 = [NSDate new];
    NSString* dateTime24 = [dataFormat stringFromDate:dateNow24];
    NSString *skiptime24 = [NSString stringWithFormat:@"<skiptime>%@</skiptime>", dateTime24];
    
    
    NSMutableURLRequest *request2= [NSMutableURLRequest new];
    [request2 setURL:[NSURL URLWithString:_urlString]];
    [request2 setHTTPMethod:@"POST"];
    
    [request2 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request2 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request2 addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request2 addValue:@"20029" forHTTPHeaderField:@"transactionid"];
    [request2 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request2 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request2 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request2 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request2 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request2 addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody2 = [NSMutableData data];
    [postBody2 appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><pagelocationinfos><pagecode>切换城市_CityManagerActivity</pagecode><userid></userid>%@%@</pagelocationinfos></body></root>", timestamp21, entertime22, leavetime23] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request2 setHTTPBody:postBody2];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse2 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post2 dataStr = %@", dataStr);
            
            [self RequestHTTP3];
        }
        else
        {
            NSLog(@"post2 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];
    
}

- (void)RequestHTTP3
{
    //post3
    [NSThread sleepForTimeInterval:1];
    
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    
    //获取当前时间
    NSDate *dateNow31 = [NSDate new];
    
    NSString* dateTime31 = [dataFormat stringFromDate:dateNow31];
    NSString *timestamp31 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime31];
    
    
    
    NSMutableURLRequest *request3= [NSMutableURLRequest new];
    [request3 setURL:[NSURL URLWithString:_urlString]];
    [request3 setHTTPMethod:@"POST"];
    
    [request3 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request3 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request3 addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request3 addValue:@"20038" forHTTPHeaderField:@"transactionid"];
    [request3 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request3 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request3 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request3 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request3 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request3 addValue:@"getweathernewreq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody3 = [NSMutableData data];
    
    [postBody3 appendData:[[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><root>%@<msgname>getweathernewreq</msgname><result></result><resultdesc></resultdesc><body>%@<days>1</days></body></root>", timestamp31, _areacodeString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request3 setHTTPBody:postBody3];
    

    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request3 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse3 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post3 dataStr = %@", dataStr);
            
            [self RequestHTTP4];
        }
        else
        {
            NSLog(@"post3 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];

}

- (void)RequestHTTP4
{
    //post4
    [NSThread sleepForTimeInterval:1];
    
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    
    //获取当前时间
    NSDate *dateNow41 = [NSDate new];
    
    NSString* dateTime41 = [dataFormat stringFromDate:dateNow41];
    NSString *timestamp41 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime41];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow42 = [NSDate new];
    NSString* dateTime42 = [dataFormat stringFromDate:dateNow42];
    NSString *entertime42 = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime42];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow43 = [NSDate new];
    NSString* dateTime43 = [dataFormat stringFromDate:dateNow43];
    NSString *leavetime43 = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime43];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow44 = [NSDate new];
    NSString* dateTime44 = [dataFormat stringFromDate:dateNow44];
    NSString *skiptime44 = [NSString stringWithFormat:@"<skiptime>%@</skiptime>", dateTime44];
    
    
    NSMutableURLRequest *request4= [NSMutableURLRequest new];
    [request4 setURL:[NSURL URLWithString:_urlString]];
    [request4 setHTTPMethod:@"POST"];
    
    [request4 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request4 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request4 addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request4 addValue:@"20029" forHTTPHeaderField:@"transactionid"];
    [request4 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request4 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request4 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request4 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request4 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request4 addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody4 = [NSMutableData data];
    
    [postBody4 appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><visitinfos><account></account><mobile></mobile><portaltype>2</portaltype>%@<reqtype>4</reqtype><reqobjectcode>首页_WicityMainActivity</reqobjectcode>%@<jumprange>0</jumprange><innerjumptype></innerjumptype><innerjumpcode></innerjumpcode><externjumpcode></externjumpcode><netaccesstype>5</netaccesstype><result></result><successid>1</successid><pixel>720_1242</pixel><uatype>1</uatype>%@%@<visittime>500</visittime><userid></userid><uainfo>Mi2</uainfo><sessionid></sessionid><lastjump></lastjump><src_type>200005</src_type>%@%@<portalversion>ModernUI</portalversion><clientversion>3.3.1</clientversion></visitinfos></body></root>", timestamp41, _deviceidString, entertime42, leavetime43, skiptime44, _imeiString, _areacodeString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request4 setHTTPBody:postBody4];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request4 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse4 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post4 dataStr = %@", dataStr);
            
            [self RequestHTTP5];
        }
        else
        {
            NSLog(@"post4 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];
}

- (void)RequestHTTP5
{
    //post5
    [NSThread sleepForTimeInterval:1];
    
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    
    
    NSDate *dateNow51 = [NSDate new];
    
    NSString* dateTime51 = [dataFormat stringFromDate:dateNow51];
    NSString *timestamp51 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime51];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow52 = [NSDate new];
    NSString* dateTime52 = [dataFormat stringFromDate:dateNow52];
    NSString *entertime52 = [NSString stringWithFormat:@"<entertime>%@</entertime>",dateTime52];
    
    [NSThread sleepForTimeInterval:0.2];
    NSDate *dateNow53 = [NSDate new];
    NSString* dateTime53 = [dataFormat stringFromDate:dateNow53];
    NSString *leavetime53 = [NSString stringWithFormat:@"<leavetime>%@</leavetime>", dateTime53];
    
    
    
    NSMutableURLRequest *request5= [NSMutableURLRequest new];
    [request5 setURL:[NSURL URLWithString:_urlString]];
    [request5 setHTTPMethod:@"POST"];
    
    [request5 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request5 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request5 addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request5 addValue:@"20029" forHTTPHeaderField:@"transactionid"];
    [request5 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request5 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request5 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request5 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request5 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request5 addValue:@"clientoptlogsreq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody5 = [NSMutableData data];
    
    [postBody5 appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root>%@<msgname>clientoptlogsreq</msgname><result/><resultdesc/><body><pagelocationinfos><pagecode>首页_WicityMainActivity</pagecode><userid></userid>%@%@</pagelocationinfos></body></root>", timestamp51, entertime52, leavetime53] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request5 setHTTPBody:postBody5];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request5 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse5 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post5 dataStr = %@", dataStr);
            
            [self RequestHTTP6];
        }
        else
        {
            NSLog(@"post5 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];
}

- (void)RequestHTTP6
{
    //post6
    [NSThread sleepForTimeInterval:1];
    
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    
    NSDate *dateNow61 = [NSDate new];
    
    NSString* dateTime61 = [dataFormat stringFromDate:dateNow61];
    NSString *timestamp61 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime61];
    
    NSMutableURLRequest *request6= [NSMutableURLRequest new];
    [request6 setURL:[NSURL URLWithString:_urlString]];
    [request6 setHTTPMethod:@"POST"];
    
    [request6 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request6 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request6 addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request6 addValue:@"201209101200002221" forHTTPHeaderField:@"transactionid"];
    [request6 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request6 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request6 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request6 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request6 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request6 addValue:@"querymsgcountreq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody6 = [NSMutableData data];
    
    [postBody6 appendData:[[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><root>%@<msgname>querymsgcountreq</msgname><transactionid>201209101200002221</transactionid><body>%@<msgtype>1</msgtype><citycode>510900</citycode></body></root>", timestamp61, _useridString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request6 setHTTPBody:postBody6];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request6 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse6 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post6 dataStr = %@", dataStr);
            
            [self RequestHTTP7];
        }
        else
        {
            NSLog(@"post6 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];
}

- (void)RequestHTTP7
{
    
    //post7
    [NSThread sleepForTimeInterval:1];
    
    NSDateFormatter *dataFormat = [NSDateFormatter new];
    [dataFormat setDateFormat:@"YYYYMMddhhmmss"];
    
    NSDate *dateNow71 = [NSDate new];
    
    NSString* dateTime71 = [dataFormat stringFromDate:dateNow71];
    NSString *timestamp71 = [NSString stringWithFormat:@"<timestamp>%@</timestamp>",dateTime71];
    
    NSMutableURLRequest *request7= [NSMutableURLRequest new];
    [request7 setURL:[NSURL URLWithString:_urlString]];
    [request7 setHTTPMethod:@"POST"];
    
    [request7 addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request7 addValue:@"00010" forHTTPHeaderField:@"sendaddress"];
    [request7 addValue:@"android" forHTTPHeaderField:@"versionos"];
    [request7 addValue:@"2009" forHTTPHeaderField:@"transactionid"];
    [request7 addValue:@"1.0.0" forHTTPHeaderField:@"msgversion"];
    [request7 addValue:@"00011" forHTTPHeaderField:@"recvaddress"];
    [request7 addValue:@"000002" forHTTPHeaderField:@"sendareacode"];
    [request7 addValue:@"1000" forHTTPHeaderField:@"versioncode"];
    [request7 addValue:@"000002" forHTTPHeaderField:@"recvareacode"];
    [request7 addValue:@"checkupdatereq" forHTTPHeaderField:@"msgname"];
    
    
    NSMutableData *postBody7 = [NSMutableData data];
    
    [postBody7 appendData:[[NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><root>%@<msgname>checkupdatereq</msgname><result></result><resultdesc></resultdesc><body><curversion>1012</curversion><ostype>android</ostype><osversion>4.4.2</osversion><resolution>720_1242</resolution><clienttype>1</clienttype></body></root>", timestamp71] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request7 setHTTPBody:postBody7];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request7 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSHTTPURLResponse* resPonse = (NSHTTPURLResponse*)response;
            NSLog(@"reponse7 code %ld", [resPonse statusCode]);
            
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Post7 dataStr = %@", dataStr);
        }
        else
        {
            NSLog(@"post7 error is :%@",error.localizedDescription);
        }
        
    }];
    
    [dataTask resume];
    
}


@end
