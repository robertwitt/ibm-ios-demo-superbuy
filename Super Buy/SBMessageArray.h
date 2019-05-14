//
//  SBMessageArray.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBMessage.h"


@interface SBMessageArray : SBModelObject

@property (strong, nonatomic, readonly) NSArray *allMessages;
@property (strong, nonatomic, readonly) NSArray *allErrorMessages;
@property (strong, nonatomic, readonly) NSArray *allWarningMessages;
@property (strong, nonatomic, readonly) NSArray *allInfoMessages;
@property (strong, nonatomic, readonly) SBMessage *firstImportantMessage;

@end
