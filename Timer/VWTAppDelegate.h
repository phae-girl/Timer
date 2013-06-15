//
//  VWTAppDelegate.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-23.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VWTAppDelegate : NSObject <NSApplicationDelegate>
@property (assign) IBOutlet NSWindow *window;

- (IBAction)showPreferences:(id)sender;

@end
