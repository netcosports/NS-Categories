//
//  UICollectionReusableView+NSTRegistration.h
//  beINSPORTS
//
//  Created by Anatoly Shcherbinin on 9/24/19.
//  Copyright © 2019 NETCOSPORTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionReusableView (NSTRegistration)

@property (nonatomic, class, readonly) NSString *defaultIdentifier;

+ (instancetype)dequeueSupplementaryViewOfKind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
+ (void)registerSupplementaryViewOfKind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView;

@end
