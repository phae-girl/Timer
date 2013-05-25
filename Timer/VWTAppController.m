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
		_timer = [[VWTTimer alloc]initWithDuration:[[sender title] integerValue]];
		[self.timer setDelegate:self];
		[self toggleControlButtonsEnabled:YES];
	}
}

- (IBAction)timerAction:(id)sender {
	if ([[sender title] isEqualToString:@"Pause"]) {
		[self.timer stopTimer];
			}
	else if ([[sender title] isEqualToString:@"Resume"]){
		[self.timer startTimer];
	}
	else {
		[self.timer stopTimer];
		self.timer = nil;
		self.timeDisplay.stringValue = @"0:00";
		[self toggleControlButtonsEnabled:NO];
	}
}

- (void)toggleControlButtonsEnabled:(BOOL)enabled
{
	[self.pauseButton setEnabled:enabled];
	[self.resumeButton setEnabled:enabled];
	[self.cancelButton setEnabled:enabled];
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
	self.timer = nil;
	
	NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Timer Complete!";
    //notification.informativeText = [NSString stringWithFormat:@"It's been %li minutes", self.duration];
    notification.soundName = self.soundSelector.titleOfSelectedItem;
	
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

}

@end
