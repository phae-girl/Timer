//
//  VWTAppDelegate.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-23.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppDelegate.h"
#import "VWTAppController.h"

@interface VWTAppDelegate () 
@property VWTAppController *appController;

@end

@implementation VWTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//	if (!_appController) {
//		_appController = [[VWTAppController alloc]initWithWindowNibName:@"VWTAppController"];
//		[self.appController showWindow:self.appController];
//	}
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
	return YES;
}

@end
