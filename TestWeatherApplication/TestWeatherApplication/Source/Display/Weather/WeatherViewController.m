//
//  WeatherViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherViewController.h"

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

@end

@implementation WeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self displayTodayInfoWithForecast:nil];
    [self displayTomorrowInfoWithForecast:nil];
    [self displayDayAfterTomorrowInfoWithForecast:nil];
    
    NSDictionary *location = self.responseData[@"location"];
    if ([self isCheckNull:location]) {
        
        self.title = nil;
        
    } else {
        
        self.title = ([self isCheckNull:location[@"prefecture"]])? nil : location[@"prefecture"];
    }
    
    NSArray <NSDictionary *> *forecasts;
    if (![self isCheckNull:self.responseData[@"forecasts"]]) {
        
        forecasts = self.responseData[@"forecasts"];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)displayTodayInfoWithForecast:(NSDictionary *)forecast
{
    self.todayDateLabel.text = forecast[@"dateLabel"];
    self.todayTelopLabel.text = forecast[@"telop"];
    self.todayImageView.image = [self getImageFromForecast:forecast];
    self.todayMaxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.todayMinCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
}


- (void)displayTomorrowInfoWithForecast:(NSDictionary *)forecast
{
    self.tomorrowDateLabel.text = forecast[@"dateLabel"];
    self.tomorrowTelopLabel.text = forecast[@"telop"];
    self.tomorrowImageView.image = [self getImageFromForecast:forecast];
    self.tomorrowMaxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.tomorrowMinCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
}


- (void)displayDayAfterTomorrowInfoWithForecast:(NSDictionary *)forecast
{
    self.dayAfterTomorrowDateLabel.text = forecast[@"dateLabel"];
    self.dayAfterTomorrowTelopLabel.text = forecast[@"telop"];
    self.dayAfterTomorrowImageView.image = [self getImageFromForecast:forecast];
    self.dayAfterTomorrowMaxCelsiusLabel.text = [self getMaxCelsiusFromForecast:forecast];
    self.dayAfterTomorrowMinCelsiusLabel.text = [self getMinCelsiusFromForecast:forecast];
}

- (UIImage *)getImageFromForecast:(NSDictionary *)forecast
{
    NSDictionary *image = forecast[@"image"];
    if ([self isCheckNull:image]) {
        
        return nil;
    }
    
    NSString *url = image[@"url"];
    if ([self isCheckNull:url]) {
        
        return nil;
    }
    
    if (url.length == 0) {
        
        return nil;
    }
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:imageData];
}

- (NSString *)getMaxCelsiusFromForecast:(NSDictionary *)forecast
{
    NSDictionary *temperature = forecast[@"temperature"];
    if ([self isCheckNull:temperature]) {
        
        return @"-";
    }
    
    NSDictionary *max = temperature[@"max"];
    if ([self isCheckNull:max]) {
        
        return @"-";
    }
    
    NSString *celsius = max[@"celsius"];
    if ([self isCheckNull:celsius]) {
        
        return @"-";
    }
    
    if (celsius.length == 0) {
        
        return @"-";
    }
    
    return celsius;
}

- (NSString *)getMinCelsiusFromForecast:(NSDictionary *)forecast
{
    NSDictionary *temperature = forecast[@"temperature"];
    if ([self isCheckNull:temperature]) {
        
        return @"-";
    }
    
    NSDictionary *min = temperature[@"min"];
    if ([self isCheckNull:min]) {
        
        return @"-";
    }
    
    NSString *celsius = min[@"celsius"];
    if ([self isCheckNull:celsius]) {
        
        return @"-";
    }
    
    if (celsius.length == 0) {
        
        return @"-";
    }
    
    return celsius;
}

- (BOOL)isCheckNull:(id)object
{
    return [object isKindOfClass:[NSNull class]];
}
@end
