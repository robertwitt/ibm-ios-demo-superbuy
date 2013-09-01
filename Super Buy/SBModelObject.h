//
//  SBModelObject.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

@interface SBModelObject : NSObject

- (id)initWithJsonData:(NSDictionary *)jsonData;
- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header;
- (NSDate *)dateFromString:(NSString *)string;

@end
