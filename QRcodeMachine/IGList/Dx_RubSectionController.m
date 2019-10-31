//
//  Dx_RubSectionController.m
//  RubbishVitor
//
//  Created by D.xin on 2019/10/24.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "Dx_RubSectionController.h"
#import "MainCollectionViewCell.h"
@implementation Dx_RubSectionController
- (void)configCell:(MainCollectionViewCell *)cell withModel:(id<MainCellModeProtocol>)model index:(NSInteger)index
{
    if(self.configCellBlocck)
    {
        self.configCellBlocck(model, index,cell);
    }
    
    cell.model = model;
}
- (NSInteger)numberOfItems
{
    return self.object.dataArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
   
    id<MainCellModeProtocol> model = [self.object.dataArray  dx_objectAtIndex:index];

    if([model respondsToSelector:@selector(cellHeight)])
    {
        return CGSizeMake(model.cellWight, model.cellHeight);
    }

    return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    //因为默认设置了Header和Footer所以需要特殊处理
    
    id<MainCellModeProtocol> model = [self.object.dataArray dx_objectAtIndex:index];
    NSString *cellIndefier = model.cellInderfier;
    MainCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:NSClassFromString(model.cellName) withReuseIdentifier:cellIndefier forSectionController:self atIndex:index];
    [self configCell:cell withModel:model index:index];
    return cell;
}

- (void)didUpdateToObject:(id)object
{
    self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
     if(self.cellDidClickBlock)
          {
              self.cellDidClickBlock([self.object.dataArray dx_objectAtIndex:index], index);
          }
}

@end
