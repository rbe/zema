//
//  Speech.m
//  Zema
//
//  Created by Ralf Bensmann on 11.09.11.
//  Copyright 2011 art of coding UG. All rights reserved.
//

#import "Speech.h"

@implementation Speech

- (id)init {
    self = [super init];
    if (self) {
        NSArray *myCommands = [NSArray arrayWithObjects:@"play music", @"stop music", @"up", @"down", nil];
        mySpeechRecog = [[NSSpeechRecognizer alloc] init];
        [mySpeechRecog setCommands:myCommands];
        [mySpeechRecog setDelegate:self];
        [mySpeechRecog startListening];
    }
    return self;
}

- (void)dealloc {
    [mySpeechRecog release];
    [super dealloc];
}

#pragma mark - NSSpeechRecognizerDelegate

- (void)speechRecognizer:(NSSpeechRecognizer *)sender didRecognizeCommand:(id)command {
    NSBeep();
    NSLog(@"%@", (NSString *)command);
    //if([(NSString *)command isEqualToString:@"press button one"])
}

@end
