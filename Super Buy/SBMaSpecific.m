//
//  SBMaSpecific.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMaSpecific.h"


@implementation SBMaSpecific

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    _activity = (SBMemberActivity *)header;
    
    // Parse JSON data
    _pointType = [jsonData objectForKey:@"PointType"];
    _pointTypeText = [jsonData objectForKey:@"PointTypeText"];
    _points = [jsonData objectForKey:@"Points"];
    _qualificationType = [jsonData objectForKey:@"QualType"];
    _qualificationTypeText = [jsonData objectForKey:@"QualTypeText"];
    _productID = [jsonData objectForKey:@"ProductId"];
    _productDescription = [jsonData objectForKey:@"ProductDesc"];
    _quantity = [jsonData objectForKey:@"Quantity"];
    _quantityUnit = [jsonData objectForKey:@"QuantityUnit"];
    _amount = [jsonData objectForKey:@"Amount"];
    _currency = [jsonData objectForKey:@"Currency"];
    
    return self;
}

@end
