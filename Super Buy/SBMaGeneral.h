//
//  SBMaGeneral.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@class SBMemberActivity;

@interface SBMaGeneral : SBModelObject

@property (strong, nonatomic) SBMemberActivity *activity;

@property (strong, nonatomic, readonly) NSString *ID;
@property (strong, nonatomic, readonly) NSString *catgory;
@property (strong, nonatomic, readonly) NSString *processType;
@property (strong, nonatomic, readonly) NSDate *activityDate;
@property (strong, nonatomic, readonly) NSString *status;
@property (strong, nonatomic, readonly) NSString *statusText;
@property (strong, nonatomic, readonly) NSString *errorCode;
@property (strong, nonatomic, readonly) NSString *errorCodeText;
@property (strong, nonatomic, readonly) NSString *membershipID;
@property (strong, nonatomic, readonly) NSString *memberID;

@end
