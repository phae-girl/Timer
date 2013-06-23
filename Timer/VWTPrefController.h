//
//  VWTPrefController.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-15.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWTPrefController : NSObject

@property (assign, nonatomic) IBOutlet NSPopUpButton *soundSelectionButton;
@property (assign, nonatomic) IBOutlet NSPopover *popover;
@property (assign, nonatomic) IBOutlet NSTextField *popoverLabel, *time;
@property (assign, nonatomic) NSInteger sendAlertMessage, speakMessage, repeatTimer;
@property (copy, nonatomic) NSString *customMessage;

- (IBAction)changeDurationForButton:(id)sender;
- (IBAction)saveAndClose:(id)sender;
- (IBAction)selectAlertSound:(id)sender;
- (IBAction)okButton:(id)sender;


@end
