//
//  ZXImageViewerViewController.m
//  ZXImageViewerDemo
//
//  Created by Mac Mini on 6/1/14.
//  Copyright (c) 2014 com.zx. All rights reserved.
//

#import "ZXImageViewerViewController.h"
#import "FrameAccessor.h"
@interface ZXImageViewerViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation ZXImageViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTitle];
    [self updateUI];
}

- (void)setupScrollView {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];
}

- (void)updateTitle {
    NSInteger count = self.imageUrls.count?self.imageUrls.count:self.images.count;
    NSInteger index = self.index;
    self.title = [NSString stringWithFormat:@"%d/%d",index+1,count];
}

- (void)updateUI {
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
            
            //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:obj]];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"error = %@",error.localizedDescription);
                }else {
//                    NSString *fileName = [obj lastPathComponent];
//                    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                    NSString *path = [docs[0] stringByAppendingPathComponent:fileName];
//                    NSURL *toURL = [NSURL fileURLWithPath:path];
//                    [[NSFileManager defaultManager] copyItemAtURL:location toURL:toURL error:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [[UIImage alloc] initWithContentsOfFile:location.path];
                        imageView.image = image;
                        [imageView sizeToFit];
                        float width  = imageView.width;
                        float height = imageView.height;
                        imageView.width = 320;
                        imageView.height = height / width * 320;
                        imageView.midY = self.scrollView.height/2;
                        
                    });
                }
                
                
                
            }];
            [task resume];
            
            
            //                dispatch_async(dispatch_get_main_queue(), ^{
            //
            //                });
            //            });
            
            //            [imageView loadImageFromURLString:obj completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            //                [imageView sizeToFit];
            //                float width  = imageView.width;
            //                float height = imageView.height;
            //                imageView.width = 320;
            //                imageView.height = height / width * 320;
            //                imageView.midY = self.scrollView.height/2;
            //            }];
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
    self.index = roundf(scrollView.contentOffset.x / 320.0);
    [self updateTitle];
}
@end
