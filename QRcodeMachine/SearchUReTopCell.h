//
//  SearchUReTopCell.h
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/29.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "MainCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^VisitLineBlock)(NSString *adress);
@interface SearchUReTopCell : MainCollectionViewCell
@property (nonatomic,copy)VisitLineBlock visLineBlock;
@end

NS_ASSUME_NONNULL_END
