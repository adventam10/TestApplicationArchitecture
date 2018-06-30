//
//  NSUserDefaults+ReadWrite.h
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/30.
//  Copyright © 2018年 am10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults(ReadWrite)

/**
 端末内に保存されたオブジェクトをKeyを元に取り出します。
 
 @param key 指定のキー
 @return 対象オブジェクト
 */
+ (id)readObjectWithKey:(NSString *)key;


/**
 端末内にKeyを元にオブジェクトを保存します。
 
 @param object 対象オブジェクト
 @param key 指定のキー
 @return 保存成功フラグ
 */
+ (BOOL)writeObject:(id)object
                key:(NSString *)key;

@end
