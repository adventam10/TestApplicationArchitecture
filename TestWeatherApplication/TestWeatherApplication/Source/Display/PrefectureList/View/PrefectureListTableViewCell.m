//
//  PrefectureListTableViewCell.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListTableViewCell.h"

//=======================================================
// 都道府県一覧セル
//=======================================================

@interface PrefectureListTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PrefectureListTableViewCell

#pragma mark - Display Data
/**
 セルの表示処理

 @param prefectureInfo 都道府県情報
 @param isFavorite お気に入りフラグ
 */
- (void)displayPrefectureInfo:(CityDataList *)prefectureInfo
                   isFavorite:(BOOL)isFavorite
{
    self.titleLabel.text = prefectureInfo.name;
    self.favoriteButton.selected = isFavorite;
}


#pragma mark - Button Action
/**
 お気に入りボタン押した時の処理

 @param button 対象ボタン
 */
- (IBAction)tappedFavoriteButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(prefectureListTableViewCell:didTapFavoriteButton:)]) {
        
        [self.delegate prefectureListTableViewCell:self didTapFavoriteButton:button];
    }
}

@end
