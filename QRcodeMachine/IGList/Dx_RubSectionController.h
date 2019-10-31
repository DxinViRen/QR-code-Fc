//
//  Dx_RubSectionController.h
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "IGListSectionController.h"
#import "SectionSeporModel.h"
#import "MainCollectionViewCell.h"
#import "MainCellModeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Dx_RubSectionController : IGListSectionController
@property (nonatomic,copy)void(^cellDidClickBlock)(id<MainCellModeProtocol> model,NSInteger index); //cell 的点击事件
@property (nonatomic,copy)void (^configCellBlocck)(id<MainCellModeProtocol> model,NSInteger index,MainCollectionViewCell *cell);

@property(nonatomic,strong)SectionSeporModel *object;

- (void)configCell:(MainCollectionViewCell *)cell  withModel:(id<MainCellModeProtocol>)model index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
