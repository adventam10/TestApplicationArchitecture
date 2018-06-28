//
//  WeatherViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherViewController.h"

//=======================================================
// 天気画面
//=======================================================

@interface WeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *todayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *todaySubDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *todayImageView;
@property (weak, nonatomic) IBOutlet UILabel *todayTelopLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayMaxCelsiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayMinCelsiusLabel;

@property (weak, nonatomic) IBOutlet UILabel *tomorrowDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowSubDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowTelopLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowMaxCelsiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowMinCelsiusLabel;

@property (weak, nonatomic) IBOutlet UILabel *dayAfterTomorrowDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayAfterTomorrowSubDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dayAfterTomorrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *dayAfterTomorrowTelopLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayAfterTomorrowMaxCelsiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayAfterTomorrowMinCelsiusLabel;

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation WeatherViewController

#pragma mark - Override
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNavigationBar];
    [self setupDateFormatter];
    
    [self displayForecasts:self.responseData[NWKForecasts]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup DateFormatter
/**
 DateFormatterの設定を行う
 */
- (void)setupDateFormatter
{
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd(E)";
}


#pragma mark - Setup NavigationBar
/**
 ナビゲーションバーの設定を行う
 */
- (void)setupNavigationBar
{
    self.title = self.prefectureInfo[TWAName];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                  target:self
                                                  action:@selector(tappedRefreshButton:)];
}


#pragma mark - Display Data
/**
 天気を表示する（今日・明日・明後日の３日分）

 @param forecasts 天気情報一覧
 */
- (void)displayForecasts:(NSArray <NSDictionary *> *)forecasts
{
    [self displayTodayInfoWithForecast:nil];
    [self displayTomorrowInfoWithForecast:nil];
    [self displayDayAfterTomorrowInfoWithForecast:nil];

    if ([self isCheckNull:forecasts]) {
        
        return;
    }
    
    for (NSInteger i = 0; i < forecasts.count; i++) {
        
        if (i == 0) {
            
            [self displayTodayInfoWithForecast:forecasts[i]];
        }
        
        if (i == 1) {
            
            [self displayTomorrowInfoWithForecast:forecasts[i]];
        }
        
        if (i == 2) {
            
            [self displayDayAfterTomorrowInfoWithForecast:forecasts[i]];
        }
    }
}


/**
 今日の天気を表示する

 @param forecast 天気情報
 */
- (void)displayTodayInfoWithForecast:(NSDictionary *)forecast
{
    self.todaySubDateLabel.text = [self.dateFormatter stringFromDate:[NSDate date]];
    self.todayDateLabel.text = forecast[NWKDateLabel];
    self.todayTelopLabel.text = forecast[NWKTelop];
    self.todayImageView.image = [self getImageFromForecast:forecast];
    self.todayMaxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.todayMinCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
}


/**
 明日の天気を表示する
 
 @param forecast 天気情報
 */
- (void)displayTomorrowInfoWithForecast:(NSDictionary *)forecast
{
    self.tomorrowSubDateLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24]];
    self.tomorrowDateLabel.text = forecast[NWKDateLabel];
    self.tomorrowTelopLabel.text = forecast[NWKTelop];
    self.tomorrowImageView.image = [self getImageFromForecast:forecast];
    self.tomorrowMaxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.tomorrowMinCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
}


/**
 明後日の天気を表示する
 
 @param forecast 天気情報
 */
- (void)displayDayAfterTomorrowInfoWithForecast:(NSDictionary *)forecast
{
    self.dayAfterTomorrowSubDateLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*2]];
    self.dayAfterTomorrowDateLabel.text = forecast[NWKDateLabel];
    self.dayAfterTomorrowTelopLabel.text = forecast[NWKTelop];
    self.dayAfterTomorrowImageView.image = [self getImageFromForecast:forecast];
    self.dayAfterTomorrowMaxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.dayAfterTomorrowMinCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
}


/**
 天気画像を取得する

 @param forecast 天気情報
 @return 天気画像
 */
- (UIImage *)getImageFromForecast:(NSDictionary *)forecast
{
    NSDictionary *image = forecast[NWKImage];
    if ([self isCheckNull:image]) {
        
        return nil;
    }
    
    NSString *url = image[NWKUrl];
    if ([self isCheckNull:url]) {
        
        return nil;
    }
    
    if (url.length == 0) {
        
        return nil;
    }
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:imageData];
}


/**
 最高気温を取得する

 @param forecast 天気情報
 @return 最高気温
 */
