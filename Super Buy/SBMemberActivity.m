//
//  SBMemberActivity.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMemberActivity.h"


@implementation SBMemberActivity

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    _general = [jsonData objectForKey:@"General"];
    _specific = [jsonData objectForKey:@"Specific"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Member activity %@", self.general.ID];
}

- (BOOL)isEqual:(id)object
{
    return [self.general.ID isEqualToString:[[object general] ID]];
}

@end
