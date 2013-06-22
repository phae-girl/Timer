//
//  VWTPrefController.h
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-15.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWTPrefController : NSObject

@property (assign, nonatomic) NSInteger sendAlertMessage, speakMessage, repeatTimer;
@property (copy, nonatomic) NSString *customMessage;


@property (assign, nonatomic) IBOutlet NSPopUpButton *soundSelectionButton;

- (IBAction)selectAlertSound:(id)sender;
- (IBAction)saveAndClose:(id)sender;


@end
