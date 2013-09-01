//
//  SBModelObject.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@implementation SBModelObject

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    return [self initWithJsonData:jsonData header:nil];
}

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super init];
    // Further initialization will be implemented in concrete subclasses
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    // Needs to be overwritten by subclasses
    self = [super init];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // Needs to be overwritten by subclasses
}

- (NSDate *)dateFromString:(NSString *)string
{
    // Parse string into date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFormatter dateFromString:string];
    
    return date;
}

@end
