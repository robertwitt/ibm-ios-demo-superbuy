//
//  SBMember.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBMembAddress.h"


enum SBMembType {
    SBMembTypePerson = 1,
    SBMembTypeOrganization = 2,
    SBMembTypeGroup = 3
    };


@interface SBMember : SBModelObject

@property (strong, nonatomic, readonly) NSString *ID;
@property (strong, nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) enum SBMembType type;
@property (strong, nonatomic, readonly) NSString *addressShort;
@property (strong, nonatomic, readonly) SBMembAddress *address;

@end
