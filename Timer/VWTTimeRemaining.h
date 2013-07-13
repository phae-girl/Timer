//
//  VWTTimeRemaining.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-07-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWTTimeRemaining : NSObject

- (id)initWithDuration:(NSString *)duration;
- (void)decrementTimeRemaining;
- (NSString *)timeRemaining;

@end
