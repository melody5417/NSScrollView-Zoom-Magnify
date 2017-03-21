//
//  ViewForKey.m
//  TestScrollViewImageZoomRotate
//
//  Created by yiqiwang(王一棋) on 2017/3/20.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "ViewForKey.h"
#import <Carbon/Carbon.h>

@implementation ViewForKey

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[[NSColor blueColor] colorWithAlphaComponent:0.5] setFill];
    NSRectFillUsingOperation(dirtyRect, NSCompositingOperationSourceOver);
}

- (void)zoomOut {
//    NSLog(@"%s", __FUNCTION__);
    [self.delegate zoomOut];
}

- (void)zoomIn {
//    NSLog(@"%s", __FUNCTION__);
    [self.delegate zoomIn];
}


// command+z            undo
// command+shift+z      redo
// cmd + c              copy
// cmd + x              cut
// cmd + v              paste
// cmd + a              select all
// delete               delete key item
// cmd +                zoom out
// cmd -                zoom in
// <-                   last picture
// ->                   next picture
- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
    NSUInteger flags = [theEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask;
    
    if ((flags == NSCommandKeyMask ||
         flags == (NSCommandKeyMask | NSAlphaShiftKeyMask)) &&
        [[theEvent charactersIgnoringModifiers] compare:@"=" options:NSCaseInsensitiveSearch] == 0) {
//        NSLog(@"%s zoom out", __FUNCTION__);
        [self zoomOut];
        return YES;
    }
    else if ((flags == NSCommandKeyMask ||
              flags == (NSCommandKeyMask | NSAlphaShiftKeyMask)) &&
             [[theEvent charactersIgnoringModifiers] compare:@"-" options:NSCaseInsensitiveSearch] == 0) {
//        NSLog(@"%s zoom in", __FUNCTION__);
        [self zoomIn];
        return YES;
    }
    
    return NO;
}

@end
