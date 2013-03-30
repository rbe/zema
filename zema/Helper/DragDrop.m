//
//  DragDrop.m
//  Zema
//
//  Created by Ralf Bensmann on 10.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import "DragDrop.h"

@implementation DragDrop

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (NSUInteger) count:(NSPasteboard*)pBoard {
    return [[pBoard types] count];
}

- (void)inspectClipboard:(NSPasteboard*)pBoard {
	NSMutableArray* newTypes = [NSMutableArray array];
	NSEnumerator* typeEnum = [[pBoard types] objectEnumerator];
	NSString* type;
	NSDictionary* entry;
	while (type = [typeEnum nextObject]) {
		entry = [NSDictionary dictionaryWithObjectsAndKeys:type,@"name",[pBoard dataForType:type],@"data",nil];
        NSLog(@"type=%@", type);
		[newTypes addObject: entry];
	}
	[self setValue:newTypes forKey:@"types"];
	// ??? [NSApp activateIgnoringOtherApps:YES];
}

@end
