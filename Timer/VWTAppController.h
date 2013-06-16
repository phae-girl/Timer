//
//  VWTAppController.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VWTAppController : NSObject

@property (nonatomic, assign) IBOutlet NSWindow *preferencesSheet;

@property (nonatomic, weak) IBOutlet NSPopUpButton *soundSelector;
@property (nonatomic, weak) IBOutlet NSTextField *timeDisplay;
@property (nonatomic, weak) IBOutlet NSButton *pauseButton;
@property (nonatomic, weak) IBOutlet NSButton *resumeButton;
@property (nonatomic, weak) IBOutlet NSButton *cancelButton;
@property (nonatomic, weak) IBOutlet NSButton *repeats;



- (IBAction)testSound:(id)sender;
- (IBAction)startTimer:(id)sender;

- (IBAction)pauseTimer:(id)sender;
- (IBAction)resumeTimer:(id)sender;

- (IBAction)cancelTimer:(id)sender;

- (IBAction)showPreferences:(id)sender;



@end
