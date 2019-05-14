//
//  SBGetPointAccountOutput.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPointAccount.h"
#import "SBMessageArray.h"


@interface SBGetPointAccountOutput : NSObject

@property (strong, nonatomic, readonly) SBPointAccount *pointAccount;
@property (strong, nonatomic, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
