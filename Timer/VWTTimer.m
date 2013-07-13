//
//  VWTTimer.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTTimeRemaining.h"
#import "VWTTimer.h"
#import "VWTdevSettingsController.h"

@interface VWTTimer ()
@property (nonatomic, copy) NSMutableArray *sounds;
@property (nonatomic, strong) VWTTimeRemaining *timeRemaining;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation VWTTimer

- (id)init
{
    return [self initTimerWithDuration:@"0:00"];
}

-(id)initTimerWithDuration:(NSString *)duration

{
	self = [super init];
	if (self) {
		_timeRemaining = [[VWTTimeRemaining alloc]initWithDuration:duration];
	}
	return self;
}

- (void)startTimer
{
	if (!_timer)
		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired
{
	NSString *timeRemaining = [self.timeRemaining timeRemaining];
	
	if (timeRemaining) {
		[self.delegate updateRemainingTimeDisplay:timeRemaining];
		[self.timeRemaining decrementTimeRemaining];
	}
	else {
		[self.delegate timerDidComplete];
		self.timeRemaining = nil;
	}
}

- (void)stopTimer
{
	[self.timer invalidate];
}
@end
