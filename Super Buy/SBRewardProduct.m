//
//  SBRewardProduct.m
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBRewardProduct.h"


@implementation SBRewardProduct

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    self.productCatalog = (SBProductCatalog *)header;
    
    // Parse JSON data
    _productID = [jsonData objectForKey:@"Id"];
    _productDescription = [jsonData objectForKey:@"Description"];
    _category = [jsonData objectForKey:@"Category"];
    _categoryText = [jsonData objectForKey:@"CategoryText"];
    _pointType = [jsonData objectForKey:@"PointType"];
    _pointTypeText = [jsonData objectForKey:@"PointTypeText"];
    _points = [jsonData objectForKey:@"Points"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@)", self.productDescription, self.productID];
}

- (BOOL)isEqual:(id)object
{
    return [self.productID isEqualToString:[object productID]];
}

@end
