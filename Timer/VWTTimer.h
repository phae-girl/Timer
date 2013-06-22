//
//  VWTTimer.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VWTTimerDelegateProtocol <NSObject>
@required
- (void)updateRemainingTimeDisplay:(NSString *)timeRemaining;
- (void)timerDidComplete;

@end

@interface VWTTimer : NSObject
@property (weak, nonatomic) NSObject <VWTTimerDelegateProtocol> *delegate;

- (id)initTimerWithDuration:(NSString *)duration;

- (void)stopTimer;
- (void)startTimer;

@end
