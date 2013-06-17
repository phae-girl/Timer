//
//  VWTTimer.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTTimer.h"
#import "VWTdevSettingsController.h"

@interface VWTTimer ()
@property (weak, nonatomic) NSTimer *timer;
@property (copy, nonatomic) NSMutableArray *sounds;
@property (nonatomic) NSInteger minutes, seconds, minutesRemaining, secondsRemaining;

@end

@implementation VWTTimer

-(id)initWithDuration:(NSInteger)minutes
{
	self = [super init];
	if (self) {
		_minutes = minutes;
		_seconds = 0;
		_minutesRemaining = minutes;
		_secondsRemaining = 0;
		_repeats = YES;
		[self startTimer];
	}
	return self;
}

-(void)timerFired
{
	if((self.minutesRemaining>0 || self.secondsRemaining>=0) && self.minutesRemaining>=0)
	{
		if(self.secondsRemaining==0)
		{
			self.minutesRemaining-=1;
			self.secondsRemaining=59;
		}
		else if(self.secondsRemaining>0)
		{
			self.secondsRemaining-=1;
		}
		if(self.minutesRemaining>-1)
			[self.delegate timerDidFire:[NSString stringWithFormat:@"%li:%02li", self.minutesRemaining, self.secondsRemaining]];
	}
	else if (self.repeats) {
		self.minutesRemaining = self.minutes;
		self.secondsRemaining = 0;
		[self.delegate timerDidComplete];
	}
	
    else
    {
        [self.delegate timerDidComplete];
		[self stopTimer];
    }
}

- (void)stopTimer
{
	[self.timer invalidate];
}

- (void)startTimer
{
	VWTdevSettingsController *settings = [[VWTdevSettingsController alloc]init];
	double frequency = [[settings.devSettings valueForKey:@"timerPeriod"] doubleValue];
	
	if (!_timer)
		_timer = [NSTimer scheduledTimerWithTimeInterval:frequency target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

@end
