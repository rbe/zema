//
//  ContextView.h
//  zema
//
//  Created by Ralf Bensmann on 09.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "Helper/AddressBook.h"
#import "Helper/DragDrop.h"

// <NSDraggingSource, NSDraggingDestination, NSPasteboardItemDataProvider>
@interface ContextView : NSImageView <NSDraggingDestination> {
    // Highlight the drop zone
    BOOL highlight;
}

@end
