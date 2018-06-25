//
//  PrefectureListTableViewCell.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "PrefectureListTableViewCell.h"

@interface PrefectureListTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PrefectureListTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}


- (void)setPrefectureInfo:(NSDictionary *)prefectureInfo
{
    _prefectureInfo = prefectureInfo;
    self.titleLabel.text = prefectureInfo[@"name"];
}


- (void)setIsFavorite:(BOOL)isFavorite
{
    _isFavorite = isFavorite;
    self.favoriteButton.selected = isFavorite;
}


- (IBAction)tappedFavoriteButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(prefectureListTableViewCell:didTapFavoriteButton:)]) {
        
        [self.delegate prefectureListTableViewCell:self didTapFavoriteButton:button];
    }
}

@end
