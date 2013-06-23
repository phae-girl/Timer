//
//  VWTPrefController.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-15.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTPrefController.h"
#import "SoundFileController.h"

@interface VWTPrefController () <NSPopoverDelegate>
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
		NSString *tag = [NSString stringWithFormat:@"%d", i];
		NSString *labelString = [self.defaults objectForKey:tag];
		if (labelString) 
			[self.customTimerButtons[i] setTitle:labelString];
		else
			[self.customTimerButtons[i] setTitle:@"00:00"];
		
	}
	
}

- (IBAction)selectAlertSound:(id)sender {
	[[NSSound soundNamed:self.soundSelectionButton.titleOfSelectedItem]play];
}

// 1 - Open the Popover
// 2 - Get the tag for the sending button
// 3 - Get the updated text string
// 4 - Store the string and tag in a key-value pair
// 5 - Save that to user defaults
// 6 - Close the fucking popover


- (IBAction)changeDurationForButton:(id)sender
{

	_senderTag = [sender tag];
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinXEdge];
	[self.popoverLabel setStringValue:[NSString stringWithFormat:@"%ld", self.senderTag]];
}

- (IBAction)okButton:(id)sender
{
	NSLog(@"%@",[self.time stringValue]);
	NSLog(@"%ld",self.senderTag);
	NSString *buttonTagKey = [NSString stringWithFormat:@"%ld", self.senderTag];
	NSString *buttonTimeValue = [self.time stringValue];
	[self.defaults setObject:buttonTimeValue forKey:buttonTagKey];
	[self.defaults synchronize];
	
	
	//TODO: Validate Time Input
	//TODO: Assign Input to Dictionary
	//TODO: Update button text to new time
	
	[self.popover close];
}
-(void)popoverDidShow:(NSNotification *)notification
{
	
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
