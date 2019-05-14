//
//  SBRegisterMembershipInput.m
//  Super Buy
//
//  Created by Robert Witt on 07.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBRegisterMembershipInput.h"


@implementation SBRegisterMembershipInput

- (id)init
{
    self = [super init];
    
    // Initialize all fields to empty strings
    self.lastName = @"";
    self.firstName = @"";
    self.country = @"";
    self.region = @"";
    self.city = @"";
    self.postalCode = @"";
    self.street = @"";
    self.houseNumber = @"";
    self.emailAddress = @"";
    
    return self;
}

- (NSDictionary *)jsonData
{    
    NSDictionary *jsonData = [NSDictionary dictionaryWithObjectsAndKeys:self.lastName, @"lastName",
                                                                        self.firstName, @"firstName",
                                                                        self.country, @"country",
                                                                        self.region, @"region",
                                                                        self.city, @"city",
                                                                        self.postalCode, @"postalCode",
                                                                        self.street, @"street",
                                                                        self.houseNumber, @"houseNumber",
                                                                        self.emailAddress, @"emailAddress",
                                                                        nil];
    return jsonData;
}

@end
