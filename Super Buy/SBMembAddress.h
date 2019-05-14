//
//  SBMembAddress.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@class SBMember;

@interface SBMembAddress : SBModelObject

@property (strong, nonatomic) SBMember *member;

@property (strong, nonatomic, readonly) NSString *country;
@property (strong, nonatomic, readonly) NSString *countryText;
@property (strong, nonatomic, readonly) NSString *region;
@property (strong, nonatomic, readonly) NSString *regionText;
@property (strong, nonatomic, readonly) NSString *city;
@property (strong, nonatomic, readonly) NSString *postalCode;
@property (strong, nonatomic, readonly) NSString *street;
@property (strong, nonatomic, readonly) NSString *houseNumber;
@property (strong, nonatomic, readonly) NSString *emailAddress;

@end
