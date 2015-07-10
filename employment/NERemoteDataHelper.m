//
//  NERemoteData.m
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import "NERemoteDataHelper.h"

@implementation NERemoteDataHelper

static NSString* const NYOpenDataUrl = @"https://data.ny.gov/resource/6k74-dgkb.json";
static NSMutableArray *data;
/**** SAMPLE DATA ****
 
 [ {
 "series" : "00000000",
 "title" : "Total Nonfarm",
 "area" : "00000",
 "area_name" : "Statewide",
 "current_employment" : "9276300",
 "month" : "5",
 "year" : "2015"
 }
 , {
 "series" : "00000000",
 "title" : "Total Nonfarm",
 "area" : "00000",
 "area_name" : "Statewide",
 "current_employment" : "9174000",
 "month" : "4",
 "year" : "2015"
 }
 , {
 "series" : "00000000",
 "title" : "Total Nonfarm",
 "area" : "00000",
 "area_name" : "Statewide",
 "current_employment" : "9102200",
 "month" : "3",
 "year" : "2015"
 }]
 */

+(void)fetch:(void (^)(NSMutableArray *))success {
    NSURL *url = [NSURL URLWithString:NYOpenDataUrl];
    NSURLRequest *rq = [NSURLRequest requestWithURL: url];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:rq];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        data = [NSMutableArray arrayWithArray:(NSArray*)responseObject];
        success(data);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error fetching data!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];
    
    [op start];
}

@end
