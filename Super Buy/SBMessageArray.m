//
//  SBMessageArray.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMessageArray.h"


@interface SBMessageArray ()

- (NSArray *)messagesWithType:(enum SBMessageType)messageType;

@end


@implementation SBMessageArray

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse message array
    NSMutableArray *messages = [NSMutableArray array];
    
    if (jsonData && ![jsonData isKindOfClass:[NSString class]]) {
        id msgData = [jsonData objectForKey:@"item"];
        
        if ([msgData isKindOfClass:[NSArray class]]) {
            for (NSDictionary *msgDate in msgData) {
                SBMessage *message = [[SBMessage alloc] initWithJsonData:msgDate header:self];
                [messages addObject:message];
            }
        } else {
            SBMessage *message = [[SBMessage alloc] initWithJsonData:msgData header:self];
            [messages addObject:message];
        }
    }
    
    _allMessages = messages;
    
    return self;
}

- (NSArray *)allErrorMessages
{
    return [self messagesWithType:SBMessageTypeError];
}

- (NSArray *)allWarningMessages
{
    return [self messagesWithType:SBMessageTypeWarning];
}

- (NSArray *)allInfoMessages
{
    return [self messagesWithType:SBMessageTypeInfo];
}

- (NSArray *)messagesWithType:(enum SBMessageType)messageType
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.type == %d", messageType];
    return [self.allMessages filteredArrayUsingPredicate:predicate];
}

- (SBMessage *)firstImportantMessage
{
    return self.allErrorMessages.lastObject;
}

@end
