//
//  ViewForKey.h
//  TestScrollViewImageZoomRotate
//
//  Created by yiqiwang(王一棋) on 2017/3/20.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ZoomDelegate <NSObject>

- (void)zoomOut;
- (void)zoomIn;

@end

@interface ViewForKey : NSView
@property (nonatomic, weak) id<ZoomDelegate> delegate;
@end
