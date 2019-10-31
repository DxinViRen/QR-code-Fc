//
//  HomeMainModel.m
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "HomeMainModel.h"

@implementation HomeMainModel
@synthesize cellHeight;
@synthesize cellName;
@synthesize cellInderfier;
@synthesize cellWight;
@synthesize extra;
- (instancetype)init
{
    self = [super init];
    if (self) {
          
         
        self.cellWight = Scr_w;
    
        self.extra = [@{} mutableCopy];
    }
    return self;
}


@end
