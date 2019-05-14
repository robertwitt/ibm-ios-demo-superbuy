//
//  SBMember.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMember.h"


@implementation SBMember

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    _ID = [jsonData objectForKey:@"Id"];
    _name = [jsonData objectForKey:@"Name"];
    _addressShort = [jsonData objectForKey:@"AddressShort"];
    
    NSString *type = [jsonData objectForKey:@"Type"];
    if ([type isEqualToString:@"1"]) {
        _type = SBMembTypePerson;
    } else if ([type isEqualToString:@"2"]) {
        _type = SBMembTypeOrganization;
    } else if ([type isEqualToString:@"3"]) {
        _type = SBMembTypeGroup;
    }
    
    _address = [[SBMembAddress alloc] initWithJsonData:[jsonData objectForKey:@"Address"] header:self];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (ID %@)", self.name, self.ID];
}

- (BOOL)isEqual:(id)object
{
    return [self.ID isEqualToString:[object ID]];
}

@end
