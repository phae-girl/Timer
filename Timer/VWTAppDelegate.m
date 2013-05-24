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

@interface VWTAppDelegate () <VWTTimerDelegateProtocol>

@property VWTTimer *timer;
@property NSDate *startTime;

@property IBOutlet NSTextField *label;


@end

@implementation VWTAppDelegate

-(void)awakeFromNib
{
	VWTSounds *sounds = [[VWTSounds alloc]init];
	NSLog(@"%@", sounds.sounds);
	
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
		
}

- (IBAction)startTimer:(id)sender {
	_timer = [[VWTTimer alloc]initWithTimeInterval:5 repeats:NO];
	[self.timer setDelegate:self];
}

- (void)timerDidFire
{
		NSLog(@"Timer Done");
}

@end
