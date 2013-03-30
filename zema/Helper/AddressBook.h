//
//  AdressBook.h
//  zema
//
//  Created by Ralf Bensmann on 08.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface AddressBook : NSObject {
    ABAddressBook *addressBook;
}

- (NSArray *)listAll;
- (ABPerson *)recordForUniqueId:(NSString *)uniqueId;
- (NSArray *)findAllByName:(NSString *)name;
- (ABPerson *)findByName:(NSString *)name;
- (ABPerson *)createWithFirstname:(NSString *)firstname andLastname:(NSString *)lastname;

@end
