//
//  NetworkManager.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/24.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "NetworkManager.h"
#import <UIKit/UIKit.h>

static const NSTimeInterval NWMTimeoutIntervalForRequest = 60;

@interface NetworkManager()

@property (nonatomic) NSInteger activityCount;

@end

@implementation NetworkManager

static NetworkManager *sharedManager_ = nil; // シングルオブジェクト

#pragma mark - Singleton
/**
 データを一括管理するシングルオブジェクトを得る
 
 @return シングルオブジェクト
 */
+ (NetworkManager *)sharedManager
{
    // 初回だけオブジェクトの生成
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager_ = [NetworkManager new];
    });
    
    return sharedManager_;
}


#pragma mark - Initialize
/**
 初期化処理
 
 @return オブジェクト
 */
- (instancetype)init
{
    if (self = [super init]) {
        
        self.activityCount = 0;
    }
    
    return self;
}


#pragma mark - Public Method
+ (NSURLSessionDataTask *)requestJsonDataWithBaseURLText:(NSString *)baseUrlText
                                               parameter:(NSDictionary <NSString *, NSString *> *)parameter
                                                 success:(NWMJsonSuccess)success
                                                 failure:(NWMJsonFailure)failure
{
    NSString *urlText = [NSString stringWithFormat:@"%@?%@",
                         baseUrlText, [self createParameterTextFromParmeter:parameter]];
    return [self requestJsonDataWithURL:[NSURL URLWithString:urlText]
                                success:success
                                failure:failure];
}


#pragma mark - Private Method
+ (NSURLSessionDataTask *)requestJsonDataWithURL:(NSURL *)url
                                         success:(NWMJsonSuccess)success
                                         failure:(NWMJsonFailure)failure
{
    NSURLSession *session = [self createURLSession];
    [self addActivityCount:1];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url
           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        [self addActivityCount:-1];
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


+ (void)addActivityCount:(NSInteger)count
{
    @synchronized (self) {
        
        [NetworkManager sharedManager].activityCount += count;
        if ([NetworkManager sharedManager].activityCount < 0) {
            
            [NetworkManager sharedManager].activityCount = 0;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = ([NetworkManager sharedManager].activityCount > 0);
    });
}


+ (NSURLSession *)createURLSession
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = NWMTimeoutIntervalForRequest;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return session;
}


+ (NSString *)createParameterTextFromParmeter:(NSDictionary <NSString *, NSString *> *)parameter
{
    NSMutableArray *texts = [NSMutableArray array];
    for (NSString *key in parameter) {
    
        NSString *value = parameter[key];
        [texts addObject:[NSString stringWithFormat:@"%@=%@",
                          [self urlEncode:key], [self urlEncode:value]]];
    }

    return [texts componentsJoinedByString:@"&"];
}


/**
 URLエンコードを行います
 
 @param text 対象文字列
 @return エンコード後の文字列
 */
+ (NSString *)urlEncode:(NSString *)text
{
    NSMutableCharacterSet *allowedCharacterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [allowedCharacterSet addCharactersInString:@"-._~"];
    NSString *escapedString =[text stringByAddingPercentEncodingWithAllowedCharacters:
                              allowedCharacterSet];
    return escapedString;
}

@end
