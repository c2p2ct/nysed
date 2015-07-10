//
//  NEMonth.m
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import "NEMonthStat.h"

/*
{
    "series" : "00000000",
    "title" : "Total Nonfarm",
    "area" : "00000",
    "area_name" : "Statewide",
    "current_employment" : "9102200",
    "month" : "3",
    "year" : "2015"
}
*/

@implementation NEMonthStat

-(NEMonthStat*)initWithDictionary:(NSDictionary *)dictionary {
    if(self=[super init]) {
        self.month = [dictionary[@"month"] intValue];
        self.employmentCount = [dictionary[@"current_employment"] intValue];
    }
    return self;
}

-(NEMonthStat*)initWithMonth:(int)month {
    if(self=[super init]) {
        self.month = month;
    }
    return self;
}

- (NSString *)monthName {
    return [[NSDateFormatter new] standaloneMonthSymbols][self.month-1];
}

- (NSString *)toString {
    return [NSString stringWithFormat: @"%@", self.monthName];
}

@end
