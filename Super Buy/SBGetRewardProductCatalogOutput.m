//
//  SBGetRewardProductCatalogOutput.m
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBGetRewardProductCatalogOutput.h"


@implementation SBGetRewardProductCatalogOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _productCatalog = [[SBProductCatalog alloc] initWithJsonData:[jsonData objectForKey:@"ProductCatalog"]];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    return self;
}

@end
