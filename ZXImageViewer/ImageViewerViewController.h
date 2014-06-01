//
//  ImageViewerViewController.h
//  lenovoRelonline
//
//  Created by zx on 2/25/14.
//  Copyright (c) 2014 noteant-6. All rights reserved.
//



@interface ImageViewerViewController : UIViewController
@property (nonatomic, assign) BOOL isLoadFromWeb;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, assign) int originalIndex;

@end
