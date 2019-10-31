//
//  MainCollectionViewCell.h
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCellModeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)id<MainCellModeProtocol> model;
@end

NS_ASSUME_NONNULL_END
