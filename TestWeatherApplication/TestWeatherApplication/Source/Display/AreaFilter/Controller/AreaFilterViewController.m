//
//  AreaFilterViewController.m
//  TestWeatherApplication
//
//  Created by am10 on 2018/06/25.
//  Copyright © 2018年 am10. All rights reserved.
//

#import "AreaFilterViewController.h"
#import "AreaFilterTableViewCell.h"
#import "AreaFilterView.h"

//=======================================================
// 地方で絞込み画面
//=======================================================

@interface AreaFilterViewController ()<UITableViewDelegate, UITableViewDataSource, AreaFilterViewDelegate>

@property (nonatomic) AreaFilterView *areaFilterView;

@end

@implementation AreaFilterViewController

#pragma mark - Override
- (void)loadView
{
    self.areaFilterView = [AreaFilterView new];
    self.areaFilterView.delegate = self;
    self.view = self.areaFilterView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    
    [self.areaFilterView displayIsAllCheck:[self.model isAllCheck]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView DataSource
/**
 セクション内行数を設定する
 
 @param tableView 対象テーブルView
 @param section 対象セクション
 @return セクション内行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.model.tableDataList.count;
}


/**
 セルを設定する
 
 @param tableView 対象テーブルView
 @param indexPath 対象インデックスパス
 @return セル
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = NSStringFromClass([AreaFilterTableViewCell class]);
    AreaFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName
                                                                        forIndexPath:indexPath];
    NSNumber *num = self.model.tableDataList[indexPath.row];
    [cell displayArea:[self.model getTitleFromAreaType:num.integerValue]
              isCheck:[self.model isCheckWithAreaType:num.integerValue]];
    
    return cell;
}


#pragma mark - UITableView Delegate
/**
 セル選択時の処理
 
 @param tableView 対象テーブルView
 @param indexPath 対象インデックスパス
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = self.model.tableDataList[indexPath.row];
    [self.model changedSelectedArreaType:num.integerValue];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.areaFilterView displayIsAllCheck:[self.model isAllCheck]];
    
    if ([self.delegate respondsToSelector:@selector(areaFilterViewController:didChangeSelectedAreaTypes:)]) {
        
        [self.delegate areaFilterViewController:self didChangeSelectedAreaTypes:self.model.selectedAreaTypes];
    }
}


#pragma mark - AreaFilterView Delegate
/**
 すべてチェックボタン押下時に呼ばれる
 
 @param areaFilterView 対象View
 @param button 対象ボタン
 */
- (void)areaFilterView:(AreaFilterView *)areaFilterView
 didTapAllSelectButton:(UIButton *)button
{
    [self.model setupIsAllCheck:![self.model isAllCheck]];
    [self.areaFilterView.tableView reloadData];
    
    [self.areaFilterView displayIsAllCheck:[self.model isAllCheck]];
}


#pragma mark - Set TableView
/**
 テーブルViewの設定を行う
 */
- (void)setupTableView
{
    self.areaFilterView.tableView.delegate = self;
    self.areaFilterView.tableView.dataSource = self;
    
    NSString *cellName = NSStringFromClass([AreaFilterTableViewCell class]);
    [self.areaFilterView.tableView registerNib:[UINib nibWithNibName:cellName bundle:nil]
         forCellReuseIdentifier:cellName];
}

@end
