//
//  SBRegisterMembershipInput.h
//  Super Buy
//
//  Created by Robert Witt on 07.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

@interface SBRegisterMembershipInput : NSObject

@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *houseNumber;
@property (strong, nonatomic) NSString *emailAddress;

@property (strong, nonatomic, readonly) NSDictionary *jsonData;

@end
