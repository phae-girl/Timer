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
- (void)timerDidFire;

@end

@interface VWTTimer : NSObject

@property (weak, nonatomic) NSObject <VWTTimerDelegateProtocol> *delegate;

- (id)initWithTimeInterval:(NSInteger)interval repeats:(BOOL)repeats;

@end
