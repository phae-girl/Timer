//
//  VWTAppController.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VWTAppController : NSObject

@property (nonatomic, assign) IBOutlet NSWindow *window;
@property (nonatomic, assign) IBOutlet NSWindow *preferencesSheet;

@property (nonatomic, weak) IBOutlet NSTextField *timeDisplay;
@property (nonatomic, weak) IBOutlet NSButton *pauseButton;
@property (nonatomic, weak) IBOutlet NSButton *resumeButton;
@property (nonatomic, weak) IBOutlet NSButton *cancelButton;

@property (weak) IBOutlet NSButton *timerButton0;
@property (weak) IBOutlet NSButton *timerButton1;
@property (weak) IBOutlet NSButton *timerButton2;
@property (weak) IBOutlet NSButton *timerButton3;
@property (weak) IBOutlet NSButton *timerButton4;
@property (weak) IBOutlet NSButton *timerButton5;


- (IBAction)startTimer:(id)sender;

- (IBAction)pauseTimer:(id)sender;
- (IBAction)resumeTimer:(id)sender;
- (IBAction)cancelTimer:(id)sender;

- (IBAction)showPreferences:(id)sender;

@end
