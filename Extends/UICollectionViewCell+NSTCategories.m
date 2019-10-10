//
//  UICollectionViewCell+NSTRegistration.m
//  
//
//  Created by Timur Bernikowich on 2/15/16.
//
//

#import "NSTCategories.h"

@implementation UICollectionViewCell (NSTRegistration)

+ (void)registerCellInCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:self
       forCellWithReuseIdentifier:self.defaultIdentifier];
}

+ (instancetype)dequeueCellInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:self.defaultIdentifier
                                                     forIndexPath:indexPath];
}

@end
