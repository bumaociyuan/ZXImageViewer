//
//  ZXImageViewerViewController.h
//  ZXImageViewerDemo
//
//  Created by Mac Mini on 6/1/14.
//  Copyright (c) 2014 com.zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXImageViewerViewController : UIViewController
@property (nonatomic, assign) BOOL isLoadFromWeb;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, assign) int originalIndex;
@end
