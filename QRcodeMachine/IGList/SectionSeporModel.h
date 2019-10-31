//
//  SectionSeporModel.h
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionSeporModel : NSObject<IGListDiffable>

@property (nonatomic,strong)NSMutableArray *dataArray;
- (instancetype)initWithArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
