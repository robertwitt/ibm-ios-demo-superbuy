//
//  SBGetMembershipOutput.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembership.h"
#import "SBMessageArray.h"


@interface SBGetMembershipOutput : NSObject

@property (nonatomic, strong, readonly) SBMembership *membership;
@property (nonatomic, strong, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
