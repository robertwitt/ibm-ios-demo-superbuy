//
//  SBValidateMembershipOutput.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMessageArray.h"


@interface SBValidateMembershipOutput : NSObject

@property (nonatomic, getter = isMembershipValid, readonly) BOOL membershipValid;
@property (strong, nonatomic, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
