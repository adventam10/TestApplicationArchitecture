//
//  WeatherViewModel.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherViewModel.h"

@implementation WeatherViewModel

/**
 画面初期表示時の処理
 */
- (void)setupData
{
    [self.viewController displayTitle:self.model.prefectureInfo.name];
    [self.viewController displayForecasts:self.model.weatherResponse.forecasts];
}


#pragma mark - User Action
/**
 再読み込みボタン押した時の処理
 */
- (void)didTapRefreshButton
{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [self requestWeatherWithCityId:self.model.prefectureInfo.cityId
                                 success:^
     {
         [SVProgressHUD dismiss];
         [weakSelf.viewController displayForecasts:weakSelf.model.weatherResponse.forecasts];
     }
                                 failure:^(NSString *message, NSError *error)
     {
         [SVProgressHUD dismiss];
         [weakSelf.viewController showAlertYesOnlyWithTitle:@""
                                                    message:message
                                                   yesBlock:nil];
     }];
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
                                           success:(void (^)(void))success
                                           failure:(void (^)(NSString *message, NSError *error))failure
{
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task =
    [self requestWithURL:[self createRequestURLWithCityId:cityId]
                 success:^(NSDictionary *jsonData)
     {
         weakSelf.model.weatherResponse = [[WeatherResponse alloc] initWithDictionary:jsonData];
         if (success) {
             
             success();
         }
     }
                 failure:failure];
    
    return task;
}


/**
 通信処理
 
 @param url URL
 @param success 通信成功時の処理
 @param failure 通信失敗時の処理
 @return タスク
 */
- (NSURLSessionDataTask *)requestWithURL:(NSURL *)url
                                 success:(void (^)(NSDictionary *jsonData))success
                                 failure:(void (^)(NSString *message, NSError *error))failure
{
    NSURLSession *session = [self createURLSession];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url
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
