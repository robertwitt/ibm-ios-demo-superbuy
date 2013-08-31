//
//  SBMshPointAccount.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBMshPointAccount.h"


@interface SBMshPointAccount : SBModelObject

@property (strong, nonatomic, readonly) NSString *ID;
@property (strong, nonatomic, readonly) NSString *pointType;
@property (strong, nonatomic, readonly) NSString *pointTypeText;
@property (strong, nonatomic, readonly) NSNumber *pointBalance;
@property (strong, nonatomic, readonly) NSDate *lastTransactionDate;

@end
