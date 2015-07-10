//
//  CoreDataHelper.m
//  employment
//
//  Created by TEDMate on 7/9/15.
//  Copyright (c) 2015 TEDMate. All rights reserved.
//

#import "NECoreDataHelper.h"
#import "NEYearStat.h"
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

@implementation NECoreDataHelper

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSDictionary *)yearStatsWithArray:(NSMutableArray *)array {
    NSMutableDictionary *yearStats = [[NSMutableDictionary alloc] init];
    for(int i=0;i < array.count;i++) {
        NSMutableDictionary *rawMonth = array[i];
        NEYearStat *yearStat = nil;
//        NSLog(@"m: [%@]", rawMonth[@"year"]);
        if(!(yearStat = yearStats[rawMonth[@"year"]])) {
            yearStat = [[NEYearStat alloc] initWithYear: [rawMonth[@"year"] intValue]];
            [yearStats setObject:yearStat forKey:[NSString stringWithFormat: @"%lu", (unsigned long)yearStat.year]];
            if(!yearStat.previousYear) {
                yearStat.previousYear = yearStats[[NSString stringWithFormat:@"%lu", (unsigned long)yearStat.year-1]];
                if(yearStat.previousYear && !yearStat.previousYear.nextYear) yearStat.previousYear.nextYear = yearStat;
            }
            if(!yearStat.nextYear) {
                yearStat.nextYear = yearStats[[NSString stringWithFormat:@"%lu", (unsigned long)yearStat.year+1]];
                if(yearStat.nextYear && !yearStat.nextYear.previousYear) yearStat.nextYear.previousYear = yearStat;
            }
        }
        [yearStat addMonthStat:[[NEMonthStat alloc] initWithDictionary:rawMonth]];
    }
    //NSString *maxYear = [[[yearStats allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)] lastObject];
    
    return yearStats;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.tedmate.coredata" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"coredata" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"coredata.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
