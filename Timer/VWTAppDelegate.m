//
//  VWTAppDelegate.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-23.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppDelegate.h"

@interface VWTAppDelegate ()
@property NSTimer *timer;
@property NSDate *startTime;
@property NSInteger timeCounter;
@property IBOutlet NSTextField *label;


@end

@implementation VWTAppDelegate

-(void)awakeFromNib
{
	NSString *path = @"/System/Library/Sounds";
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray *files = [fm contentsOfDirectoryAtPath:path error:nil];
	[self populateSoundsFromFiles:files];
	NSLog(@"%@", self.sounds);
	NSLog(@"%s",__PRETTY_FUNCTION__);

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSLog(@"%s",__PRETTY_FUNCTION__);
		
}

- (void)populateSoundsFromFiles:(NSArray *)fileList
{
	if (!_sounds) {
		_sounds = [NSMutableArray array];
	}
	
	[fileList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSString *soundName = [obj stringByDeletingPathExtension];
		[self.sounds addObject:soundName];
		
	}];
}
- (IBAction)startTimer:(id)sender {
	_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
	_startTime = [NSDate date];
	_timeCounter = 0;
}

- (void)timerFired
{
	self.timeCounter++;
	self.label.stringValue = [NSString stringWithFormat:@"%ld", (long)self.timeCounter];
	
	NSLog(@"%ld", (long)self.timeCounter);
	
	if (self.timeCounter >10) {
		[self.timer invalidate];
		[[NSSound soundNamed:@"Ping"]play];
	}
	
	
}

@end
