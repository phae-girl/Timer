//
//  VWTAppController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppController.h"
#import "VWTTimer.h"
#import "NSColor+HexColor.h"

@interface VWTAppController () <VWTTimerDelegateProtocol, NSUserNotificationCenterDelegate>
@property (nonatomic, strong) VWTTimer *timer;
@property (nonatomic, weak) NSButton *activeTimerButton;

@end

@implementation VWTAppController

typedef enum : NSUInteger {
	Pause = (0x1 << 0), // => 0x00000001
	Resume = (0x1 << 1), // => 0x00000010
	Cancel = (0x1 << 2)  // => 0x00000100
} ControlButtonStatus;

#pragma mark -
#pragma mark Initial Setup

- (void)awakeFromNib
{
	[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
	[self setUpColors];
	[self setUpTimerButtonDurations];
}

- (void)setUpColors
{
	[self.window setBackgroundColor:[NSColor colorWithHexValue:@"fefefe" alpha:1.0]];
}
- (void)setUpTimerButtonDurations
{
	NSArray *timerButtons = @[self.timerButton0,self.timerButton1,self.timerButton2,self.timerButton3,self.timerButton4,self.timerButton5];
	NSArray *defaultDurations = @[@"5:00",@"10:00",@"20:00",@"30:00",@"45:00",@"1:00:00"];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[timerButtons enumerateObjectsUsingBlock:^(NSButton *button, NSUInteger idx, BOOL *stop) {
		NSString *key = [NSString stringWithFormat:@"durationForTimerButton%ld",(unsigned long)idx];
		NSString *buttonTitle = [defaults objectForKey:key];
		if (buttonTitle)
			[button setTitle:buttonTitle];
		else
			[button setTitle:defaultDurations[idx]];
	}];
}
#pragma mark -
#pragma mark Controls and Buttons

- (IBAction)startTimer:(NSButton *)sender {
	
	if (!_timer) {
		_activeTimerButton = sender;
		_timer = [[VWTTimer alloc]initTimerWithDuration:[self.activeTimerButton title]];
		[self.timer setDelegate:self];
		[self.timer startTimer];
	}
	
	else {
		[self killTimer];
		[self startTimer:sender];
	}
	
	ControlButtonStatus status = (Pause | Cancel);
	[self toggleControlButtons:status];
}

-(IBAction)pauseTimer:(NSButton *)sender
{
	[self.timer stopTimer];
	ControlButtonStatus status = (Resume | Cancel);
	[self toggleControlButtons:status];
}

- (IBAction)resumeTimer:(NSButton *)sender
{
	[self.timer startTimer];
	ControlButtonStatus status = (Pause | Cancel);
	[self toggleControlButtons:status];
}

- (IBAction)cancelTimer:(NSButton *)sender {
	[self killTimer];
	self.timeDisplay.stringValue = @"0:00:00";
	ControlButtonStatus status = !(Pause | Resume | Cancel);
	[self toggleControlButtons:status];
}

- (void)killTimer
{
	[self.timer stopTimer];
	self.timer = nil;
}

- (void)toggleControlButtons:(ControlButtonStatus)status
{
	[self.pauseButton setEnabled:Pause & status];
	[self.resumeButton setEnabled:Resume & status];
	[self.cancelButton setEnabled:Cancel & status];
}

- (void)updateRemainingTimeDisplay:(NSString *)timeRemaining
{
	[self.timeDisplay setStringValue:timeRemaining];
}

- (void)timerDidComplete
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	BOOL repeatTimer = [defaults boolForKey:@"repeatTimer"];
	BOOL sendNotification = [defaults boolForKey:@"sendNotification"];
	BOOL speakNotification = [defaults boolForKey:@"speakNotification"];
	NSString *selectedSound = [defaults objectForKey:@"selectedSound"];
	NSString *message = [defaults objectForKey:@"customMessage"];
	
	if (!repeatTimer)
		[self killTimer];
	else
		[self startTimer:self.activeTimerButton];
	
	if (sendNotification)
		[self showNotificationWithMessage:message andSound:selectedSound];
	
	else if (selectedSound)
		[[NSSound soundNamed:selectedSound]play];
	
	if (speakNotification)
		[self speakNotification:message];
}

- (void)speakNotification:(NSString*)message
{
	NSSpeechSynthesizer *synthesizer = [[NSSpeechSynthesizer alloc]initWithVoice:nil];
	[synthesizer startSpeakingString:message];
}

- (void)showNotificationWithMessage:(NSString *)message andSound:(NSString *)sound
{
	NSUserNotification *notification = [[NSUserNotification alloc] init];
	notification.title = @"Timer Complete!";
	notification.informativeText = message;
	notification.soundName = sound;
	[[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

}

#pragma mark -
#pragma mark Preference Sheet Methods

- (IBAction)showPreferences:(id)sender
{
	if (!_preferencesSheet)
		[NSBundle loadNibNamed:@"Preferences" owner:self];
	[NSApp beginSheet:self.preferencesSheet modalForWindow:self.window modalDelegate:self didEndSelector:NULL contextInfo:NULL];
	[self.preferencesSheet setBackgroundColor:[NSColor colorWithHexValue:@"ffffff" alpha:0.9]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePrefsSheet) name:@"prefsSheetShouldClose" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpTimerButtonDurations) name:@"timerDurationsUpdated" object:nil];
}

- (void)closePrefsSheet
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[NSApp endSheet:self.preferencesSheet];
	[self.preferencesSheet close];
	self.preferencesSheet = nil;
}

#pragma mark -
#pragma mark NSUserNotificationCenter Delegate Method

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

@end
