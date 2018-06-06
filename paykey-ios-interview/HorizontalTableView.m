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

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    
    if(!self.scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView = scrollView;
    }
    [self setScrollView:self.scrollView];
}

-(void)setScrollView:(UIScrollView *)scrollView{
    
    _scrollView = scrollView;
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * [self.dataSource horizontalTableViewNumberOfCells:self] / 3, 100);
    self.scrollView.showsHorizontalScrollIndicator = YES;
    [self.scrollView setUserInteractionEnabled:YES];
    self.scrollView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    
    [self addSubview:_scrollView];
    
    [self initData];
    
    [self createPage:0];
    
}

-(void)initData
{
    self.labelViews  = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.dataSource horizontalTableViewNumberOfCells:self]; i++) {
        [self.labelViews addObject:[NSNull null]];
    }
    
}

-(void)createPage:(int)page
{
    
    if (page < 0) return;
    if (page >= [self.dataSource horizontalTableViewNumberOfCells:self] / 3) return;
    
    for (int i=page * 3; i <= page * 3 + 3; i++) {
        
        
        UILabel *label = [self.labelViews objectAtIndex:i];
        
        if ((NSNull *)label == [NSNull null]) {
            
            label = (UILabel*)[self.dataSource horizontalTableView:self cellForIndex:i];
            [self.labelViews replaceObjectAtIndex:i withObject:label];
            
        }
        
        if (label != nil && label.superview == nil) {
            CGRect frame = self.scrollView.frame;
            frame.origin.x = frame.size.width * i / 3;
            frame.origin.y = 0;
            frame.size.width = self.frame.size.width / 3;
            label.frame = frame;
            [self.scrollView addSubview:label];
            
        }
        
    }
    
}

-(void) resetNotVisibleLabels {
    
    int previousPage = self.currentPage - 2;
    int nextPage = self.currentPage + 2;
    
    if(previousPage < 0 || nextPage * 3 + 3 >= [self.dataSource horizontalTableViewNumberOfCells:self]){return;}
    
    for (int i=previousPage * 3; i <= previousPage * 3 + 2; i++) {
        
        UILabel *label = [self.labelViews objectAtIndex:i];
        if ((NSNull *)label != [NSNull null]) {
            [label removeFromSuperview];
            [self.labelViews replaceObjectAtIndex:i withObject:[NSNull null]];
        }
        
    }
    
    for (int i=nextPage * 3; i <= nextPage * 3 + 2; i++) {
        
        UILabel *label = [self.labelViews objectAtIndex:i];
        if ((NSNull *)label != [NSNull null]) {
            [label removeFromSuperview];
            [self.labelViews replaceObjectAtIndex:i withObject:[NSNull null]];
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth) / pageWidth) + 1;
    
    if(self.currentPage != page) {
        self.currentPage = page;
        [self createPage:page - 1];
        [self createPage:page];
        [self createPage:page + 1];
        [self resetNotVisibleLabels];
    }
    
}
@end
