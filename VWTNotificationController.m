//
//  VWTNotificationController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-07-13.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTNotificationController.h"
#import "VWTDefaultKeys.h"

@interface VWTNotificationController () <NSUserNotificationCenterDelegate>
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSUserNotificationCenter *notificationCenter;
@end

@implementation VWTNotificationController

- (id)init
{
    self = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
		_notificationCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
		[self.notificationCenter setDelegate:self];
    }
    return self;
}

- (BOOL)repeatTimer
{
	
	return [self.defaults boolForKey:VWTRepeatTimerKey];
}

- (void)sendNotifications
{
	if ([self.defaults objectForKey:VWTNotificationSoundKey])
		[[NSSound soundNamed:[self.defaults objectForKey:VWTNotificationSoundKey]]play];
	
	if ([self.defaults boolForKey:VWTShouldDisplayNotificationKey])
		[self showNotificationWithMessage:[self.defaults objectForKey:VWTNotificationMessageKey]];
	
	if ([self.defaults boolForKey:VWTShouldSpeakNotificationKey])
		[self speakNotification:[self.defaults objectForKey:VWTNotificationMessageKey]];
}

- (void)speakNotification:(NSString*)message
{
	NSSpeechSynthesizer *synthesizer = [[NSSpeechSynthesizer alloc]initWithVoice:nil];
	[synthesizer startSpeakingString:message];
}

- (void)showNotificationWithMessage:(NSString *)message
{
	NSUserNotification *notification = [[NSUserNotification alloc] init];
	notification.title = @"Timer Complete!";
	notification.informativeText = message;
	notification.soundName = @"";
	[self.notificationCenter deliverNotification:notification];
	
}

#pragma mark -
#pragma mark User Notification Delegate Method

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

@end
