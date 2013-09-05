//
//  SBEnterBonusCodeOutput.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMemberActivity.h"
#import "SBPointTransaction.h"
#import "SBMessageArray.h"


@interface SBEnterBonusCodeOutput : NSObject

@property (strong, nonatomic, readonly) SBMemberActivity *activity;
@property (strong, nonatomic, readonly) NSArray *transactions;
@property (strong, nonatomic, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
