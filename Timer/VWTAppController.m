//
//  VWTAppController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppController.h"
#import "VWTTimer.h"
#import "VWTPrefController.h"
#import "NSColor+HexColor.h"

@interface VWTAppController () <VWTTimerDelegateProtocol, NSWindowDelegate, NSUserNotificationCenterDelegate>
@property (nonatomic) VWTTimer *timer;
@property (nonatomic) VWTPrefController *prefsController;

@end

@implementation VWTAppController

typedef enum : NSUInteger {
	Pause = (0x1 << 0), // => 0x00000001
	Resume = (0x1 << 1), // => 0x00000010
	Cancel = (0x1 << 2)  // => 0x00000100
} ControlButtonStatus;

#pragma mark -
#pragma mark Initial Setup

-(void)awakeFromNib {
	[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
	[self setUpColors];
}

-(void)setUpColors
{
	[self.window setBackgroundColor:[NSColor colorWithHexValue:@"ffffff" alpha:1.0]];
}

#pragma mark -
#pragma mark Controls and Buttons


- (IBAction)startTimer:(id)sender {
	if (!_timer) {
		_timer = [[VWTTimer alloc]initWithDuration:[[sender title] integerValue]];
		[self.timer setDelegate:self];
		
		ControlButtonStatus status = (Pause | Cancel);
		[self toggleControlButtons:status];
	}
}

-(IBAction)pauseTimer:(id)sender
{
	[self.timer stopTimer];
	ControlButtonStatus status = (Resume | Cancel);
	[self toggleControlButtons:status];
}

- (IBAction)resumeTimer:(id)sender
{
	[self.timer startTimer];
	ControlButtonStatus status = (Pause | Cancel);
	[self toggleControlButtons:status];
}

- (IBAction)cancelTimer:(id)sender {
	[self killTimer];
	self.timeDisplay.stringValue = @"0:00";
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

- (void)timerDidFire:(NSString *)timeRemaining
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
	
	if (speakNotification)
		[self speakNotification:message];
	
	if (sendNotification)
		[self showNotificationWithMessage:message andSound:selectedSound];
	else if (selectedSound)
		[[NSSound soundNamed:selectedSound]play];
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

- (IBAction)showPreferences:(id)sender
{
	if (!_preferencesSheet)
		[NSBundle loadNibNamed:@"Preferences" owner:self];
	[NSApp beginSheet:self.preferencesSheet modalForWindow:self.window modalDelegate:self didEndSelector:NULL contextInfo:NULL];
	[self.preferencesSheet setBackgroundColor:[NSColor colorWithHexValue:@"ffffff" alpha:0.9]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePrefsSheet) name:@"prefsSheetShouldClose" object:nil];
}

- (void)closePrefsSheet
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[NSApp endSheet:self.preferencesSheet];
	[self.preferencesSheet close];
	self.preferencesSheet = nil;
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

@end
