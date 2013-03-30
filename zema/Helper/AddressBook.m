//
//  AdressBook.m
//  zema
//
//  Created by Ralf Bensmann on 08.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import "AddressBook.h"

@implementation AddressBook

- (id)init {
    self = [super init];
    if (self) {
        //addressBook = [ABAddressBook sharedAddressBook];
        addressBook = [ABAddressBook addressBook];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"AddressBook dealloc");
    [addressBook release];
    [super dealloc];
}

#pragma mark - AddressBook

- (NSArray *)listAll {
    if (addressBook) {
        NSArray *people = [addressBook people];
        /*
        for (id p in people) {
            NSLog(@"p=%@", p);
        }
        */
        return people;
    } else {
        NSLog(@"No addressBook instance");
        return nil;
    }
}

#pragma mark Finder

- (ABPerson *)recordForUniqueId:(NSString *)uniqueId {
    if (addressBook) {
        return [[addressBook recordForUniqueId:uniqueId] autorelease];
    } else {
        NSLog(@"No addressBook instance");
        return nil;
    }
}

- (NSUInteger)countAllByName:(NSString *)name {
    ABSearchElement *searchElement = [ABPerson searchElementForProperty:kABLastNameProperty
                                                                  label:nil
                                                                    key:nil
                                                                  value:name
                                                             comparison:kABEqualCaseInsensitive];
    NSArray *found = [addressBook recordsMatchingSearchElement:searchElement];
    return [found count];
}

- (NSArray *)findAllByName:(NSString *)name {
    if (addressBook) {
        ABSearchElement *searchElement = [ABPerson searchElementForProperty:kABLastNameProperty
                                                                      label:nil
                                                                        key:nil
                                                                      value:name
                                                                 comparison:kABEqualCaseInsensitive];
        NSArray *found = [addressBook recordsMatchingSearchElement:searchElement];
        return found;
    } else {
        NSLog(@"No addressBook instance");
        return nil;
    }
}

- (ABPerson *)findByName:(NSString *)name {
    if (addressBook) {
        NSArray *found = [self findAllByName:name];
        if ([found count] > 1) {
            return nil;
        } else {
            return [found objectAtIndex:0];
        }
    } else {
        NSLog(@"No addressBook instance");
        return nil;
    }
}

#pragma mark CRUD

- (ABPerson *)createWithFirstname:(NSString *)firstname andLastname:(NSString *)lastname {
    if (addressBook) {
        if ([self countAllByName:lastname] == 0) {
            ABPerson *person = [[ABPerson alloc] initWithAddressBook:addressBook];
            [person setValue:firstname forProperty:kABFirstNameProperty];
            [person setValue:lastname forProperty:kABLastNameProperty];
            [addressBook addRecord:person];
            [addressBook save];
            return [person autorelease];
        }
        return nil;
    } else {
        NSLog(@"No addressBook instance");
        return nil;
    }
}

@end
