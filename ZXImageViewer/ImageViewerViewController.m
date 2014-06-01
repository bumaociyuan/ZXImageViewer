//
//  ImageViewerViewController.m
//  lenovoRelonline
//
//  Created by zx on 2/25/14.
//  Copyright (c) 2014 noteant-6. All rights reserved.
//

#import "ImageViewerViewController.h"

@interface ImageViewerViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, assign) int index;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ImageViewerViewController

+ (instancetype)imageViewerWithImages:(NSArray *)images index:(int)index {
    ImageViewerViewController *vc= [self instanceFromStoryBoard];
    vc.images = images;
    vc.index = index;
    
    return vc;
}

+ (instancetype)imageViewerWithImageUrls:(NSArray *)imageUrls index:(int)index {
    ImageViewerViewController *vc= [self instanceFromStoryBoard];
    vc.imageUrls = imageUrls;
    vc.index = index;
    return vc;
}

- (void)initializeUserInterface {
    if (self.images.count) {
        
        self.scrollView.contentSize = CGSizeMake(320*self.images.count, self.scrollView.height-44);
        [self.images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc]initWithImage:obj];
            [imageView sizeToFit];
            float width  = imageView.frame.size.width;
            float height = imageView.frame.size.height;
            imageView.width = 320;
            imageView.height = height / width * 320;
    
            [self.scrollView addSubview:imageView];
//            imageView.frame = CGRectMake(320*idx, 0, 320, 240);
            imageView.midY = self.scrollView.height/2;
        }];
    }else {
        self.scrollView.contentSize = CGSizeMake(320*self.imageUrls.count, self.scrollView.height-44);
        [self.imageUrls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [UIImageView new];
            [imageView loadImageFromURLString:obj completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [imageView sizeToFit];
                float width  = imageView.width;
                float height = imageView.height;
                imageView.width = 320;
                imageView.height = height / width * 320;
                imageView.midY = self.scrollView.height/2;
            }];
            [self.scrollView addSubview:imageView];
//            imageView.frame = CGRectMake(320*idx, 0, 320, 240);
//            imageView.midY = self.scrollView.height/2;
            imageView.x = 320* idx;
        }];
    }
    self.scrollView.contentOffset = CGPointMake(320*self.index, 0);
    self.title = [NSString stringWithFormat:@"%d/%d",self.index + 1,self.images.count?self.images.count:self.imageUrls.count];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger count = self.imageUrls.count?self.imageUrls.count:self.images.count;
    NSInteger index = roundf(scrollView.contentOffset.x / 320.0);
    self.title = [NSString stringWithFormat:@"%d/%d",index+1,count];
}
@end
