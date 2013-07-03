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
@property (assign, nonatomic) NSInteger senderTag;
@property (copy, nonatomic) NSArray *customTimerButtons;

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
	_customTimerButtons = @[self.button1,self.button2,self.button3,self.button4,self.button5,self.button6];
	[self populateSoundSelectionButton];
	[self populateButtonTitles];
}

- (void)populateSoundSelectionButton
{
	[self.soundSelectionButton addItemsWithTitles:[SoundFileController getSounds]];
	[self.soundSelectionButton insertItemWithTitle:@"" atIndex:0];
	[self.soundSelectionButton selectItemWithTitle:[self.defaults objectForKey:@"selectedSound"]];
	
}

- (void)populateButtonTitles
{
	for (int i=0; i<[self.customTimerButtons count]; i++) {
		NSString *tag = [NSString stringWithFormat:@"durationForTimerButton%d", i];
		NSString *labelString = [self.defaults objectForKey:tag];
		NSButton *button = self.customTimerButtons[i];
							
		if (labelString) 
			[button setTitle:labelString];
		else
			[button setTitle:@"00:00"];
		[button setFrameSize:NSMakeSize(84,48)];
		[self.view setNeedsDisplay:YES];
	}
	
}

- (IBAction)selectAlertSound:(id)sender {
	[[NSSound soundNamed:self.soundSelectionButton.titleOfSelectedItem]play];
}

- (IBAction)changeDurationForButton:(id)sender
{
	_senderTag = [sender tag];
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinXEdge];
}

- (IBAction)okButton:(id)sender
{
	NSString *buttonTagKey = [NSString stringWithFormat:@"durationForTimerButton%ld", self.senderTag];
	NSString *buttonTimeValue = [self.customDurationEditBox stringValue];
	[self.defaults setObject:buttonTimeValue forKey:buttonTagKey];
	[self.defaults synchronize];
	
	
	//TODO: Validate Time Input
	[self populateButtonTitles];
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"timerDurationsUpdated" object:self]];
	[self.popover close];
}

- (IBAction)cancelButton:(id)sender {
	[self.popover close];
}

- (IBAction)textFieldEndEditing:(id)sender {
	[self okButton:sender];
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
