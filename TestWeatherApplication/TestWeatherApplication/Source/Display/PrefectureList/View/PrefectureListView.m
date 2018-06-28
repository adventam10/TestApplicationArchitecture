//
//  PrefectureListView.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/28.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListView.h"

@implementation PrefectureListView

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
 お気に入りのみ表示ボタンの表示設定

 @param isFavoriteCheck お気に入りのみ表示フラグ
 */
- (void)displayIsFavoriteCheck:(BOOL)isFavoriteCheck
{
    self.favoriteCheckButton.selected = isFavoriteCheck;
}


#pragma mark - Button Action
/**
 お気に入りのみ表示ボタン押した時の処理
 
 @param button 対象ボタン
 */
- (IBAction)tappedFavoriteCheckButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(prefectureListView:didTapFavoriteCheckButton:)]) {
        
        [self.delegate prefectureListView:self didTapFavoriteCheckButton:button];
    }
}


/**
 地方で絞込みボタン押した時の処理
 
 @param button 対象ボタン
 */
- (IBAction)tappedAreaFilterButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(prefectureListView:didTapAreaFilterButton:)]) {
        
        [self.delegate prefectureListView:self didTapAreaFilterButton:button];
    }
}

@end
