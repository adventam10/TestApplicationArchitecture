//
//  AreaFilterTableViewCell.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaFilterCellModel.h"

@interface AreaFilterTableViewCell : UITableViewCell

/**
 表示処理
 
 @param cellModel セルの表示情報
 */
- (void)displayInfo:(AreaFilterCellModel *)cellModel;

@end
