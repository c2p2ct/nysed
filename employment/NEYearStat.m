//
//  NEYear.m
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import "NEYearStat.h"

@implementation NEYearStat
- (id)init {
    if(self = [super init]) {
        self.monthStats = [NSMutableArray arrayWithCapacity: 12];
        for(int i=0;i < 12;i++)
            [self.monthStats addObject: [NSNull null]];
    }
    return  self;
    
}

-(NEYearStat*)initWithYear:(int)year {
    if(self = [self init]) {
        self.year = year;
    }
    return self;
}

- (void)addMonthStat:(NEMonthStat *)monthStat {
//    NSLog(@"mth: %d", monthStat.month);
    if(monthStat.month <= [self.monthStats count] && monthStat.month > 0) {
        self.monthStats[monthStat.month-1] = monthStat;
    } else {
        NSLog(@"WARN: month value is > 12 -- [%@]", monthStat);
    }
}

- (float)compareMonth:(NEMonthStat*)monthStat1 withMonth: (NEMonthStat*)monthStat2 {
//NSLog(@"ec1: %d, ec2: %d", monthStat1.employmentCount, monthStat2.employmentCount);
    return ((float)(monthStat1.employmentCount - monthStat2.employmentCount))/(float) monthStat2.employmentCount;
}

- (float)compareMonthWithPreviousMonth:(NEMonthStat*) monthStat {
//    NSLog(@"a: %d, %d", monthStat.month , monthStat.month-1);
//    NSLog(@"%d: %@:", monthStat.month, self.previousYear);
    if(monthStat.month == 1 && !self.previousYear) return 0.0f;
    NEMonthStat *pMonthStat = monthStat.month == 1 ? self.previousYear.monthStats.lastObject : self.monthStats[monthStat.month-2];
    return [self compareMonth:monthStat withMonth:pMonthStat];
}

- (float)compareMonthWithPreviousYear:(NEMonthStat *)monthStat {
    if(!self.previousYear) return 0.0f;
    NEMonthStat *pMonthStat = self.previousYear.monthStats[monthStat.month-1];
    return [self compareMonth:monthStat withMonth:pMonthStat];
}

- (void)truncateMonthStatsArray {
    for(int i=0;i < self.monthStats.count;i++) {
        
    }
}

-(NSString*)toString {
    return [NSString stringWithFormat: @"%d", self.year];
}
@end
