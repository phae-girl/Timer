//
//  VWTTimeRemaining.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-07-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTTimeRemaining.h"

@interface VWTTimeRemaining ()
@property NSInteger initialDurationInSeconds, totalSecondsRemaining;

@end

@implementation VWTTimeRemaining

- (id)init
{
    return [self initWithDuration:@"0:00"];
}

- (id)initWithDuration:(NSString *)duration
{
	self = [super init];
	if (self) {
		_initialDurationInSeconds = [self convertDuationStringToSeconds:duration];
		_totalSecondsRemaining = self.initialDurationInSeconds;
	}
	return self;

}

- (NSInteger)convertDuationStringToSeconds:(NSString *)duration
{
	NSMutableArray *durationComponents = [[duration componentsSeparatedByString:@":"]mutableCopy];
    while ([durationComponents count] < 3) {
        [durationComponents insertObject:@"0" atIndex:0];
    }
    
    NSInteger initialDurationInSeconds = [durationComponents[0] integerValue]*3600 + [durationComponents[1] integerValue]*60 + [durationComponents[2] integerValue];
    return initialDurationInSeconds;

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
	
}

-(void)dealloc
{
	NSLog(@"%s",__PRETTY_FUNCTION__);
}
@end
