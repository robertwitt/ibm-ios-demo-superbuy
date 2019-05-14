//
//  SBRegisterMembershipOutput.h
//  Super Buy
//
//  Created by Robert Witt on 07.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMember.h"
#import "SBMembership.h"
#import "SBMessageArray.h"


@interface SBRegisterMembershipOutput : NSObject

@property (strong, nonatomic, readonly) SBMember *member;
@property (strong, nonatomic, readonly) SBMembership *membership;
@property (strong, nonatomic, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
