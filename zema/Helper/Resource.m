//
//  Resource.m
//  zema
//
//  Created by Ralf Bensmann on 07.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Resource.h"
#import "SearchController.h"

id inst;

@implementation Resource

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

+ (id)make:(Class)what {
    if (what == SearchController.class) {
        if (!inst) {
            inst = [[SearchController alloc] initWithNibName:@"SearchController" bundle:nil];
        }
    }
    return inst;
}

@end
