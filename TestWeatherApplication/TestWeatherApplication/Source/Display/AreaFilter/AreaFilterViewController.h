//
//  AreaFilterViewController.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AFVAreaType) {
    
    AFVAreaTypeHokkaido = 0,
    AFVAreaTypeTohoku,
    AFVAreaTypeKanto,
    AFVAreaTypeChubu,
    AFVAreaTypeKinki,
    AFVAreaTypeChugoku,
    AFVAreaTypeShikoku,
    AFVAreaTypeKyushu,
    
};

@interface AreaFilterViewController : UIViewController

@end
