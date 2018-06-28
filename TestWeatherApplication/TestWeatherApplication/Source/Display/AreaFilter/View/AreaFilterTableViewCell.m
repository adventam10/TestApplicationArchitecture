//
//  AreaFilterTableViewCell.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterTableViewCell.h"

//=======================================================
// 地方で絞込みセル
//=======================================================

@interface AreaFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@end

@implementation AreaFilterTableViewCell

/**
 表示処理
 
 @param cellModel セルの表示情報
 */
- (void)displayInfo:(AreaFilterCellModel *)cellModel
{
    self.areaLabel.text = cellModel.area;
    self.checkImageView.highlighted = cellModel.isCheck;
}

@end
