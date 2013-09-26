//
//  SBMessage.h
//  Super Buy
//
//  Created by Robert Witt on 26.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


enum SBMessageType {
    SBMessageTypeError = 1,
    SBMessageTypeWarning = 2,
    SBMessageTypeInfo = 3,
};


@interface SBMessage : SBModelObject

@property (strong, nonatomic, readonly) NSString *ID;
@property (strong, nonatomic, readonly) NSString *number;
@property (nonatomic, readonly) enum SBMessageType type;
@property (strong, nonatomic, readonly) NSString *text;
@property (strong, nonatomic, readonly) NSString *variable1;
@property (strong, nonatomic, readonly) NSString *variable2;
@property (strong, nonatomic, readonly) NSString *variable3;
@property (strong, nonatomic, readonly) NSString *variable4;

@end
