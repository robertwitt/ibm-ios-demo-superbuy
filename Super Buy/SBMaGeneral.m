//
//  SBMaGeneral.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMaGeneral.h"


@implementation SBMaGeneral

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    self.activity = (SBMemberActivity *)header;
    
    // Parse data
    _ID = [jsonData objectForKey:@"Id"];
    _catgory = [jsonData objectForKey:@"Category"];
    _processType = [jsonData objectForKey:@"ProcessType"];
    _activityDate = [self dateFromString:[jsonData objectForKey:@"ActivityDate"]];
    _status = [jsonData objectForKey:@"Status"];
    _statusText = [jsonData objectForKey:@"StatusText"];
    _errorCode = [jsonData objectForKey:@"ErrorCode"];
    _errorCodeText = [jsonData objectForKey:@"ErroCodeText"];
    _membershipID = [jsonData objectForKey:@"MembershipId"];
    _memberID = [jsonData objectForKey:@"MemberId"];
    
    return self;
}

@end
