//
//  SearchController.m
//  zema
//
//  Created by Ralf Bensmann on 07.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchController.h"

@implementation SearchController
@synthesize searchField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"SearchController initWithNibName %@", nibNameOrNil);
    }
    return self;
}


/**
 */
- (IBAction)searchAction:(id)sender {
    /*
    NSError *error = nil;
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
    */
    /*
    NSSearchFieldCell *searchField = (NSSearchFieldCell *) sender;
    NSString *str = [searchField stringValue];
    NSLog(@"%@", str);
    */
    unsigned long len = 0;
    if ([sender respondsToSelector:@selector(stringLength)]) {
        len = [sender stringLength];
    }
	NSLog(@"Hello, type=%@, value=%@ with length %lu/%lu", [sender class], [sender stringValue], [[sender stringValue] length], len);
}

@end
