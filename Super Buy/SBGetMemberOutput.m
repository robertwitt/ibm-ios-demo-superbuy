//
//  SBGetMemberOutput.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBGetMemberOutput.h"


@implementation SBGetMemberOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _member = [[SBMember alloc] initWithJsonData:[jsonData objectForKey:@"Member"]];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    return self;
}

@end
