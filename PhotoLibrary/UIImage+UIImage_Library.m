//
//  UIImage+UIImage_Library.m
//  Extends
//
//  Created by Guillaume Derivery on 09/12/15.
//  Copyright © 2015 Netco Sports. All rights reserved.
//

#import <Photos/Photos.h>
#import "UIImage+UIImage_Library.h"
#import <NSTCategories/NSUsefulDefines.h>

@implementation UIImage (UIImage_Library)

#pragma mark Class methods
+(NSArray *) getImagesFromLibraryAfter:(NSDate *)date
{
    __block NSMutableArray *images = [NSMutableArray new];
    PHFetchResult *fetchResult = [UIImage getImagesFromPhotoLibraryOrderedByCreationDate];
    
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (EXISTS(asset, [PHAsset class]) && [asset.creationDate compare:date] == NSOrderedAscending) // asset.creationDate is earlier than date
         {
             [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info)
              {
                  if (result)
                      [images addObject:result];
              }];
         }
     }];
    return images;
}

+(NSArray *) getLatestImagesFromLibraryLimitedTo:(NSUInteger)limit
{
    __block NSMutableArray *images = [NSMutableArray new];
    PHFetchResult *fetchResult = [UIImage getImagesFromPhotoLibraryOrderedByCreationDate];
    
    [fetchResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (EXISTS(asset, [PHAsset class]))
         {
             [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage *result, NSDictionary *info)
              {
                  if (result)
                      [images addObject:result];
                  
                  if (idx + 1 == limit)
                      *stop = YES;
              }];
         }
     }];
    return images;
}

+(PHFetchResult *)getImagesFromPhotoLibraryOrderedByCreationDate
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    return [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
}

#pragma mark Instance methods
-(void) saveToLibraryInAlbum:(NSString *)album withCompletionBlock:(void(^)(BOOL success, NSError *error))completion
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
     {
         if (status == PHAuthorizationStatusAuthorized)
         {
             // To preserve the metadata, we create an asset from the JPEG NSData representation.
             // Note that creating an asset from a UIImage discards the metadata.
             // In iOS 9, we can use -[PHAssetCreationRequest addResourceWithType:data:options].
             // In iOS 8, we save the image to a temporary file and use +[PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:].
             NSData *imageData = UIImageJPEGRepresentation(self, 0.8);
             if ([PHAssetCreationRequest class])
             {
                 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^(void)
                  {
                      [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                  } completionHandler:^(BOOL success, NSError *error)
                  {
                      if (!success)
                      {
                          DLog( @"Error occurred while saving image to photo library: %@", error );
                      }
                      if (completion)
                          completion(success, error);
                  }];
             }
             else
             {
                 NSString *temporaryFileName = [NSProcessInfo processInfo].globallyUniqueString;
                 NSString *temporaryFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[temporaryFileName stringByAppendingPathExtension:@"jpg"]];
                 NSURL *temporaryFileURL = [NSURL fileURLWithPath:temporaryFilePath];
                 
                 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^(void)
                  {
                      NSError *error = nil;
                      [imageData writeToURL:temporaryFileURL options:NSDataWritingAtomic error:&error];
                      if (error)
                      {
                          DLog( @"Error occured while writing image data to a temporary file: %@", error );
                      }
                      else
                      {
                          [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:temporaryFileURL];
                      }
                  } completionHandler:^(BOOL success, NSError *error)
                  {
                      if (!success)
                      {
                          DLog( @"Error occurred while saving image to photo library: %@", error );
                      }
                      
                      // Delete the temporary file.
                      [[NSFileManager defaultManager] removeItemAtURL:temporaryFileURL error:nil];
                      if (completion)
                          completion(success, error);
                  }];
             }
         }
     }];
}
    
@end
