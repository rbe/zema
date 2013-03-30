//
//  SearchController.h
//  zema
//
//  Created by Ralf Bensmann on 07.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper/AddressBook.h"

@interface SearchController : NSViewController {
    NSSearchFieldCell *searchField;
}

@property (assign) IBOutlet NSSearchFieldCell *searchField;
- (IBAction)searchAction:(id)sender;

@end
