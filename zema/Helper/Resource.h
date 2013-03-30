//
//  Resource.h
//  zema
//
//  Created by Ralf Bensmann on 07.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resource : NSObject {
}

/**
 * Make something and return it.
 */
+ (id)make:(Class)what;

@end
