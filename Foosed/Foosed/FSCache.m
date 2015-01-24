//
//  FSCache.m
//  Foosed
//
//  Created by Admin on 1/23/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSCache.h"

@interface FSCache()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation FSCache

#pragma mark - Initialization

+ (id)sharedCache {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}




- (id)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    
    return self;
}

#pragma mark - WSCache

- (void)clear {
    
    [self.cache removeAllObjects];
}


#pragma mark - App
- (NSArray*)allUsers {
    
    NSArray* users;
    
    NSDictionary *attributes = [self attributesForApp];
    if (attributes) {
        users = [attributes objectForKey:[FSCache usersKey]];
    }
    
    if (users) return users;
    
    return nil;
}

- (void)setAllUsers:(NSArray*)users {
    if (users) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesForApp]];
        [attributes setObject:users forKey:[FSCache usersKey]];
        [self setAttributesForApp:attributes];
    }
}

#pragma mark - Keys
+ (NSString *)keyForApp {
    return [NSString stringWithFormat:@"app"];
}

+ (NSString *)usersKey {
    return [NSString stringWithFormat:@"users"];
}


#pragma mark - ()
- (NSDictionary *)attributesForApp {
    NSString *key = [FSCache keyForApp];
    return [self.cache objectForKey:key];
}

- (void)setAttributesForApp:(NSDictionary *)attributes  {
    NSString *key = [FSCache keyForApp];
    [self.cache setObject:attributes forKey:key];
}




@end
