//
//  VWTAppDelegate.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-23.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VWTAppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSPopUpButton *dropDown;

@property (assign) IBOutlet NSWindow *window;
@property (copy, nonatomic) NSArray *soundsArray;

- (IBAction)startTimer:(id)sender;
- (IBAction)soundSelected:(id)sender;
@end
