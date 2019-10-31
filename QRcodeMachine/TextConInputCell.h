//
//  TextConInputCell.h
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/30.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "MainCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^TurnBlock)(NSString *text);
@interface TextConInputCell : MainCollectionViewCell
@property (nonatomic,copy)TurnBlock turnBlock;
@end

NS_ASSUME_NONNULL_END
