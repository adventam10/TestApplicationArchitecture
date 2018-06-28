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
    
    [self.weatherView displayForecasts:self.model.responseData[NWKForecasts]];
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
    self.title = self.model.prefectureInfo[TWAName];
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
    [self.model requestWeatherWithCityId:self.model.prefectureInfo[TWACityId]
                           success:^(NSDictionary *jsonData)
     {
         [SVProgressHUD dismiss];
         
         weakSelf.model.responseData = jsonData;
         [weakSelf.weatherView displayForecasts:weakSelf.model.responseData[NWKForecasts]];
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

@end
