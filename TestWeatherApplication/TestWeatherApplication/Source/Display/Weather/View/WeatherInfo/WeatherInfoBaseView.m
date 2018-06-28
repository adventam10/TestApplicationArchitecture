//
//  WeatherInfoBaseView.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherInfoBaseView.h"

@implementation WeatherInfoBaseView

#pragma mark - initialize
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self commonInit];
    }
    
     return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self commonInit];
    }
    
    return self;
}


/**
 *  共通初期化
 */
- (void)commonInit
{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    view.frame = self.bounds;
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
}


#pragma mark - Display Data
/**
 天気情報を表示する
 
 @param forecast 天気情報
 @param subDateText 日付文字列（yyyy/MM/dd(E)形式）
 */
- (void)displayForecast:(NSDictionary *)forecast
            subDateText:(NSString *)subDateText
{
    self.subDateLabel.text = subDateText;
    self.dateLabel.text = forecast[NWKDateLabel];
    self.telopLabel.text = forecast[NWKTelop];
    self.imageView.image = [self getImageFromForecast:forecast];
    self.maxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.minCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
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

@end
