//
//  UIAlertController+ShowAlert.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController(ShowAlert)

/**
 ボタン１つのアラートを表示する
 
 @param viewController 表示元ViewController
 @param title タイトル
 @param message メッセージ
 @param buttonTitle ボタンタイトル
 @param buttonAction ボタンタップ時のアクション
 */
+ (void)showSingleButtonAlertFromViewController:(UIViewController *)viewController
                                          title:(NSString *)title
                                        message:(NSString *)message
                                    buttonTitle:(NSString *)buttonTitle
                                   buttonAction:(void (^)(void))buttonAction;

@end
