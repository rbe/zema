//
//  DragDrop.h
//  Zema
//
//  Created by Ralf Bensmann on 10.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#ifndef Zema_DragDrop_h
#define Zema_DragDrop_h

#import <Foundation/Foundation.h>
#import "DragDopTypedefs.h"

@interface DragDrop : NSObject {
    NSArray* types;
}

- (NSUInteger) count:(NSPasteboard*)pBoard;
- (void)inspectClipboard:(NSPasteboard*)pBoard;

@end

#endif