- (NSString *)getMaxCelsiusFromForecast:(NSDictionary *)forecast
{
    NSDictionary *temperature = forecast[NWKTemperature];
    if ([self isCheckNull:temperature]) {
        
        return @"-";
    }
    
    NSDictionary *max = temperature[NWKMax];
    if ([self isCheckNull:max]) {
        
        return @"-";
    }
    
    NSString *celsius = max[NWKCelsius];
    if ([self isCheckNull:celsius]) {
        
        return @"-";
    }
    
    if (celsius.length == 0) {
        
        return @"-";
    }
    
    return [celsius stringByAppendingString:@"℃"];
}


/**
 最低気温を取得する
 
 @param forecast 天気情報
 @return 最低気温
 */
- (NSString *)getMinCelsiusFromForecast:(NSDictionary *)forecast
{
    NSDictionary *temperature = forecast[NWKTemperature];
    if ([self isCheckNull:temperature]) {
        
        return @"-";
    }
    
    NSDictionary *min = temperature[NWKMin];
    if ([self isCheckNull:min]) {
        
        return @"-";
    }
    
    NSString *celsius = min[NWKCelsius];
    if ([self isCheckNull:celsius]) {
        
        return @"-";
    }
    
    if (celsius.length == 0) {
        
        return @"-";
    }
    
    return [celsius stringByAppendingString:@"℃"];
}


/**
 対象オブジェクトがヌルか判定する

 @param object 対象オブジェクト
 @return YES:ヌル、NO:ヌル以外
 */
- (BOOL)isCheckNull:(id)object
{
    return [object isKindOfClass:[NSNull class]];
}


#pragma mark - Button Action
/**
 再読み込みボタン押した時の処理

 @param button 対象ボタン
 */
- (void)tappedRefreshButton:(UIBarButtonItem *)button
{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [self requestWeatherWithCityId:self.prefectureInfo[TWACityId]
                           success:^(NSDictionary *jsonData)
     {
         [SVProgressHUD dismiss];
         
         weakSelf.responseData = jsonData;
         [weakSelf displayForecasts:weakSelf.responseData[NWKForecasts]];
     }
                           failure:^(NSString *message, NSError *error)
     {
         [SVProgressHUD dismiss];
         [weakSelf showAlertYesOnlyWithTitle:@""
                                     message:message
                                    yesBlock:nil];
     }];
}


#pragma mark - Show
/**
 「確認」ボタンのみのアラートを表示する
 
 @param title タイトル
 @param message メッセージ
 @param yesBlock 「確認」押した時の処理
 */
- (void)showAlertYesOnlyWithTitle:(NSString *)title
                          message:(NSString *)message
                         yesBlock:(void (^)(void))yesBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:(title)? title : @""
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action)
                                {
                                    if (yesBlock) {
                                        
                                        yesBlock();
                                    }
                                }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Request
/**
 天気情報取得処理
 
 @param cityId 対象都道府県ID
 @param success 通信成功時の処理
 @param failure 通信失敗時の処理
 @return タスク
 */
- (NSURLSessionDataTask *)requestWeatherWithCityId:(NSString *)cityId
                                           success:(void (^)(NSDictionary *jsonData))success
                                           failure:(void (^)(NSString *message, NSError *error))failure
{
    NSURLSession *session = [self createURLSession];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:[self createRequestURLWithCityId:cityId]
           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
     {
         [session invalidateAndCancel];
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (error) {
                 
                 if (failure) {
                     
                     failure(error.localizedDescription, error);
                     return;
                 }
             }
             
             if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                 
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                 if (httpResponse.statusCode == 200) {
                     
                     NSError *err;
                     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&err];
                     if (err) {
                         
                         if (failure) {
                             
                             failure(err.localizedDescription, err);
                             return;
                         }
                     }
                     
                     if (success) {
                         
                         success(dic);
                         return;
                     }
                 }
             }
             
             if (failure) {
                 
                 failure(@"データの取得に失敗しました", nil);
                 return;
             }
         });
     }];
    
    [task resume];
    
    return task;
}


/**
 URLセッションを作成する
 
 @return URLセッション
 */
- (NSURLSession *)createURLSession
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 60;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return session;
}


/**
 天気情報取得URLを作成する
 
 @param cityId 対象都道府県ID
 @return 天気情報取得URL
 */
- (NSURL *)createRequestURLWithCityId:(NSString *)cityId
{
    NSString *urlText = [NSString stringWithFormat:@"%@?city=%@",
                         NWKBaseUrlString, cityId];
    return [NSURL URLWithString:urlText];
}

@end
