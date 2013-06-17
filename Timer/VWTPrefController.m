//
//  VWTPrefController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-15.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTPrefController.h"

@interface VWTPrefController ()
@property (nonatomic) NSUserDefaults *defaults;
@end

@implementation VWTPrefController

- (id)init
{
    self = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)awakeFromNib
{
	if ([self.defaults objectForKey:@"customMessage"]){
		self.customMessage = [self.defaults objectForKey:@"customMessage"];
		self.sendAlertMessage = [self.defaults boolForKey:@"sendNotification"];
		self.speakMessage = [self.defaults boolForKey:@"speakNotification"];
	}
}

- (IBAction)saveAndClose:(id)sender
{
	[self.defaults setBool:self.sendAlertMessage forKey:@"sendNotification"];
	[self.defaults setBool:self.speakMessage forKey:@"speakNotification"];
	[self.defaults setObject:self.customMessage forKey:@"customMessage"];
	[self.defaults synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"prefsSheetShouldClose" object:self]];
}

- (IBAction)cancelChanges:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"prefsSheetShouldClose" object:self]];
}
@end
