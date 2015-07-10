//
//  NEMonthTableViewController.m
//  employment
//
//  Created by TEDMate on 7/10/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import "NEMonthTableViewController.h"

@interface NEMonthTableViewController ()

@end

int const YEAR_LABEL = 100;
int const PREVIOUS_MONTH_LABEL = 101;
int const YEAR_ON_YEAR_LABEL = 102;
int const EMPLOYMENT_COUNT_LABEL = 103;

@implementation NEMonthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat: @"Statistics for %d", self.yearStat.year];
    long previousIndex = [[self.navigationController viewControllers] indexOfObject: self] - 1;
    if(previousIndex > 0) {
        UIViewController *vc = [[self.navigationController viewControllers] objectAtIndex:previousIndex];
        vc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStylePlain target:self action: nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.yearStat.monthStats count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthCell" forIndexPath:indexPath];
    NEMonthStat *monthStat = self.yearStat.monthStats[[indexPath row]];
    if(monthStat != (id) [NSNull null]) {
//        NSLog(@"%@ selected at row [%d]", monthStat.monthName, [indexPath row]);
        [[cell textLabel] setHidden: YES];
        
        ((UILabel*)[cell viewWithTag:YEAR_LABEL]).text = monthStat.monthName;
        ((UILabel*)[cell viewWithTag:EMPLOYMENT_COUNT_LABEL]).text = [self formatIntValue: monthStat.employmentCount];
        UILabel *lblPMValue = (UILabel*)[cell viewWithTag:PREVIOUS_MONTH_LABEL];
        UILabel *lblYoYValue = (UILabel*)[cell viewWithTag:YEAR_ON_YEAR_LABEL];
        
        float pmValue = [self.yearStat compareMonthWithPreviousMonth:monthStat];
        float yoyValue = [self.yearStat compareMonthWithPreviousYear:monthStat];
        
        lblPMValue.text = [self formatPercentageValue: pmValue];
        lblPMValue.textColor = [self getColorFromValue: pmValue];
        lblYoYValue.text = [self formatPercentageValue: yoyValue];
        lblYoYValue.textColor = [self getColorFromValue:yoyValue];
    } else {
        [cell textLabel].text = @"No data available";
        [[cell textLabel] setHidden: NO];
    }

    return cell;
}

- (UIColor*) getColorFromValue: (float)value {
    if(value > 0.0f)
        return [UIColor greenColor];
    else if(value < 0.0f)
        return [UIColor redColor];
    else
        return [UIColor grayColor];
}

- (NSString*) formatPercentageValue: (float)value {
    NSNumberFormatter* numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    [numberFormatter setMaximumFractionDigits:2];
    return [numberFormatter stringFromNumber: [NSNumber numberWithFloat: value]];
}

- (NSString*) formatIntValue: (int) value {
    NSNumberFormatter* numberFormatter = [NSNumberFormatter new];
    [numberFormatter setLocale:[NSLocale currentLocale]];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:0];
    return [numberFormatter stringFromNumber: [NSNumber numberWithInt: value]];
}

@end
