//
//  NEYear.h
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEMonthStat.h"

@interface NEYearStat : NSObject

@property int year;
@property NEYearStat *previousYear;
@property NEYearStat *nextYear;
@property NSMutableArray* monthStats;

-(NEYearStat*) initWithYear: (int) year;
-(void)addMonthStat:(NEMonthStat*) monthStat;
-(float)compareMonth: (NEMonthStat*) monthStat1 withMonth: (NEMonthStat*) monthStat2;
-(float)compareMonthWithPreviousMonth: (NEMonthStat*) monthStat;
-(float)compareMonthWithPreviousYear: (NEMonthStat*) monthStat;
-(void)truncateMonthStatsArray;
-(NSString*) toString;

@end
