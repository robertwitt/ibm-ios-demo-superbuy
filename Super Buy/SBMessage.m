//
//  SBMessage.m
//  Super Buy
//
//  Created by Robert Witt on 26.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMessage.h"


@interface SBMessage ()

- (enum SBMessageType)messageTypeFromString:(NSString *)string;

@end


@implementation SBMessage

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse message
    _ID = [jsonData objectForKey:@"Id"];
    _number = [jsonData objectForKey:@"Number"];
    _type = [self messageTypeFromString:[jsonData objectForKey:@"Type"]];
    _text = [jsonData objectForKey:@"Message"];
    _variable1 = [jsonData objectForKey:@"MessageV1"];
    _variable2 = [jsonData objectForKey:@"MessageV2"];
    _variable3 = [jsonData objectForKey:@"MessageV3"];
    _variable4 = [jsonData objectForKey:@"MessageV4"];
    
    return self;
}

- (enum SBMessageType)messageTypeFromString:(NSString *)string
{
    enum SBMessageType type = SBMessageTypeInfo;
    
    if ([string isEqualToString:@"E"]) {
        type = SBMessageTypeError;
    }
    else if ([string isEqualToString:@"W"]) {
        type = SBMessageTypeWarning;
    }
    
    return type;
}

@end
