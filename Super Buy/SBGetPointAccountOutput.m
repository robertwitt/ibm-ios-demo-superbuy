//
//  SBGetPointAccountOutput.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBGetPointAccountOutput.h"


@implementation SBGetPointAccountOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _pointAccount = [[SBPointAccount alloc] initWithJsonData:[jsonData objectForKey:@"PointAccount"]];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    return self;
}

@end
