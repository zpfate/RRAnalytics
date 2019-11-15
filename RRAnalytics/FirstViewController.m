//
//  FirstViewController.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/14.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "FirstViewController.h"
#import "ButtonViewController.h"
#import "GestureViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "ListViewController.h"


@interface FirstViewController ()

@property (nonatomic, strong) NSArray *arr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor redColor];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setTitle:@"右边" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.arr = @[@"Button点击", @"手势点击", @"UITableView点击", @"UICollectionView点击", @"手写TableView"];
}

- (void)rightAction:(UIButton *)button {
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.arr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSLog(@"section == %zd, row == %zd", indexPath.section, indexPath.row);

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[ButtonViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[GestureViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[TableViewController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[CollectionViewController new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[ListViewController new] animated:YES];
            break;
        default:
            break;
    }
    
}

@end
