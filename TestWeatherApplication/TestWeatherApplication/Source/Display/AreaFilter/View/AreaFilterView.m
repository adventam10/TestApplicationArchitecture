//
//  AreaFilterView.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterView.h"

@implementation AreaFilterView

#pragma mark - Initialize
/**
 初期設定を行う
 
 @return インスタンス
 */
- (instancetype)init
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                   owner:self
                                                 options:nil];
    self = array.firstObject;
    return self;
}


#pragma mark - Display Data
/**
 全選択ボタンの表示設定
 
 @param isAllCheck 全選択フラグ
 */
- (void)displayIsAllCheck:(BOOL)isAllCheck
{
    self.allSelectButton.selected = isAllCheck;
}


#pragma mark - Button Action
/**
 すべてボタン押した時の処理
 
 @param button 対象ボタン
 */
- (IBAction)tappedAllSelectButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(areaFilterView:didTapAllSelectButton:)]) {
        
        [self.delegate areaFilterView:self didTapAllSelectButton:button];
    }
}

@end
