//
//  zemaAppDelegate.m
//  zema
//
//  Created by Ralf Bensmann on 30.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zemaAppDelegate.h"

@implementation zemaAppDelegate

#pragma mark Properties

@synthesize window;
@synthesize addressBookButton = _addressBookButton;
@synthesize contentView = _contentView;

#pragma mark - Methods

/**
 */
- (void)dealloc {
    NSLog(@"App Delegate dealloc");
	[__managedObjectContext release];
	[__persistentStoreCoordinator release];
	[__managedObjectModel release];
    [super dealloc];
}

/**
 Returns the directory the application uses to store the Core Data store file. This code uses a directory named "zema" in the user's Library directory.
 */
- (NSURL *)applicationFilesDirectory {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *libraryURL = [[fileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    return [libraryURL URLByAppendingPathComponent:@"zema"];
}

/**
 Creates if necessary and returns the managed object model for the application.
 */
- (NSManagedObjectModel *)managedObjectModel {
    if (__managedObjectModel) {
        return __managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"zema" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator) {
        return __persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    else {
        if ([[properties objectForKey:NSURLIsDirectoryKey] boolValue] != YES) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]]; 
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"zema.storedata"];
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        [__persistentStoreCoordinator release], __persistentStoreCoordinator = nil;
        return nil;
    }
    
    return __persistentStoreCoordinator;
}

/**
 Returns the managed object context for the application (which is already
 bound to the persistent store coordinator for the application.) 
 */
- (NSManagedObjectContext *)managedObjectContext {
    if (__managedObjectContext) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    __managedObjectContext = [[NSManagedObjectContext alloc] init];
    [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return __managedObjectContext;
}

/**
 Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
 */
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}

#pragma mark - Actions

/**
 */
- (IBAction)showAddressView:(id)sender {
    AddressBook *ab = [[AddressBook alloc] init];
    /*ABPerson *newPerson = */[ab createWithFirstname:@"John" andLastname:@"Doe"];
    /*NSArray *person = [ab findAllByName:@"Bensmann"];
    for (ABPerson *p in person) {
        NSLog(@"fist name=%@", [p valueForProperty:kABFirstNameProperty]);
        NSLog(@"p=%@", p);
    }*/
    //
    //SearchController *searchController = [[SearchController alloc] initWithNibName:@"SearchController" bundle:nil];
    SearchController *searchController = (SearchController *) [Resource make:SearchController.class];
    NSView *searchView = [searchController view];
    // 1
    //[searchController loadView];
    //[window setContentView:searchView];
    //[_contentView setFrame:[searchView bounds]];
    // 2
    //NSArray *subviews = [NSArray arrayWithObject:searchView];
    //[_contentView setSubviews:subviews];
    //[_contentView addSubview:searchView];
    // 3
    // Set bounds of searchView equal to bounds of _contentView
    [searchView setFrame:[_contentView bounds]];
    [_contentView setDocumentView:searchView];
}

#pragma mark - NSApplicationDelegate

/**
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"Launched.");
}

/**
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    NSLog(@"applicationShouldTerminateAfterLastWindowClosed");
    return YES;
}

/**
 */
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    NSLog(@"applicationShouldTerminate");
    
    // Save changes in the application's managed object context before the application terminates.
    
    if (!__managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        
        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        [alert release];
        alert = nil;
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    
    return NSTerminateNow;
}

@end
