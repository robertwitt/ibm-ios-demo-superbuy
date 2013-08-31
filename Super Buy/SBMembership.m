//
//  SBMembership.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembership.h"


@implementation SBMembership

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // TODO Parse JSON data
    
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    // TODO Decode properties
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    // TODO Encode properties
    
}

@end
