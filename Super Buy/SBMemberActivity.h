//
//  SBMemberActivity.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBMaGeneral.h"
#import "SBMaSpecific.h"


@interface SBMemberActivity : SBModelObject

@property (strong, nonatomic, readonly) SBMaGeneral *general;
@property (strong, nonatomic, readonly) SBMaSpecific *specific;

@end
