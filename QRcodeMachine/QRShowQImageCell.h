//
//  QRShowQImageCell.h
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "MainCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^QRCacheImageBlock)(void);
@interface QRShowQImageCell : MainCollectionViewCell
@property  (nonatomic,copy)QRCacheImageBlock qrblock;
@end

NS_ASSUME_NONNULL_END
