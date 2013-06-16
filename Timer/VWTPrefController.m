//
//  VWTPrefController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-15.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTPrefController.h"

@implementation VWTPrefController

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Yipee!! %s",__PRETTY_FUNCTION__);
    }
    return self;
}
- (void)awakeFromNib
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"customMessage"]){
		self.customMessage = [defaults objectForKey:@"customMessage"];
		self.checkbox = [defaults boolForKey:@"sendMessage"];
	}
}
- (IBAction)saveAndClose:(id)sender
{
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:self.checkbox forKey:@"sendNotification"];
	[defaults setObject:self.customMessage forKey:@"customMessage"];
	[defaults synchronize];
	
	NSLog(@"%ld",(long)self.checkbox);
	NSLog(@"%@",self.customMessage);
	NSLog(@"Yipee!! %s",__PRETTY_FUNCTION__);
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"prefsSheetShouldClose" object:self]];
}
@end
