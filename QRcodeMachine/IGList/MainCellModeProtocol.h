//
//  MainCellModeProtocol.h
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainCellModeProtocol <NSObject>
@property(nonatomic,assign)CGFloat  cellHeight;
@property(nonatomic,copy)NSString *cellName;
@property(nonatomic,copy)NSString *cellInderfier;
@property(nonatomic,assign)CGFloat cellWight;
@property(nonatomic,strong)NSMutableDictionary *extra;
@end

NS_ASSUME_NONNULL_END
