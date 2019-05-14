//
//  SBMembAddress.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembAddress.h"


@implementation SBMembAddress

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    _member = (SBMember *)header;
    
    _country = [jsonData objectForKey:@"Country"];
    _countryText = [jsonData objectForKey:@"CountryText"];
    _region = [jsonData objectForKey:@"Region"];
    _regionText = [jsonData objectForKey:@"RegionText"];
    _city = [jsonData objectForKey:@"City"];
    _postalCode = [jsonData objectForKey:@"PostalCode"];
    _street = [jsonData objectForKey:@"Street"];
    _houseNumber = [jsonData objectForKey:@"HouseNumber"];
    _emailAddress = [jsonData objectForKey:@"EmailAddress"];
    
    return self;
}

@end
