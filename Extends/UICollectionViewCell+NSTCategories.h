//
//  UICollectionViewCell+NSTRegistration.h
//  
//
//  Created by Timur Bernikowich on 2/15/16.
//
//

#import "NSTCategories.h"

@interface UICollectionViewCell (NSTRegistration)

+ (instancetype)dequeueCellInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
+ (void)registerCellInCollectionView:(UICollectionView *)collectionView;

@end
