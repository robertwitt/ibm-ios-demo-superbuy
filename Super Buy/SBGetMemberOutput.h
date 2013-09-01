//
//  SBGetMemberOutput.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMember.h"
#import "SBMessageArray.h"


@interface SBGetMemberOutput : NSObject

@property (strong, nonatomic, readonly) SBMember *member;
@property (strong, nonatomic, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
