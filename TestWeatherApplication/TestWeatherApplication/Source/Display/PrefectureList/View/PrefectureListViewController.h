//
//  PrefectureListViewController.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface PrefectureListViewController : UIViewController

#pragma mark - Display Data
/**
 テーブルの表示を更新する
 */
- (void)reloadTableView;

/**
 お気に入りのみ表示ボタンの表示設定
 
 @param isFavoriteCheck お気に入りのみ表示フラグ
 */
- (void)displayIsFavoriteCheck:(BOOL)isFavoriteCheck;

#pragma mark - Show
/**
 天気画面表示処理
 
 @param model モデル
 */
- (void)showWeatherViewControllerWithModel:(WeatherModel *)model;


/**
 「確認」ボタンのみのアラートを表示する
 
 @param title タイトル
 @param message メッセージ
 @param yesBlock 「確認」押した時の処理
 */
- (void)showAlertYesOnlyWithTitle:(NSString *)title
                          message:(NSString *)message
                         yesBlock:(void (^)(void))yesBlock;

@end
