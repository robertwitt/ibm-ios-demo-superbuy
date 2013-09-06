//
//  SBGetRewardProductCatalogOutput.h
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBProductCatalog.h"
#import "SBMessageArray.h"


@interface SBGetRewardProductCatalogOutput : NSObject

@property (strong, nonatomic, readonly) SBProductCatalog *productCatalog;
@property (strong, nonatomic, readonly) SBMessageArray *messages;

- (id)initWithJsonData:(NSDictionary *)jsonData;

@end
