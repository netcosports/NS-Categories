//
//  UICollectionReusableView+NSTRegistration.m
//  beINSPORTS
//
//  Created by Anatoly Shcherbinin on 9/24/19.
//  Copyright © 2019 NETCOSPORTS. All rights reserved.
//

#import "NSTCategories.h"

@implementation UICollectionReusableView (NSTRegistration)

+ (NSString *)defaultIdentifier
{
    return NSStringFromClass(self);
}

+ (void)registerSupplementaryViewOfKind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:self forSupplementaryViewOfKind:kind withReuseIdentifier:self.defaultIdentifier];
}

+ (instancetype)dequeueSupplementaryViewOfKind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:self.defaultIdentifier forIndexPath:indexPath];
}

@end
