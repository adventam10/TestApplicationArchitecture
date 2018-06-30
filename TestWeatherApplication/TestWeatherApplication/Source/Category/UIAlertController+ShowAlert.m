//
//  UIAlertController+ShowAlert.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "UIAlertController+ShowAlert.h"

@implementation UIAlertController(ShowAlert)

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
                                   buttonAction:(void (^)(void))buttonAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:(title)? title : @""
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action)
                                {
                                    if (buttonAction) {
                                        
                                        buttonAction();
                                    }
                                }]];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end
