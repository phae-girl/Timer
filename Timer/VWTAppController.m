//
//  VWTAppController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppController.h"
#import "VWTSounds.h"
#import "VWTTimer.h"
#import "VWTPrefController.h"

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


-(void)awakeFromNib {
	[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
	NSArray *array = [VWTSounds getSounds];
	[self.soundSelector insertItemWithTitle:@"" atIndex:0];
	[self.soundSelector addItemsWithTitles:array];
	NSString *lastSound = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSoundSelected"];
	[self.soundSelector selectItemWithTitle:lastSound];
}

- (IBAction)testSound:(id)sender {
	[[NSSound soundNamed:self.soundSelector.titleOfSelectedItem]play];
	[[NSUserDefaults standardUserDefaults] setObject:self.soundSelector.titleOfSelectedItem forKey:@"lastSoundSelected"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

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
	if (!self.repeats.state) {
		[self killTimer];
	}
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:self.repeats.state forKey:@"repeats"];
	[defaults synchronize];
	
	BOOL sendNotification = [defaults boolForKey:@"sendNotification"];
	BOOL speakNotification = [defaults boolForKey:@"speakNotification"];
	if (speakNotification) {
		NSSpeechSynthesizer *synthesizer = [[NSSpeechSynthesizer alloc]initWithVoice:nil];
		[synthesizer startSpeakingString:[defaults objectForKey:@"customMessage"]];
	}
	
	if (sendNotification) {
		NSUserNotification *notification = [[NSUserNotification alloc] init];
		notification.title = @"Timer Complete!";
		notification.informativeText = [defaults objectForKey:@"customMessage"];
		notification.soundName = self.soundSelector.titleOfSelectedItem;
		[[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
	}
	else if (self.soundSelector.titleOfSelectedItem)
		[[NSSound soundNamed:self.soundSelector.titleOfSelectedItem]play];
}

- (void)killTimer
{
	[self.timer stopTimer];
	self.timer = nil;
}

- (IBAction)showPreferences:(id)sender
{
	if (!_preferencesSheet)
		[NSBundle loadNibNamed:@"Preferences" owner:self];
	[NSApp beginSheet:self.preferencesSheet modalForWindow:[[NSApp delegate]window] modalDelegate:self didEndSelector:NULL contextInfo:NULL];
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
