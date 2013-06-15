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

@interface VWTAppController () <VWTTimerDelegateProtocol, NSUserNotificationCenterDelegate>
@property (nonatomic) VWTTimer *timer;

@end

@implementation VWTAppController

typedef enum : NSUInteger {
	Pause = (0x1 << 0), // => 0x00000001
	Resume = (0x1 << 1), // => 0x00000010
	Cancel = (0x1 << 2)  // => 0x00000100
} ControlButtonStatus;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
		[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
	[self.soundSelector insertItemWithTitle:@"" atIndex:0];
    [self.soundSelector addItemsWithTitles:[VWTSounds getSounds]];
}

- (IBAction)testSound:(id)sender {
	[[NSSound soundNamed:self.soundSelector.titleOfSelectedItem]play];
}

- (IBAction)startTimer:(id)sender {
	if (!_timer) {
		_timer = [[VWTTimer alloc]initWithDuration:[[sender title] integerValue] repeats:self.repeats.state];
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
	[self.timer stopTimer];
	self.timeDisplay.stringValue = @"0:00";
	ControlButtonStatus status = !(Pause | Resume | Cancel);
	[self toggleControlButtons:status];
	[self killTimer];
}

- (void)toggleControlButtons:(ControlButtonStatus)status
{
	[self.pauseButton setEnabled:Pause & status];
	[self.resumeButton setEnabled:Resume & status];
	[self.cancelButton setEnabled:Cancel & status];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

- (void)timerDidFire:(NSString *)timeRemaining
{
	[self.timeDisplay setStringValue:timeRemaining];
}

- (void)timerDidComplete
{
	if (!self.timer.repeats) {
		[self killTimer];
	}
	
	NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Timer Complete!";
    //notification.informativeText = [NSString stringWithFormat:@"It's been %li minutes", self.duration];
    notification.soundName = self.soundSelector.titleOfSelectedItem;
	
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (void)killTimer
{
	self.timer = nil;
}
@end
