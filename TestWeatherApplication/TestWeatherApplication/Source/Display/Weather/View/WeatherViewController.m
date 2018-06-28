//
//  WeatherViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherView.h"
#import "WeatherPresenter.h"

//=======================================================
// 天気画面
//=======================================================

@interface WeatherViewController ()

@property (nonatomic) WeatherView *weatherView;

@property (nonatomic) WeatherPresenter *presenter;

@end

@implementation WeatherViewController

/**
 プレゼンターの設定

 @param model モデル
 */
- (void)setupPresenterWithModel:(WeatherModel *)model
{
    self.presenter = [WeatherPresenter new];
    self.presenter.model = model;
    self.presenter.viewController = self;
}


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
    
    [self.presenter setupData];
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
    [self.presenter didTapRefreshButton];
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


#pragma mark - Display Data
/**
 タイトルを表示する
 
 @param title タイトル
 */
- (void)displayTitle:(NSString *)title
{
    self.title = title;
}


/**
 天気を表示する（今日・明日・明後日の３日分）
 
 @param forecasts 天気情報一覧
 */
- (void)displayForecasts:(NSArray <WeatherResponseForecast *> *)forecasts
{
    [self.weatherView displayForecasts:forecasts];
}

@end
