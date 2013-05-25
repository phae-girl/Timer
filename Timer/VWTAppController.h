//
//  VWTAppController.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VWTAppController : NSWindowController

@property (weak) IBOutlet NSPopUpButton *soundSelector;
@property (weak) IBOutlet NSTextField *timeDisplay;
@property (weak) IBOutlet NSButton *pauseButton;
@property (weak) IBOutlet NSButton *resumeButton;
@property (weak) IBOutlet NSButton *cancelButton;


- (IBAction)testSound:(id)sender;
- (IBAction)startTimer:(id)sender;
- (IBAction)timerAction:(id)sender;



@end
