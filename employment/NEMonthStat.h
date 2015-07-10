//
//  NEMonth.h
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEMonthStat : NSObject

@property int month;
@property (readonly) NSString *monthName;
@property int employmentCount;
@property NSString *type;

-(NEMonthStat*) initWithDictionary:(NSDictionary*) dictionary;
-(NEMonthStat*) initWithMonth: (int) month;
-(NSString*) toString;

@end
