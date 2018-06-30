//
//  WeatherViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherView.h"

//=======================================================
// 天気画面
//=======================================================

@interface WeatherViewController ()

@property (nonatomic) WeatherView *weatherView;

@end

@implementation WeatherViewController

#pragma mark - Override
- (void)loadView
{
    self.weatherView = [WeatherView new];
    self.view = self.weatherView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNavigationBar];
    
    [self.weatherView displayForecasts:self.model.weatherResponse.forecasts];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup NavigationBar
/**
 ナビゲーションバーの設定を行う
 */
- (void)setupNavigationBar
{
    self.title = self.model.prefectureInfo.name;
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                  target:self
                                                  action:@selector(tappedRefreshButton:)];
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
    [self.model requestWeatherWithCityId:self.model.prefectureInfo.cityId
                           success:^()
     {
         [SVProgressHUD dismiss];
         [weakSelf.weatherView displayForecasts:weakSelf.model.weatherResponse.forecasts];
     }
                           failure:^(NSString *message, NSError *error)
     {
         [SVProgressHUD dismiss];
         [UIAlertController showSingleButtonAlertFromViewController:weakSelf
                                                              title:@""
                                                            message:message
                                                        buttonTitle:@"確認"
                                                       buttonAction:nil];
     }];
}

@end
