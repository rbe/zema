//
//  zemaAppDelegate.h
//  zema
//
//  Created by Ralf Bensmann on 30.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper/Resource.h"
#import "Helper/Speech.h"
#import "Helper/AddressBook.h"
#import "SearchController.h"

@interface zemaAppDelegate : NSObject <NSApplicationDelegate> {
	NSWindow *window;
	NSPersistentStoreCoordinator *__persistentStoreCoordinator;
	NSManagedObjectModel *__managedObjectModel;
	NSManagedObjectContext *__managedObjectContext;
    NSButton *_addressBookButton;
    NSScrollView *_contentView;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *addressBookButton;
@property (assign) IBOutlet NSScrollView *contentView;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)showAddressView:(id)sender;

@end
