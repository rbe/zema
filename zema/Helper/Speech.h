//
//  Speech.h
//  Zema
//
//  Created by Ralf Bensmann on 11.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface Speech : NSObject <NSSpeechRecognizerDelegate> {
    NSSpeechRecognizer *mySpeechRecog;
}

@end
