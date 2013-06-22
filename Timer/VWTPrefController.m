//
//  VWTPrefController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-15.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTPrefController.h"
#import "SoundFileController.h"

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
		self.repeatTimer = [self.defaults boolForKey:@"repeatTimer"];
	}
	[self populateSoundSelectionButton];
}

- (void)populateSoundSelectionButton
{
	[self.soundSelectionButton addItemsWithTitles:[SoundFileController getSounds]];
	[self.soundSelectionButton insertItemWithTitle:@"" atIndex:0];
	[self.soundSelectionButton selectItemWithTitle:[self.defaults objectForKey:@"selectedSound"]];
	
}

- (IBAction)selectAlertSound:(id)sender {
	[[NSSound soundNamed:self.soundSelectionButton.titleOfSelectedItem]play];
}

- (IBAction)saveAndClose:(id)sender
{
	[self.defaults setObject:self.soundSelectionButton.titleOfSelectedItem forKey:@"selectedSound"];
	[self.defaults setBool:self.sendAlertMessage forKey:@"sendNotification"];
	[self.defaults setBool:self.speakMessage forKey:@"speakNotification"];
	[self.defaults setBool:self.repeatTimer forKey:@"repeatTimer"];
	[self.defaults setObject:self.customMessage forKey:@"customMessage"];
	[self.defaults synchronize];
	
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"prefsSheetShouldClose" object:self]];
}

- (IBAction)cancelChanges:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"prefsSheetShouldClose" object:self]];
}
@end
