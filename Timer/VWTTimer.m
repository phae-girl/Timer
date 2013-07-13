//
//  VWTTimer.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTTimer.h"
#import "VWTdevSettingsController.h"
#import "VWTTimeRemaining.h"

@interface VWTTimer ()
@property (weak, nonatomic) NSTimer *timer;
@property (copy, nonatomic) NSMutableArray *sounds;
@property (nonatomic) NSInteger initialDurationInSeconds, totalSecondsRemaining;

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
		[self setInitialTimerDuration:duration];
	}
	return self;
}

- (void)setInitialTimerDuration:(NSString *)duration
{
	if (duration) {
		NSMutableArray *hoursMinutesSeconds = [[duration componentsSeparatedByString:@":"]mutableCopy];
		while ([hoursMinutesSeconds count] < 3) {
			[hoursMinutesSeconds insertObject:@"0" atIndex:0];
		}
		_initialDurationInSeconds = [hoursMinutesSeconds[2] integerValue] + ([hoursMinutesSeconds[1] integerValue] *60) + ([hoursMinutesSeconds[0] integerValue] *3600);
		_totalSecondsRemaining = self.initialDurationInSeconds;
	}
	else
		_totalSecondsRemaining = self.initialDurationInSeconds;
}

- (void)startTimer
{
	if (!_timer)
		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired
{
	if (self.totalSecondsRemaining >= 0) {
		[self.delegate updateRemainingTimeDisplay:[self timeRemaining]];
		self.totalSecondsRemaining-=1;
	}
	
	else
    {
        [self.delegate timerDidComplete];
		[self setInitialTimerDuration:nil];
    }
}

- (NSString *)timeRemaining
{
	NSInteger hoursRemaining = (self.totalSecondsRemaining - self.totalSecondsRemaining % 3600)/3600;
	NSInteger totalSecondsLessHoursRemaining = self.totalSecondsRemaining - hoursRemaining*60*60;
	
	NSInteger minutesRemaining = (totalSecondsLessHoursRemaining - totalSecondsLessHoursRemaining % 60)/60;
	NSInteger secondsRemaining = (totalSecondsLessHoursRemaining % 60);
	
	if (hoursRemaining ==0 && minutesRemaining ==0)
		return [NSString stringWithFormat:@"%02li", secondsRemaining];
	else if (hoursRemaining == 0)
		return [NSString stringWithFormat:@"%02li:%02li", minutesRemaining, secondsRemaining];
	else
		return [NSString stringWithFormat:@"%li:%02li:%02li", hoursRemaining, minutesRemaining, secondsRemaining];

}

- (void)stopTimer
{
	[self.timer invalidate];
}

- (void)dealloc
{
	NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
