//
//  YearTableViewController.m
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import "NEYearTableViewController.h"
#import "NEYearStat.h"
#import "NERemoteDataHelper.h"
#import "NECoreDataHelper.h"
#import "NEMonthTableViewController.h"

@interface NEYearTableViewController ()

@property NSMutableArray *yearStats;

@property NEYearStat *selectedYear;

@end

@implementation NEYearTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"fetching data...");
    self.title = @"NYS Employment Stats App";

    [NERemoteDataHelper fetch:^(NSMutableArray *data) {
        NSLog(@"fetched data!");
        NSDictionary *ys = [[NECoreDataHelper new] yearStatsWithArray:data];
        NSSortDescriptor *order = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:false];
        self.yearStats = [NSMutableArray arrayWithArray:[[ys allValues] sortedArrayUsingDescriptors:@[order]]];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yearStats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yearCell" forIndexPath:indexPath];
    NEYearStat *yearStat = self.yearStats[[indexPath row]];

    [cell.textLabel setText: [yearStat toString]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Clicked tablView at index [%lu]", (unsigned long)[indexPath row]);
    NEYearStat *yearStat = self.yearStats[[indexPath row]];
    if(yearStat) {
        self.selectedYear = yearStat;
        [self performSegueWithIdentifier:@"NEMonthTableViewController" sender:self];
    }
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nc = (UINavigationController*) segue.destinationViewController;
    nc.navigationItem.hidesBackButton = NO;
    NEMonthTableViewController *mtvc = [nc.viewControllers firstObject];
    
    mtvc.yearStat = self.selectedYear;
}

@end
