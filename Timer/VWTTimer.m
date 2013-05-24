//
//  VWTTimer.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTTimer.h"

@interface VWTTimer ()
@property (weak, nonatomic) NSTimer *timer;
@property (copy, nonatomic) NSMutableArray *sounds;

@end

@implementation VWTTimer

- (id)initWithTimeInterval:(NSInteger)interval repeats:(BOOL)repeats
{
    self = [super init];
    if (self) {
		
		
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerFired) userInfo:nil repeats:repeats];
    }
    return self;
}

- (void)timerFired
{
	[self.delegate timerDidFire];
}


@end
