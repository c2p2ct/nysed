//
//  CoreDataHelper.h
//  employment
//
//  Created by TEDMate on 7/9/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

@interface NECoreDataHelper : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSMutableDictionary*)yearStatsWithArray:(NSMutableArray*) array;
-(void) saveContext;

@end
