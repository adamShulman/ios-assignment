//
//  HorizontalScrollView.h
//  paykey-ios-interview
//
//  Created by Ishay Weinstock on 12/16/14.
//  Copyright (c) 2014 Ishay Weinstock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalTableView;

@protocol HorizontalTableViewDataSource <NSObject>

- (UIView*)horizontalTableView:(HorizontalTableView*)tableView cellForIndex:(NSInteger)index;
- (NSInteger)horizontalTableViewNumberOfCells:(HorizontalTableView*)tableView;

@end

@interface HorizontalTableView : UIView <UIScrollViewDelegate>

@property (weak)   id<HorizontalTableViewDataSource>    dataSource;
@property (assign) CGFloat                              cellWidth;
@property (strong, nonatomic) UIScrollView*             scrollView;
@property (nonatomic,assign) int currentPage;
@property (strong, nonatomic) NSMutableArray*             labelViews;

- (UIView*)dequeueCell;


@end
