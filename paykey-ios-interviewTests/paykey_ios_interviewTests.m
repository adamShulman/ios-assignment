//
//  paykey_ios_interviewTests.m
//  paykey-ios-interviewTests
//
//  Created by ishay weinstock on 29/11/2017.
//  Copyright © 2017 ishay weinstock. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController+Private.h"

@interface paykey_ios_interviewTests : XCTestCase

@property (strong) ViewController* vc;

@end

@implementation paykey_ios_interviewTests

- (void)setUp {
    [super setUp];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"HorizontalTableViewVC"];
    [self.vc performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testVcConformsToHorizontalTableViewDataSource{
    
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(HorizontalTableViewDataSource) ], @" VC does not conform to Horizontal view datasource");
}

-(void)testHorizontalViewInitiated{
    
    XCTAssertNotNil(self.vc.horizontalTableView, @"Horizontal view not initiated");
}

-(void)testHorizontalViewConformsToDataSource{
    
    XCTAssertTrue([self.vc.horizontalTableView conformsToProtocol:@protocol(UITableViewDataSource) ], @" Horizontal view does not conform to datasource");
}

-(void)testTableViewInitiated
{
    XCTAssertNotNil(self.vc.horizontalTableView.tableView, @"TableView not initiated");
}


- (void)testTableViewHasDataSource
{
    XCTAssertNotNil(self.vc.horizontalTableView.tableView.dataSource, @"TableView datasource cannot be nil");
}

- (void)testTableViewConnectedToDelegate
{
    XCTAssertNotNil(self.vc.horizontalTableView.tableView.delegate, @"TableView not connected to delegate");
}

- (void)testTableViewConformsToDelegate
{
    XCTAssertTrue([self.vc.horizontalTableView conformsToProtocol:@protocol(UITableViewDelegate) ], @"TableView does not conform to delegate");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = 100;
    XCTAssertTrue([self.vc.horizontalTableView tableView:self.vc.horizontalTableView.tableView numberOfRowsInSection:0]==expectedRows, @" Wrong number of tableView rows");
}

- (void)testTableViewReuseIdentifier
{
    UITableViewCell *cell = [self.vc.horizontalTableView tableView:self.vc.horizontalTableView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:@"cell"], @"TableView not reuse cells ");
}

@end
