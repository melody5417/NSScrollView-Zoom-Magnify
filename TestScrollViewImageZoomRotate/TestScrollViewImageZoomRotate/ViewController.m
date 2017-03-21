//
//  ViewController.m
//  TestScrollViewImageZoomRotate
//
//  Created by yiqiwang(王一棋) on 2017/3/20.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "ViewController.h"
#import "ViewForKey.h"

@interface ViewController ()<ZoomDelegate>
@property (weak) IBOutlet ViewForKey *viewForKey;
@property (weak) IBOutlet NSScrollView *scrollview;
@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, assign) NSEdgeInsets marginInsets;
@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
    
    self.marginInsets = NSEdgeInsetsMake(40, 40, 40, 40);
    
  [self.viewForKey setDelegate:self];

//    [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

  [self.scrollview setFrame:self.view.bounds];
  [self.scrollview setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    self.previewImage = [NSImage imageNamed:@"test"];
  self.imageView = [[NSImageView alloc] initWithFrame:self.view.bounds];
  [self.imageView setImage:self.previewImage];
    [self.imageView setImageScaling:NSImageScaleAxesIndependently];
  [self.scrollview.documentView addSubview:self.imageView];
  
    [self updatePreviewView];
}

- (void)dealloc {
  
}


#pragma mark - getter & setter

- (void)setPreviewImage:(NSImage *)previewImage {
  _previewImage = previewImage;
    
    //重置window
    [self.view.window setContentSize: _previewImage.size];
    [self.view.window makeKeyAndOrderFront:self];
    [self.view.window orderFrontRegardless];
    [self.view.window center];
    
  self.scale = 1.0;
}

- (void)setScale:(CGFloat)scale {
    if (scale < 0.1) {
        return ;
    }
    _scale = scale;
  
    [self updatePreviewView];
}

#pragma mark - 

- (void)updatePreviewView {
    float scale = self.scale;
    NSLog(@"%s scale=%f", __FUNCTION__, scale);
    
    NSPoint newImageViewOrigin = NSMakePoint(self.marginInsets.left, self.marginInsets.bottom);
    NSSize newImageViewSize = NSMakeSize(self.previewImage.size.width * scale,
                                         self.previewImage.size.height * scale);

    NSSize newDocumentSize = NSMakeSize(newImageViewSize.width + self.marginInsets.left + self.marginInsets.right,
                                        newImageViewSize.height + self.marginInsets.bottom + self.marginInsets.top);
    
    
    
    if (newDocumentSize.width < self.scrollview.contentView.frame.size.width) {
        newImageViewOrigin.x = (self.scrollview.contentView.frame.size.width - newImageViewSize.width) / 2 + self.marginInsets.left;
        newDocumentSize.width = self.scrollview.contentView.frame.size.width;
    }
    
    if (newDocumentSize.height < self.scrollview.contentView.frame.size.height) {
        newImageViewOrigin.y = (self.scrollview.contentView.frame.size.height - newImageViewSize.height) / 2 + self.marginInsets.bottom;
        newDocumentSize.height = self.scrollview.contentView.frame.size.height;
    }
    
    NSPoint oldCenterPointInDoc = NSMakePoint(self.scrollview.documentVisibleRect.origin.x + self.scrollview.documentVisibleRect.size.width / 2,
                                                 self.scrollview.documentVisibleRect.origin.y + self.scrollview.documentVisibleRect.size.height / 2);
    NSSize oldDocumentSize = self.scrollview.documentView.frame.size;
    float xScale = oldCenterPointInDoc.x / oldDocumentSize.width;
    float yScale = oldCenterPointInDoc.y / oldDocumentSize.height;
    
    NSPoint newCenterPointInDoc = NSMakePoint(newDocumentSize.width * xScale, newDocumentSize.height * yScale);
    NSPoint scrollToPoint = NSMakePoint(newCenterPointInDoc.x - self.scrollview.visibleRect.size.width / 2.0,
                                        newCenterPointInDoc.y - self.scrollview.visibleRect.size.height / 2.0);
    
    
    // bounds not work
//    [self.scrollview.documentView setBounds:NSMakeRect(0,
//                                                      0,
//                                                      newDocumentSize.width,
//                                                      newDocumentSize.height)];
    [self.scrollview.documentView setFrame:NSMakeRect(0, 0, newDocumentSize.width, newDocumentSize.height)];
    
    // bounds not work
//    [self.imageView setBounds:NSMakeRect(0,
//                                        0,
//                                        newImageViewSize.width,
//                                        newImageViewSize.height)];
    [self.imageView setFrame:NSMakeRect(newImageViewOrigin.x,
                                       newImageViewOrigin.y,
                                       newImageViewSize.width,
                                        newImageViewSize.height)];
    
    // 重置到之前图片的位置
    [self.scrollview.documentView scrollPoint:scrollToPoint];
}

#pragma mark - ZoomDelegate

- (void)zoomOut {
//    NSLog(@"%s", __FUNCTION__);
    self.scale += 0.1;
}

- (void)zoomIn {
//    NSLog(@"%s", __FUNCTION__);
    self.scale -= 0.1;
}


@end
