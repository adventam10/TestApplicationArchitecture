//
//  UIViewController+ShowPopover.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(ShowPopover)

/**
 popoverで画面を表示する
 
 @param viewController popover表示するViewController
 @param contentSize 画面サイズ
 @param sourceView 表示元View
 @param arrowDirection 矢印の向き
 @param delegate デリゲート
 */
- (void)showPopoverViewController:(UIViewController *)viewController
                      contentSize:(CGSize)contentSize
                       sourceView:(UIView *)sourceView
                   arrowDirection:(UIPopoverArrowDirection)arrowDirection
                         delegate:(id <UIPopoverPresentationControllerDelegate>)delegate;

@end
