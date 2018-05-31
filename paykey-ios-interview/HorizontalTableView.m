//
//  HorizontalScrollView.m
//  paykey-ios-interview
//
//  Created by Ishay Weinstock on 12/16/14.
//  Copyright (c) 2014 Ishay Weinstock. All rights reserved.
//

#import "HorizontalTableView.h"

#define SEPARATOR_WIDTH 1
#define DEFAULT_CELL_WIDTH 100

static NSString *cellIdentifier = @"cell";

@implementation HorizontalTableView


- (UIView*)dequeueCell{
    return nil;
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
}

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    
    [self changeTableViewOrientation];
}

- (void)changeTableViewOrientation
{
    if (!self.tableView)
        return;
    
    // Adjust tableView frame
    int xOrigin = (self.bounds.size.width - self.bounds.size.height) / 2.0;
    int yOrigin = (self.bounds.size.height - self.bounds.size.width) / 2.0;
    self.tableView.frame = CGRectMake(xOrigin, yOrigin, self.bounds.size.height, self.bounds.size.width);
    
    // Apply rotation to tableView
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.bounds.size.height - 5.0);
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEFAULT_CELL_WIDTH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource horizontalTableViewNumberOfCells:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [@(indexPath.row) description];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.contentView.backgroundColor = [UIColor grayColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Match UILabel frame to cell frame
        int xOrigin = (cell.bounds.size.width - cell.bounds.size.height) / 2.0;
        int yOrigin = (cell.bounds.size.height - cell.bounds.size.width) / 2.0;
        cell.textLabel.frame = CGRectMake(xOrigin, yOrigin, cell.bounds.size.height, cell.bounds.size.width);
        // Rotate UILabel and add it to the rotated cell
        cell.textLabel.transform = CGAffineTransformMakeRotation(M_PI/2.0);
        
    });
    
    return cell;
}

@end
