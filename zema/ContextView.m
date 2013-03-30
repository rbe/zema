//
//  ContextView.m
//  zema
//
//  Created by Ralf Bensmann on 09.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import "ContextView.h"

@implementation ContextView

NSString *kPrivateDragUTI = @"com.yourcompany.cocoadraganddrop";

- (id)initWithFrame:(NSRect)frame {
    NSLog(@"ContextView.initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        //[self registerForDraggedTypes:[NSImage imagePasteboardTypes]];
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypePNG, NSPasteboardTypeString, @"ABPeopleUIDsPboardType", nil]];
        NSLog(@"ContextView.initWithFrame registered dragging");
    }    
    return self;
}

-(void)drawRect:(NSRect)rect {
    /*------------------------------------------------------
     draw method is overridden to do drop highlighing
     --------------------------------------------------------*/
    //do the usual draw operation to display the image
    [super drawRect:rect];
    if (highlight) {
        //highlight by overlaying a gray border
        [[NSColor grayColor] set];
        [NSBezierPath setDefaultLineWidth: 5];
        [NSBezierPath strokeRect: rect];
    }
}

#pragma mark - Drag and Drop

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSLog(@"draggingEntered");
    highlight = YES;
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    NSLog(@"draggingExited");
    highlight = NO;
    [self setNeedsDisplay:YES];
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    if ([sender draggingSource] != self) {
        NSPasteboard *pboard = [sender draggingPasteboard];
        //set the image using the best representation we can get from the pasteboard
        if ([NSImage canInitWithPasteboard: pboard]) {
            NSImage *newImage = [[NSImage alloc] initWithPasteboard: pboard];
            [self setImage:newImage];
            [newImage release];
        }
        /*
        //if the drag comes from a file, set the window title to the filename
        NSURL* fileURL = [NSURL URLFromPasteboard: [sender draggingPasteboard]];
        [[self window] setTitle: fileURL!=NULL ? [fileURL absoluteString] : @"(no name)"];
        */
        DragDrop *drag = [[[DragDrop alloc] init] autorelease];
        //[drag inspectClipboard:pboard];
        id plist = [pboard propertyListForType:kABPeoplePasteboardType]; //[pboard propertyListForType:@"ABPeopleUIDsPboardType"]
        NSLog(@"plist=%@ pbcount=%lu", [plist class], [plist count]);
        for (unsigned long i = 0; i < [plist count]; i++) {
            NSString *recordId = [plist objectAtIndex:i];
            if (NULL != recordId) {
                ABRecord *record = [[[[AddressBook alloc] init] recordForUniqueId:recordId] retain];
                NSLog(@"record id=%@, %@", recordId, [record valueForProperty:kABFirstNameProperty]);
            }
        }
    }
    highlight = NO;
    [self setNeedsDisplay:YES];
    return YES;
}

@end
