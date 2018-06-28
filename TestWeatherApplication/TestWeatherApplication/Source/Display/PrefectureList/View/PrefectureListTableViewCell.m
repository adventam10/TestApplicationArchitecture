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

#pragma mark -
- (void)displayPrefectureInfo:(NSDictionary *)prefectureInfo
                   isFavorite:(BOOL)isFavorite
{
    self.titleLabel.text = prefectureInfo[TWAName];
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
