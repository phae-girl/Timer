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
<<<<<<< HEAD
@property (weak, nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger durationInSeconds, totalSecondsRemaining;
=======
@property (nonatomic, copy) NSMutableArray *sounds;
@property (nonatomic, strong) VWTTimeRemaining *timeRemaining;
@property (nonatomic, weak) NSTimer *timer;

>>>>>>> release/v0.7.6

@end

@implementation VWTTimer

<<<<<<< HEAD
- (id)initTimerWithDuration:(NSString *)duration
=======
- (id)init
{
    return [self initTimerWithDuration:@"0:00"];
}

-(id)initTimerWithDuration:(NSString *)duration
>>>>>>> release/v0.7.6
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
		_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired
{
<<<<<<< HEAD
	if (self.totalSecondsRemaining >= 0) {
		[self.delegate updateRemainingTimeDisplay:[self timeRemaining]];
		self.totalSecondsRemaining--;
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
	
	if (hoursRemaining == 0 && minutesRemaining == 0)
		return [NSString stringWithFormat:@"%02li", secondsRemaining];
	else if (hoursRemaining == 0)
		return [NSString stringWithFormat:@"%02li:%02li", minutesRemaining, secondsRemaining];
	else
		return [NSString stringWithFormat:@"%li:%02li:%02li", hoursRemaining, minutesRemaining, secondsRemaining];
=======
		
	NSString *timeRemaining = [self.timeRemaining timeRemaining];
	
	if (timeRemaining) {
		[self.delegate updateRemainingTimeDisplay:timeRemaining];
		[self.timeRemaining decrementTimeRemaining];
>>>>>>> release/v0.7.6

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
<<<<<<< HEAD


=======
>>>>>>> release/v0.7.6
@end
