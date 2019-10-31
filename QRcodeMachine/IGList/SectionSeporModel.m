//
//  SectionSeporModel.m
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "SectionSeporModel.h"

@implementation SectionSeporModel
- (instancetype)initWithArray:(NSMutableArray *)array{
    if(self = [super init]){
        self.dataArray = array;
    }
    return self;
}

#pragma mark - IGListDiffable
- (id<NSObject>)diffIdentifier
{
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object
{
    return [self isEqual:object];
}
@end
