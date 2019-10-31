//
//  SearchUreVCtopCell.h
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/29.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "MainCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^VisitLineBlock)(NSString *adress);
@interface SearchUreVCtopCell : MainCollectionViewCell
@property (nonatomic,copy)NSString *data;
@property (nonatomic,copy)VisitLineBlock visLineBlock;
@end

NS_ASSUME_NONNULL_END
