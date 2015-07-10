//
//  NERemoteData.h
//  employment
//
//  Created by TEDMate on 7/7/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NERemoteDataHelper : NSObject

+(void) fetch:(void (^)(NSMutableArray*))success;

@end
