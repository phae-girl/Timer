//
//  VWTAppDelegate.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-23.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppDelegate.h"
#import "VWTTimer.h"
#import "VWTSounds.h"

@interface VWTAppDelegate () <VWTTimerDelegateProtocol, NSUserNotificationCenterDelegate>

@property VWTTimer *timer;

@property IBOutlet NSTextField *label;


@end

@implementation VWTAppDelegate

-(void)awakeFromNib
{
	if (!_soundsArray)
		_soundsArray = [NSArray arrayWithArray:[VWTSounds getSounds]];
	[self.dropDown addItemsWithTitles:self.soundsArray];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (IBAction)startTimer:(id)sender {
	_timer = [[VWTTimer alloc]initWithTimeInterval:5 repeats:NO];
	[self.timer setDelegate:self];
}

- (IBAction)soundSelected:(id)sender {
}

- (void)timerDidFire
{
	//[[NSSound soundNamed:self.dropDown.titleOfSelectedItem]play];
	NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Hello, World!";
    notification.informativeText = @"A notification";
    notification.soundName = self.dropDown.titleOfSelectedItem;
	
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}
- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}
@end
