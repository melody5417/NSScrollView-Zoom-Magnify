//
//  ViewController.h
//  TestScrollViewImageZoomRotate
//
//  Created by yiqiwang(王一棋) on 2017/3/20.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

// 缩放率 初始值1.0 > 0.1
@property (nonatomic, assign) CGFloat scale;
// 每次更新图片 scale重置为1.0
@property (nonatomic, strong) NSImage *previewImage;

@end

